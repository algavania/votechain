class CandidateModel {
  final int id;
  final String leadName;
  final String viceName;
  final String imageUrl;
  final String vision;
  final String mission;

  CandidateModel(
      {required this.id,
      required this.leadName,
      required this.viceName,
      required this.imageUrl,
      required this.vision,
      required this.mission});
}
