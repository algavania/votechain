import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:votechain/core/styles.dart';
import 'package:votechain/features/contract/data/repository/contact_repository.dart';
import 'package:votechain/injector/injector.dart';
import 'package:votechain/utils/logger.dart';
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Styles.defaultPadding),
          child: Center(
            child: Column(
              children: [
                CustomButton(text: 'Add Candidate', onPressed: () async {
                  try {
                    EasyLoading.show(status: 'Loading...');
                    await _repository.addCandidate();
                  } catch (e, s) {
                    logger.e(e.toString(), stackTrace: s);
                  }
                  EasyLoading.dismiss();
                },),
                const SizedBox(height: Styles.defaultSpacing,),
                CustomButton(text: 'Get Candidate', onPressed: () async {
                  try {
                    EasyLoading.show(status: 'Loading...');
                    await _repository.getCandidates();
                  } catch (e, s) {
                    logger.e(e.toString(), stackTrace: s);
                  }
                  EasyLoading.dismiss();
                },),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
