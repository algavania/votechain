import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:votechain/core/color_values.dart';
import 'package:votechain/core/styles.dart';
import 'package:votechain/widgets/custom_button.dart';
import 'package:votechain/widgets/custom_button_dashboard.dart';

@RoutePage()
class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Admin Dashboard'),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Styles.biggerPadding),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Styles.defaultPadding,
                        vertical: Styles.defaultPadding,
                      ),
                      child: _buildButtonAddLocation(context)),
                  _buildButtonAddTPS(context),
                ],
              ),
              Row(
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Styles.defaultPadding),
                      child: _buildButtonAddCandidate(context)),
                  _buildButtonAddVoters(context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonAddLocation(BuildContext context) {
    return CustomButtonDashboard(
      text: 'Tambah Lokasi',
      prefixIcon: IconsaxPlusBold.location,
      backgroundColor: ColorValues.info10,
      textColor: ColorValues.info50,
      height: 96,
      width: 144,
      onPressed: () {
        AutoRouter.of(context).pushNamed('/add-location');
      },
    );
  }

  Widget _buildButtonAddTPS(BuildContext context) {
    return CustomButtonDashboard(
      text: 'Tambah TPS',
      prefixIcon: IconsaxPlusBold.flag,
      backgroundColor: ColorValues.info10,
      textColor: ColorValues.info50,
      height: 96,
      width: 144,
      onPressed: () {
        AutoRouter.of(context).pushNamed('/add-tps');
      },
    );
  }

  Widget _buildButtonAddCandidate(BuildContext context) {
    return CustomButtonDashboard(
      text: 'Tambah Kandidat',
      prefixIcon: IconsaxPlusBold.people,
      backgroundColor: ColorValues.info10,
      textColor: ColorValues.info50,
      height: 96,
      width: 144,
      onPressed: () {
        AutoRouter.of(context).pushNamed('/add-candidate');
      },
    );
  }

  Widget _buildButtonAddVoters(BuildContext context) {
    return CustomButtonDashboard(
      text: 'Tambah Pemilih',
      prefixIcon: IconsaxPlusBold.user_add,
      backgroundColor: ColorValues.info10,
      textColor: ColorValues.info50,
      height: 96,
      width: 144,
      onPressed: () {
        AutoRouter.of(context).pushNamed('/add-voter');
      },
    );
  }
}
