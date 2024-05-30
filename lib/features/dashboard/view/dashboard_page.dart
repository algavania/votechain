import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:votechain/core/color_values.dart';
import 'package:votechain/core/styles.dart';
import 'package:votechain/data/models/candidate_model.dart';
import 'package:votechain/data/repository/contact_repository.dart';
import 'package:votechain/database/shared_preferences_service.dart';
import 'package:votechain/injector/injector.dart';
import 'package:votechain/routes/router.dart';
import 'package:votechain/utils/logger.dart';
import 'package:votechain/widgets/custom_alert_dialog.dart';
import 'package:votechain/widgets/custom_button.dart';

@RoutePage()
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _repository = Injector.instance<ContractRepository>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(context: context, builder: (_) => CustomAlertDialog(
                  title: 'Konfirmasi',
                  description: 'Apakah kamu yakin ingin logout dari aplikasi?',
                  proceedAction: () {
                    SharedPreferencesService.clearAllPrefs();
                    AutoRouter.of(context).replace(const LoginRoute());
                  },
                  cancelText: 'Tidak',
                  proceedText: 'Ya',
                ));
              },
              icon: const Icon(
                Icons.logout,
                color: ColorValues.danger50,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Styles.defaultPadding),
          child: Center(
            child: Column(
              children: [
                CustomButton(
                  text: 'Voting',
                  onPressed: () {
                    AutoRouter.of(context).push(const VoteRoute());
                  },
                ),
                CustomButton(
                  text: 'Add Candidate',
                  onPressed: () async {
                    try {
                      EasyLoading.show(status: 'Loading...');
                      final candidate1 = CandidateModel(
                        id: 0,
                        leadName: 'Joni Ketsuhat',
                        viceName: 'Jian Denoral',
                        imageUrl: 'https://firebasestorage.googleapis.com/v0/b/ecoin-extend.appspot.com/o/candidate1.png?alt=media&token=6e76a4c4-6a6b-45b2-ba1d-b6a20e121eae',
                        mission: 'JoJi lorem ipsum dolor sit amet mission.',
                        vision: 'JoJi lorem ipsum dolor sit amet vision.',
                      );
                      final candidate2 = CandidateModel(
                        id: 0,
                        leadName: 'Daiki Tempest',
                        viceName: 'MeiMei Jinshi',
                        imageUrl: 'https://firebasestorage.googleapis.com/v0/b/ecoin-extend.appspot.com/o/candidate2.png?alt=media&token=59eeff43-2a7f-4b62-ba09-7fd8c72c3e70',
                        mission: 'DaMe lorem ipsum dolor sit amet mission.',
                        vision: 'DaMe lorem ipsum dolor sit amet vision.',
                      );
                      final candidate3 = CandidateModel(
                        id: 0,
                        leadName: 'Dorothy Nava',
                        viceName: 'Nothan Shirone',
                        imageUrl: 'https://firebasestorage.googleapis.com/v0/b/ecoin-extend.appspot.com/o/candidate3.png?alt=media&token=ca425579-0f9c-4cac-8e99-ff39cc1ca106',
                        mission: 'DoNot lorem ipsum dolor sit amet mission.',
                        vision: 'DoNot l ipsum dolor sit amet vision.',
                      );

                      await _repository.addCandidate(candidate1);
                      await _repository.addCandidate(candidate2);
                      await _repository.addCandidate(candidate3);
                    } catch (e, s) {
                      logger.e(e.toString(), stackTrace: s);
                    }
                    EasyLoading.dismiss();
                  },
                ),
                const SizedBox(
                  height: Styles.defaultSpacing,
                ),
                CustomButton(
                  text: 'Get Candidate',
                  onPressed: () async {
                    try {
                      EasyLoading.show(status: 'Loading...');
                      await _repository.getCandidates();
                    } catch (e, s) {
                      logger.e(e.toString(), stackTrace: s);
                    }
                    EasyLoading.dismiss();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
