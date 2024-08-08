import 'package:flutter/material.dart';
import 'package:gemini_app/utils/app_route.dart';
import 'package:get/get.dart';
import 'package:theme_change/theme_change.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Obx(() {
    ThemeChange.themeController.getTheme();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: app_routes,
      theme: ThemeChange.lightTheme,
      darkTheme: ThemeChange.darkTheme,
      themeMode: ThemeChange.themeController.mode.value,
    );
  }));
}
