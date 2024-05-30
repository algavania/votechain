import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sizer/sizer.dart';
import 'package:votechain/core/styles.dart';
import 'package:votechain/data/repository/contact_repository.dart';
import 'package:votechain/database/data_helper.dart';
import 'package:votechain/database/db_helper.dart';
import 'package:votechain/database/shared_preferences_service.dart';
import 'package:votechain/injector/injector.dart';
import 'package:votechain/routes/router.dart';
import 'package:votechain/utils/extensions.dart';
import 'package:votechain/widgets/custom_button.dart';
import 'package:votechain/widgets/custom_text_field.dart';
import 'package:web3dart/credentials.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _addressController = TextEditingController();
  final _privateKeyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    debugPrint('build test');
    return Scaffold(
      body: Container(
        height: 100.h,
        width: 100.w,
        padding: const EdgeInsets.all(Styles.defaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                controller: _addressController,
                hintText: 'ETH Address',
              ),
              const SizedBox(height: Styles.defaultSpacing,),
              CustomTextField(
                controller: _privateKeyController,
                hintText: 'Private Key',
              ),
              const SizedBox(height: Styles.bigSpacing,),
              CustomButton(
                text: 'Login',
                onPressed: () async {
                  try {
                    EasyLoading.show();
                    final address = _addressController.text.trimLeft().trimRight();
                    final hex = _privateKeyController.text.trimLeft().trimRight();
                    DbHelper.privateKey = EthPrivateKey.fromHex(hex);
                    DbHelper.ethAddress = address;
                    SharedPreferencesService.setAddress(value: address);
                    SharedPreferencesService.setPrivateKey(value: hex);
                    DataHelper.candidates = await Injector.instance<ContractRepository>()
                        .getCandidates();
                    EasyLoading.dismiss();
                    AutoRouter.of(context).replace(const DashboardRoute());
                  } catch (e) {
                    EasyLoading.dismiss();
                    context.showSnackBar(message: e.toString(), isSuccess: false);
                  }
                },
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
