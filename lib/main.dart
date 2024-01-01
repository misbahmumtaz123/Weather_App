import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherapp/view/reuseable/themes.dart';
import 'package:weatherapp/view/screens/StartScreen.dart';
import 'Controller/controllerMain.dart';


void main() {
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ControllerMain controllerMain = Get.put(ControllerMain());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: CustomThemes.lightTheme,
      darkTheme: CustomThemes.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => StartScreen()),
        // GetPage(name: '/uimain', page: () => UIMain()),
        // GetPage(name: '/sevendays', page: () => SevenDayScreen()),

      ],
    );
  }
}
