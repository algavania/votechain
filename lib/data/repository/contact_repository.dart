import 'package:votechain/data/models/candidate/candidate_model.dart';

abstract class ContractRepository {
  Future<void> initializeContract();

  Future<void> login(String address, String privateKey);

  Future<void> vote({
    required int candidateId,
    required int tpsId,
  });

  Future<void> addCandidate(CandidateModel candidate);

  Future<void> addUser(String ethAddress, bool isAdmin);

  Future<List<CandidateModel>> getCandidates();

  Future<bool> checkIfHasVoted();

  Future<CandidateModel> getWinner();
}
