import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:votechain/core/styles.dart';
import 'package:votechain/widgets/custom_card_candidate.dart';

@RoutePage()
class CandidatePage extends StatelessWidget {
  const CandidatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kandidat'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCandidate1Card(),
              const SizedBox(height: Styles.defaultSpacing),
              _buildCandidate2Card(),
              const SizedBox(height: Styles.defaultSpacing),
              _buildCandidate3Card(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCandidate1Card() {
    return const CustomCardCandidate(
        image: AssetImage('assets/candidate/candidate1.png'),
        name: 'Joni Ketsuhat',
        subvicename: 'Jono Denoral');
  }

  Widget _buildCandidate2Card() {
    return const CustomCardCandidate(
        image: AssetImage('assets/candidate/candidate2.png'),
        name: 'Daiki Tempest',
        subvicename: 'MeiMei Jinshi');
  }

  Widget _buildCandidate3Card() {
    return const CustomCardCandidate(
        image: AssetImage('assets/candidate/candidate3.png'),
        name: 'Dorothy Nava',
        subvicename: 'Nothan Shirone');
  }
}
