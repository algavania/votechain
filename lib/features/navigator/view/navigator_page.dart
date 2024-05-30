import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:votechain/core/color_values.dart';
import 'package:votechain/core/styles.dart';
import 'package:votechain/routes/router.dart';

@RoutePage()
class NavigatorPage extends StatefulWidget {
  const NavigatorPage({super.key});

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.pageView(
      routes: const [
        AdminDashboardRoute(),
        LocationRoute(),
        TpsRoute(),
        CandidateRoute(),
      ],
      builder: (context, child, _) {
        final TabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          body: child,
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Styles.bigPadding),
            child: NavigationBar(
              selectedIndex: TabsRouter.activeIndex,
              onDestinationSelected: TabsRouter.setActiveIndex,
              destinations: const [
                NavigationDestination(
                  icon: Icon(IconsaxPlusBold.home),
                  label: 'Dashboard',
                ),
                NavigationDestination(
                  icon: Icon(IconsaxPlusBold.location),
                  label: 'Lokasi',
                ),
                NavigationDestination(
                  icon: Icon(IconsaxPlusBold.flag),
                  label: 'TPS',
                ),
                NavigationDestination(
                  icon: Icon(Icons.location_on),
                  label: 'Kandidat',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
