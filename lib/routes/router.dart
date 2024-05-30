import 'package:auto_route/auto_route.dart';

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
          page: VoteRoute.page,
          path: '/vote',
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
      ];
}
