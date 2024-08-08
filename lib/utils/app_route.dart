import 'package:flutter/material.dart';
import 'package:gemini_app/screen/home/view/home_screen.dart';

Map<String, WidgetBuilder> app_routes = {
  // "/": (context) => const SplashScreen(),
  "/": (context) => const HomeScreen(),
};
