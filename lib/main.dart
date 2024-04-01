import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/screens/splash.dart';
import 'controller/auth_controller.dart';
import 'firebase_options.dart';
import 'theme/app_theme.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(AuthenicationController()));
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appThemeData,
      getPages: [
        GetPage(name: '/', page: () => SplashScreen()),
      ],
      initialRoute: '/',
      home: Scaffold(
        body: SplashScreen(),
      ),
    );
  }
}
