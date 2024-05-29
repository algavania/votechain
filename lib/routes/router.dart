import 'package:auto_route/auto_route.dart';
import 'package:votechain/features/candidate/view/candidate_page.dart';
import 'package:votechain/features/location/view/location_page.dart';
import 'package:votechain/features/navigator/view/navigator_page.dart';
import 'package:votechain/features/tps/view/tps_page.dart';

import '../features/add_candidate/add_candidate.dart';
import '../features/add_location/add_location.dart';
import '../features/add_tps/view/add_tps_page.dart';
import '../features/add_voter/view/add_voter_page.dart';
import '../features/admin_dashboard/admin_dashboard.dart';
import '../features/pages.dart';

part 'router.gr.dart';

// generate with dart run build_runner build
@AutoRouterConfig(replaceInRouteName: 'Page|Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        CustomRoute(
          page: SplashRoute.page,
          path: '/splash',
          initial: true,
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CustomRoute(
          page: DashboardRoute.page,
          path: '/dashboard',
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CustomRoute(
          page: LoginRoute.page,
          path: '/login',
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CustomRoute(
            page: NavigatorRoute.page,
            path: '/navigator',
            transitionsBuilder: TransitionsBuilders.fadeIn,
            children: [
              CustomRoute(
                page: AdminDashboardRoute.page,
                path: 'admin-dashboard',
                transitionsBuilder: TransitionsBuilders.fadeIn,
              ),
              CustomRoute(
                page: LocationRoute.page,
                path: 'location',
                transitionsBuilder: TransitionsBuilders.fadeIn,
              ),
              CustomRoute(
                page: TpsRoute.page,
                path: 'tps',
                transitionsBuilder: TransitionsBuilders.fadeIn,
              ),
              CustomRoute(
                page: CandidateRoute.page,
                path: 'candidate',
                transitionsBuilder: TransitionsBuilders.fadeIn,
              ),
            ]),
        CustomRoute(
          page: AddCandidateRoute.page,
          path: '/add-candidate',
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CustomRoute(
          page: AddLocationRoute.page,
          path: '/add-location',
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CustomRoute(
          page: AddVoterRoute.page,
          path: '/add-voter',
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CustomRoute(
          page: AddTpsRoute.page,
          path: '/add-tps',
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
      ];
}
