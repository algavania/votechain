abstract class ContractRepository {
  Future<void> initializeContract();

  Future<void> vote({
    required int candidateId,
    required int provinsiId,
    required int kotaId,
    required int kecamatanId,
    required int kelurahanId,
  });

  Future<void> addCandidate();

  Future<void> getCandidates();
}
