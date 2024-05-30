import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:votechain/core/styles.dart';
import 'package:votechain/data/repository/contact_repository.dart';
import 'package:votechain/database/data_helper.dart';
import 'package:votechain/database/db_helper.dart';
import 'package:votechain/database/shared_preferences_service.dart';
import 'package:votechain/injector/injector.dart';
import 'package:votechain/routes/router.dart';
import 'package:votechain/utils/extensions.dart';
import 'package:web3dart/credentials.dart';

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

  Future<void> _init() async {
    await Injector.instance<ContractRepository>()
        .initializeContract();
    late PageRouteInfo page;
    if (SharedPreferencesService.getAddress() != null) {
      final privateKey = SharedPreferencesService.getPrivateKey();
      final address = SharedPreferencesService.getAddress();
      DbHelper.privateKey = EthPrivateKey.fromHex(privateKey!);
      DbHelper.ethAddress = address;
      page = const DashboardRoute();
      DataHelper.candidates = await Injector.instance<ContractRepository>()
          .getCandidates();
    } else {
      page = const LoginRoute();
    }

    Future.delayed(const Duration(seconds: 2), () {
      AutoRouter.of(context).replace(page);
    });
  }

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
          ],
        ),
      ),
    );
  }
}
