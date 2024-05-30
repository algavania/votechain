import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:votechain/core/styles.dart';
import 'package:iconsax/iconsax.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:votechain/core/color_values.dart';
import 'package:votechain/core/styles.dart';
import 'package:votechain/routes/router.dart';
import 'package:votechain/widgets/custom_button.dart';
import 'package:votechain/widgets/custom_drop_down_field.dart';
import 'package:votechain/widgets/custom_text_field.dart';

@RoutePage()
class AddLocationPage extends StatelessWidget {
  const AddLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Lokasi'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: Styles.defaultPadding,
              ),
              _buildProvinceButton(context),
              const SizedBox(
                height: Styles.defaultPadding,
              ),
              _buildCityButton(context),
              const SizedBox(
                height: Styles.defaultPadding,
              ),
              _buildDistrictButton(context),
              const SizedBox(
                height: Styles.defaultPadding,
              ),
              _buildSubDistrictButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProvinceButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Styles.bigPadding),
      child: CustomButton(
        text: 'Provinsi',
        onPressed: () {
          context.router.push(const AddProvinceRoute());
        },
        backgroundColor: ColorValues.info50,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }

  Widget _buildCityButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Styles.bigPadding),
      child: CustomButton(
        text: 'Kota/Kabupaten',
        onPressed: () {
          context.router.push(const AddCityRoute());
        },
        backgroundColor: ColorValues.info50,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }

  Widget _buildDistrictButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Styles.bigPadding),
      child: CustomButton(
        text: 'Kecamatan',
        onPressed: () {
          context.router.push(const AddDistrictRoute());
        },
        backgroundColor: ColorValues.info50,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }

  Widget _buildSubDistrictButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Styles.bigPadding),
      child: CustomButton(
        text: 'Kelurahan/Desa',
        onPressed: () {
          context.router.push(const AddSubDistrictRoute());
        },
        backgroundColor: ColorValues.info50,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
