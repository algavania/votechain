import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:votechain/core/styles.dart';
import 'package:votechain/database/db_helper.dart';
import 'package:votechain/routes/router.dart';
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
              CustomButton(
                text: 'Login',
                onPressed: () {
                  var hex = '0xf456b2b260b646040c933b3ba7741560afc84f3fe326e774b3e193aa5c3743b6';
                  hex = hex.trimLeft().trimRight();
                  DbHelper.privateKey = EthPrivateKey.fromHex(hex);
                  AutoRouter.of(context).replace(const DashboardRoute());
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
