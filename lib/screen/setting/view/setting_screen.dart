import 'package:flutter/material.dart';
import 'package:gemini_app/screen/history/controller/history_controller.dart';
import 'package:gemini_app/utils/text_style.dart';
import 'package:get/get.dart';
import 'package:theme_change/theme_change.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  HistoryController lController = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Setting', style: comic),
        ),
        body: Stack(
          children: [
            Obx(
              () => ThemeChange.themeController.pTheme.value == true
                  ? Image.asset(
                      "assets/image/dark.png",
                      height: MediaQuery.sizeOf(context).height,
                      width: MediaQuery.sizeOf(context).width,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      "assets/image/light1.png",
                      height: MediaQuery.sizeOf(context).height,
                      width: MediaQuery.sizeOf(context).width,
                      fit: BoxFit.cover,
                    ),
            ),
            Column(
              children: [
                ListTile(
                  title: Text("Theme", style: comic20),
                  trailing: IconButton(
                      onPressed: () {
                        ThemeChange.themeController.setTheme();
                      },
                      icon: Obx(() =>
                          Icon(ThemeChange.themeController.themeMode.value))),
                ),
                ListTile(
                  onTap: () => Get.toNamed('history'),
                  leading: Icon(Icons.history_outlined),
                  title: Text('Search History', style: comic20),
                  trailing: Icon(Icons.arrow_forward_ios_outlined, size: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
