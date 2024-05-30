import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:votechain/core/color_values.dart';
import 'package:votechain/core/styles.dart';
import 'package:votechain/widgets/custom_button.dart';
import 'package:votechain/widgets/custom_text_field.dart';

@RoutePage()
class AddDistrictPage extends StatelessWidget {
  const AddDistrictPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kecamatan'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildProvinceList(),
              const SizedBox(height: Styles.defaultPadding),
              _buildCityList(),
              const SizedBox(height: Styles.defaultPadding),
              _buildDistrictNameField(),
              const SizedBox(height: Styles.bigPadding),
              _buildButtonSubmit(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProvinceList() {
    return GestureDetector(
      onTap: () {},
      child: CustomTextField(
        controller: TextEditingController(),
        hintText: 'Provinsi',
        borderColor: ColorValues.info50,
        isRequired: true,
      ),
    );
  }

  Widget _buildCityList() {
    return GestureDetector(
      onTap: () {},
      child: CustomTextField(
        controller: TextEditingController(),
        hintText: 'Kota/Kabupaten',
        borderColor: ColorValues.info50,
        isRequired: true,
      ),
    );
  }

  Widget _buildDistrictNameField() {
    return CustomTextField(
      controller: TextEditingController(),
      hintText: 'Nama Kecamatan',
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
