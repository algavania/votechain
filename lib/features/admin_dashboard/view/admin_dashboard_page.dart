import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:votechain/core/color_values.dart';
import 'package:votechain/core/styles.dart';
import 'package:votechain/data/repository/contact_repository.dart';
import 'package:votechain/injector/injector.dart';
import 'package:votechain/widgets/custom_button_dashboard.dart';

@RoutePage()
class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Styles.biggerPadding),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(child: _buildButtonAddLocation(context)),
                const SizedBox(width: Styles.defaultSpacing,),
                Expanded(child: _buildButtonAddTPS(context)),
              ],
            ),
            const SizedBox(height: Styles.defaultSpacing,),
            Row(
              children: [
                Expanded(child: _buildButtonAddCandidate(context)),
                const SizedBox(width: Styles.defaultSpacing,),
                Expanded(child: _buildButtonAddVoters(context)),
              ],
            ),
            const SizedBox(height: Styles.defaultSpacing,),
            CustomButtonDashboard(
              text: 'Siapa menang?',
              prefixIcon: IconsaxPlusBold.location,
              backgroundColor: ColorValues.info10,
              textColor: ColorValues.info50,
              height: 96,
              onPressed: () {
                Injector.instance<ContractRepository>().getWinner();
              },
            )
          ],
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
      onPressed: () {
        AutoRouter.of(context).pushNamed('/add-voter');
      },
    );
  }
}
