import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/routes.dart';

import 'core/services/services.dart';
import 'initialbinding.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ar', 'DZ'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('ar', 'DZ'),
      child: DevicePreview(
        builder: (context) => const MyApp(),
        enabled: false,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      title: 'StudentsApp',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.teal,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Cairo',
        textTheme: TextTheme(
          bodySmall: TextStyle(
            color: Get.theme.primaryColor.withOpacity(0.5),
            fontWeight: FontWeight.normal,
          ),
          bodyLarge: TextStyle(
            color: Get.theme.primaryColor,
            fontWeight: FontWeight.normal,
          ),
        ),
      
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Get.theme.primaryColor,
        ),
      ),
      getPages: routes,
      initialBinding: InitialBinding(),
    );
  }
}
