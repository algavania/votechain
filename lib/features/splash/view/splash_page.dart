import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:votechain/core/styles.dart';
import 'package:votechain/features/contract/data/repository/contact_repository.dart';
import 'package:votechain/injector/injector.dart';
import 'package:votechain/routes/router.dart';
import 'package:votechain/utils/extensions.dart';
import 'package:votechain/utils/logger.dart';
import 'package:votechain/widgets/custom_button.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    _init();
    super.initState();
  }

  Future<void> _init() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(Styles.defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'VoteChain',
              style: context.textTheme.titleExtraLarge,
              textAlign: TextAlign.center,
            ),
            CustomButton(
              text: 'Test',
              onPressed: () async {
                try {
                  await Injector.instance<ContractRepository>()
                      .initializeContract();
                  AutoRouter.of(context).push(const LoginRoute());
                } catch (e, s) {
                  logger.e(e.toString(), stackTrace: s);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
