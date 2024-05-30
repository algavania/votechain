import 'package:votechain/data/models/candidate_model.dart';

abstract class ContractRepository {
  Future<void> initializeContract();

  Future<void> vote({
    required int candidateId,
    required int tpsId,
  });

  Future<void> addCandidate(CandidateModel candidate);

  Future<List<CandidateModel>> getCandidates();
}
