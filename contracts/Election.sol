// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
pragma experimental ABIEncoderV2;

contract Election {
  struct Candidate {
    uint id;
    string leadName;
    string viceName;
    string vision;
    string mission;
    uint voteCount;
  }

  struct TPS {
    uint id;
    string name;
    mapping(address => bool) voters;
    uint voterCount;
  }

  struct Kelurahan {
    uint id;
    string name;
    mapping(uint => TPS) tpsList;
    uint tpsCount;
  }

  struct Kecamatan {
    uint id;
    string name;
    mapping(uint => Kelurahan) kelurahanList;
    uint kelurahanCount;
  }

  struct KabupatenKota {
    uint id;
    string name;
    mapping(uint => Kecamatan) kecamatanList;
    uint kecamatanCount;
  }

  struct Provinsi {
    uint id;
    string name;
    mapping(uint => KabupatenKota) kabupatenKotaList;
    uint kabupatenKotaCount;
  }

  mapping(uint => Provinsi) public provinsiList;
  uint public provinsiCount;
  mapping(uint => Candidate) public candidates;
  uint public candidatesCount;

  mapping(address => bool) public hasVoted;

  function addCandidate(
    string memory leadName,
    string memory viceName,
    string memory vision,
    string memory mission
  ) public {
    candidatesCount++;
    candidates[candidatesCount] = Candidate(
      candidatesCount,
      leadName,
      viceName,
      vision,
      mission,
      0
    );
  }

  function getCandidates() public view returns (Candidate[] memory) {
    Candidate[] memory candidateList = new Candidate[](candidatesCount);
    for (uint i = 0; i < candidatesCount; i++) {
      candidateList[i] = candidates[i];
    }
    return candidateList;
  }

  function getTesting() public view returns (bool) {
    return false;
  }

  function addTPS(uint kelurahanId, uint kecamatanId, uint kabupatenKotaId, uint provinsiId, string memory name) public {
    Provinsi storage provinsi = provinsiList[provinsiId];
    KabupatenKota storage kabupatenKota = provinsi.kabupatenKotaList[kabupatenKotaId];
    Kecamatan storage kecamatan = kabupatenKota.kecamatanList[kecamatanId];
    Kelurahan storage kelurahan = kecamatan.kelurahanList[kelurahanId];

    kelurahan.tpsCount++;
    kelurahan.tpsList[kelurahan.tpsCount] = TPS(kelurahan.tpsCount, name, 0);
  }

  function addKelurahan(uint kecamatanId, uint kabupatenKotaId, uint provinsiId, string memory name) public {
    Provinsi storage provinsi = provinsiList[provinsiId];
    KabupatenKota storage kabupatenKota = provinsi.kabupatenKotaList[kabupatenKotaId];
    Kecamatan storage kecamatan = kabupatenKota.kecamatanList[kecamatanId];

    kecamatan.kelurahanCount++;
    kecamatan.kelurahanList[kecamatan.kelurahanCount] = Kelurahan(kecamatan.kelurahanCount, name, 0);
  }

  function addKecamatan(uint kabupatenKotaId, uint provinsiId, string memory name) public {
    Provinsi storage provinsi = provinsiList[provinsiId];
    KabupatenKota storage kabupatenKota = provinsi.kabupatenKotaList[kabupatenKotaId];

    kabupatenKota.kecamatanCount++;
    kabupatenKota.kecamatanList[kabupatenKota.kecamatanCount] = Kecamatan(kabupatenKota.kecamatanCount, name, 0);
  }

  function addKabupatenKota(uint provinsiId, string memory name) public {
    Provinsi storage provinsi = provinsiList[provinsiId];

    provinsi.kabupatenKotaCount++;
    provinsi.kabupatenKotaList[provinsi.kabupatenKotaCount] = KabupatenKota(provinsi.kabupatenKotaCount, name, 0);
  }

  function addProvinsi(string memory name) public {
    provinsiCount++;
    provinsiList[provinsiCount] = Provinsi(provinsiCount, name, 0);
  }

  function vote(uint candidateId, uint tpsId, uint kelurahanId, uint kecamatanId, uint kabupatenKotaId, uint provinsiId) public {
    require(!hasVoted[msg.sender], "You have already voted in this election");

    Candidate storage candidate = candidates[candidateId];

    Provinsi storage provinsi = provinsiList[provinsiId];
    KabupatenKota storage kabupatenKota = provinsi.kabupatenKotaList[kabupatenKotaId];
    Kecamatan storage kecamatan = kabupatenKota.kecamatanList[kecamatanId];
    Kelurahan storage kelurahan = kecamatan.kelurahanList[kelurahanId];
    TPS storage tps = kelurahan.tpsList[tpsId];

    require(!tps.voters[msg.sender], "You have already voted in this TPS");

    tps.voters[msg.sender] = true;
    tps.voterCount++;
    candidate.voteCount++;

    hasVoted[msg.sender] = true;
  }
}
