import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sizer/sizer.dart';
import 'package:votechain/core/app_text_styles.dart';
import 'package:votechain/core/app_theme_data.dart';
import 'package:votechain/database/shared_preferences_service.dart';
import 'package:votechain/injector/injector.dart';
import 'package:votechain/routes/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Injector.init();
  await SharedPreferencesService.init();
  await Injector.instance.allReady();

  runApp(const MyApp());
}

final appRouter = AppRouter();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return AppTheme(
          textTheme: AppTextStyles.style(context),
          child: MaterialApp.router(
            theme: votechainThemeData(context),
            routerDelegate: appRouter.delegate(),
            routeInformationParser: appRouter.defaultRouteParser(),
            debugShowCheckedModeBanner: false,
            builder: EasyLoading.init(),
          ),
        );
      },
    );
  }
}
