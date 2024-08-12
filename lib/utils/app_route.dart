import 'package:flutter/material.dart';
import 'package:gemini_app/screen/history/view/history_screen.dart';
import 'package:gemini_app/screen/home/view/home_screen.dart';
import 'package:gemini_app/screen/setting/view/setting_screen.dart';

Map<String, WidgetBuilder> app_routes = {
  // "/": (context) => const SplashScreen(),
  "/": (context) => const HomeScreen(),
  "history": (context) => const HistoryScreen(),
  "setting": (context) => const SettingScreen(),
};
