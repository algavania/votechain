import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:votechain/core/color_values.dart';
import 'package:votechain/core/styles.dart';
import 'package:votechain/widgets/custom_button.dart';
import 'package:votechain/widgets/custom_text_field.dart';

@RoutePage()
class AddProvincePage extends StatelessWidget {
  const AddProvincePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Provinsi'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildProvinceNameField(),
              const SizedBox(height: Styles.bigPadding),
              _buildButtonSubmit(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProvinceNameField() {
    return CustomTextField(
      controller: TextEditingController(),
      hintText: 'Nama Provinsi',
      borderColor: ColorValues.info50,
      isRequired: true,
    );
  }

  Widget _buildButtonSubmit(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Styles.bigPadding),
      child: CustomButton(
        text: 'Tambah',
        onPressed: () {},
        backgroundColor: ColorValues.info50,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
