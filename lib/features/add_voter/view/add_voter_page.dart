import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:votechain/core/color_values.dart';
import 'package:votechain/core/styles.dart';
import 'package:votechain/widgets/custom_button.dart';
import 'package:votechain/widgets/custom_text_field.dart';

@RoutePage()
class AddVoterPage extends StatelessWidget {
  const AddVoterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Voter'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildEthAddressField(),
              const SizedBox(height: Styles.defaultPadding),
              _buildTPSField(),
              const SizedBox(height: Styles.extraBigPadding),
              _buildButtonSubmit(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEthAddressField() {
    return CustomTextField(
      controller: TextEditingController(),
      hintText: 'Alamat Ethereum',
      borderColor: ColorValues.info50,
      isRequired: true,
    );
  }

  Widget _buildTPSField() {
    return CustomTextField(
      controller: TextEditingController(),
      hintText: 'TPS',
      borderColor: ColorValues.info50,
      isRequired: true,
    );
  }

  Widget _buildButtonSubmit(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Styles.defaultPadding),
      child: CustomButton(
        text: 'Tambah',
        onPressed: () {},
        backgroundColor: ColorValues.info50,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
