// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
pragma experimental ABIEncoderV2;

contract Election {
    struct Candidate {
        uint256 id;
        string leadName;
        string viceName;
        string imageUrl;
        string vision;
        string mission;
        uint256 voteCount;
    }

    struct Vote {
        uint256 candidateId;
        address voter;
        bytes32 previousVoteHash;
    }

    struct TPS {
        uint256 id;
        string name;
        uint256 kelurahanId;
        uint256 voteCount;
        bytes32 lastVoteHash;
        mapping(bytes32 => Vote) votes;
        mapping(address => bool) voters;
    }

    struct Kelurahan {
        uint256 id;
        string name;
        uint256 kecamatanId;
        uint256 voteCount;
    }

    struct Kecamatan {
        uint256 id;
        string name;
        uint256 kotaId;
        uint256 voteCount;
    }

    struct Kota {
        uint256 id;
        string name;
        uint256 provinsiId;
        uint256 voteCount;
    }

    struct Provinsi {
        uint256 id;
        string name;
        uint256 voteCount;
    }

    mapping(uint256 => Candidate) public candidates;
    uint256 public candidatesCount;

    mapping(uint256 => TPS) public tpsData;
    uint256 public tpsCount;

    mapping(uint256 => Kelurahan) public kelurahanData;
    uint256 public kelurahanCount;

    mapping(uint256 => Kecamatan) public kecamatanData;
    uint256 public kecamatanCount;

    mapping(uint256 => Kota) public kotaData;
    uint256 public kotaCount;

    mapping(uint256 => Provinsi) public provinsiData;
    uint256 public provinsiCount;

    constructor() public {
        candidatesCount = 0;
        tpsCount = 0;
        kelurahanCount = 0;
        kecamatanCount = 0;
        kotaCount = 0;
        provinsiCount = 0;
    }

    function addCandidate(string memory _leadName,
        string memory _viceName, string memory _imageUrl,
        string memory _vision, string memory _mission) public {
        candidatesCount++;
        candidates[candidatesCount].id = candidatesCount;
        candidates[candidatesCount].leadName = _leadName;
        candidates[candidatesCount].viceName = _viceName;
        candidates[candidatesCount].imageUrl = _imageUrl;
        candidates[candidatesCount].vision = _vision;
        candidates[candidatesCount].mission = _mission;
        candidates[candidatesCount].voteCount = 0;
    }

    function addTPS(string memory _name, uint256 _kelurahanId) public {
        tpsCount++;
        tpsData[tpsCount].id = tpsCount;
        tpsData[tpsCount].name = _name;
        tpsData[tpsCount].kelurahanId = _kelurahanId;
        tpsData[tpsCount].voteCount = 0;
        tpsData[tpsCount].lastVoteHash = bytes32(0);
    }

    function vote(uint256 _candidateId, uint256 _tpsId) public {
        require(!tpsData[_tpsId].voters[msg.sender], "You have already voted in this TPS");
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate ID");

        // Create the new vote
        bytes32 previousVoteHash = tpsData[_tpsId].lastVoteHash;
        bytes32 currentVoteHash = keccak256(abi.encodePacked(_candidateId, msg.sender, previousVoteHash));

        Vote memory newVote = Vote({
            candidateId: _candidateId,
            voter: msg.sender,
            previousVoteHash: previousVoteHash
        });

// Record the vote
        tpsData[_tpsId].votes[currentVoteHash] = newVote;
        tpsData[_tpsId].lastVoteHash = currentVoteHash;
        tpsData[_tpsId].voteCount++;
        tpsData[_tpsId].voters[msg.sender] = true;

// Increment the candidate's vote count
        candidates[_candidateId].voteCount++;
    }

    function addKelurahan(string memory _name, uint256 _kecamatanId) public {
        kelurahanCount++;
        kelurahanData[kelurahanCount] = Kelurahan(kelurahanCount, _name, _kecamatanId, 0);
    }

    function addKecamatan(string memory _name, uint256 _kotaId) public {
        kecamatanCount++;
        kecamatanData[kecamatanCount] = Kecamatan(kecamatanCount, _name, _kotaId, 0);
    }

    function addKota(string memory _name, uint256 _provinsiId) public {
        kotaCount++;
        kotaData[kotaCount] = Kota(kotaCount, _name, _provinsiId, 0);
    }

    function addProvinsi(string memory _name) public {
        provinsiCount++;
        provinsiData[provinsiCount] = Provinsi(provinsiCount, _name, 0);
    }

    function validateVotes(uint256 _tpsId) public view returns (bool) {
        uint256 voteCount = tpsData[_tpsId].voteCount;
        uint256 validVotes = 0;

        bytes32 currentHash = tpsData[_tpsId].lastVoteHash;
        while (currentHash != bytes32(0)) {
            Vote memory currentVote = tpsData[_tpsId].votes[currentHash];
            bytes32 calculatedHash = keccak256(abi.encodePacked(currentVote.candidateId, currentVote.voter, currentVote.previousVoteHash));
            if (calculatedHash == currentHash) {
                validVotes++;
            }
            currentHash = currentVote.previousVoteHash;
        }

        return validVotes >= (voteCount * 51) / 100;
    }

    function calculateVotes() public {
        for (uint256 i = 1; i <= tpsCount; i++) {
            require(validateVotes(i), "TPS votes validation failed");
            uint256 kelurahanId = tpsData[i].kelurahanId;
            kelurahanData[kelurahanId].voteCount += tpsData[i].voteCount;
        }

        for (uint256 i = 1; i <= kelurahanCount; i++) {
            uint256 kecamatanId = kelurahanData[i].kecamatanId;
            kecamatanData[kecamatanId].voteCount += kelurahanData[i].voteCount;
        }

        for (uint256 i = 1; i <= kecamatanCount; i++) {
            uint256 kotaId = kecamatanData[i].kotaId;
            kotaData[kotaId].voteCount += kecamatanData[i].voteCount;
        }

        for (uint256 i = 1; i <= kotaCount; i++) {
            uint256 provinsiId = kotaData[i].provinsiId;
            provinsiData[provinsiId].voteCount += kotaData[i].voteCount;
        }
    }

    function getWinner() public returns (Candidate memory) {
        calculateVotes();

        Candidate memory winner = candidates[1];
        for (uint256 i = 2; i <= candidatesCount; i++) {
            if (candidates[i].voteCount > winner.voteCount) {
                winner = candidates[i];
            }
        }

        return winner;
    }

    function getCandidates() public view returns (Candidate[] memory) {
        Candidate[] memory candidateList = new Candidate[](candidatesCount);
        for (uint256 i = 1; i <= candidatesCount; i++) {
            candidateList[i - 1] = candidates[i];
        }
        return candidateList;
    }

    function getTPSVotes(uint256 _tpsId) public view returns (Vote[] memory) {
        uint256 voteCount = tpsData[_tpsId].voteCount;
        Vote[] memory votes = new Vote[](voteCount);

        bytes32 currentHash = tpsData[_tpsId].lastVoteHash;
        for (uint256 i = voteCount; i > 0; i--) {
            votes[i - 1] = tpsData[_tpsId].votes[currentHash];
            currentHash = votes[i - 1].previousVoteHash;
        }

        return votes;
    }
}
