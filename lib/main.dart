import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:mobilproje/app/bindings/root_binding.dart';
import 'package:mobilproje/app/bindings/splash_binding.dart';
import 'app/bindings/login_binding.dart';
import 'app/ui/pages/login_page/login_page.dart';
import 'app/ui/pages/root_page/root_page.dart';
import 'app/ui/pages/splash_page/splash_page.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  initServices();

  runApp(
    const MyApp(),
  );
}

initServices() async {
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ],
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      enableLog: true,
      navigatorKey: Get.key,
      logWriterCallback: localLogWriter,
      title: "Tedarik - Tedarikci Uygulaması",
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.cupertino,
      opaqueRoute: Get.isOpaqueRouteDefault,
      popGesture: Get.isPopGestureEnable,
      transitionDuration: Get.defaultTransitionDuration,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('tr'),
      ],
      initialRoute: "/splash",
      getPages: [
        GetPage(
          name: "/splash",
          page: () => const SplashPage(),
          binding: SplashBinding(),
        ),
        GetPage(
          name: "/root",
          page: () => const RootPage(),
          binding: RootBinding(),
        ),
        GetPage(
          name: "/login",
          page: () => const LoginPage(),
          binding: LoginBinding(),
        ),
      ],
    );
  }

  void localLogWriter(String text, {bool isError = false}) {
    if (kDebugMode) {
      debugPrint(text);

      return;
    }
  }
}
