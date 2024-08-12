import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gemini_app/screen/history/controller/history_controller.dart';
import 'package:gemini_app/screen/home/controller/home_controller.dart';
import 'package:gemini_app/screen/splash/model/db_model.dart';
import 'package:gemini_app/utils/db_helper.dart';
import 'package:gemini_app/utils/network.dart';
import 'package:gemini_app/utils/text_style.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:theme_change/theme_change.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.put(HomeController());
  TextEditingController txtSearch = TextEditingController();

  HistoryController lController = Get.put(HistoryController());
  NetworkConnection connection = NetworkConnection();
  ItemScrollController itemScrollController = ItemScrollController();
  ScrollOffsetController scrollOffsetController = ScrollOffsetController();
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  ScrollOffsetListener scrollOffsetListener = ScrollOffsetListener.create();
  @override
  void initState() {
    super.initState();
    connection.checkConnection();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Gemini AI', style: comic),
          actions: [
            IconButton(
                onPressed: () {
                  Get.toNamed('setting');
                },
                icon: Icon(Icons.settings))
          ],
        ),
        body: Obx(
          () => controller.isOnline.value
              ? Stack(
                  children: [
                    ThemeChange.themeController.pTheme.value == true
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
                    Obx(
                      () => Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              reverse: true,
                              itemCount: controller.list.length,
                              itemBuilder: (context, index) {
                                final reversedIndex =
                                    controller.list.length - index - 1;
                                return Align(
                                  alignment: controller.list[index].status == 0
                                      ? Alignment.centerLeft
                                      : Alignment.centerRight,
                                  child: Container(
                                    margin: const EdgeInsets.all(8),
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color: controller.list[index].status == 0
                                          ? const Color(0xff141E46)
                                          : const Color(0xffEFFFFB),
                                      borderRadius: BorderRadius.only(
                                          topLeft: const Radius.circular(15),
                                          topRight: const Radius.circular(15),
                                          bottomLeft: Radius.circular(
                                              controller.list[index].status == 0
                                                  ? 15
                                                  : 0),
                                          bottomRight: Radius.circular(
                                              controller.list[index].status == 0
                                                  ? 0
                                                  : 15)),
                                    ),
                                    child: SelectableText(
                                      '${controller.list[reversedIndex].result}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'comic',
                                          fontWeight: FontWeight.bold,
                                          color:
                                              controller.list[index].status == 0
                                                  ? Colors.white
                                                  : Colors.black),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          ValueListenableBuilder(
                            valueListenable: controller.isLoading,
                            builder: (BuildContext context, dynamic value,
                                Widget? child) {
                              if (!value) {
                                return const SizedBox();
                              }
                              return const SpinKitThreeBounce(
                                  color: Colors.deepPurple, size: 30);
                            },
                          ),
                          const SizedBox(height: 80),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: SizedBox(
                          height: 55,
                          child: SearchBar(
                            controller: txtSearch,
                            elevation: WidgetStateProperty.all(1),
                            hintText: 'Message Gemini...',
                            trailing: [
                              ValueListenableBuilder(
                                valueListenable: controller.isLoading,
                                builder: (BuildContext context, dynamic value,
                                    Widget? child) {
                                  if (value) {
                                    return const SpinKitFadingCircle(
                                        size: 30, color: Colors.deepPurple);
                                  }
                                  return InkWell(
                                    onTap: () async {
                                      DbModel dbModel = DbModel(
                                          result: txtSearch.text, status: 0);
                                      DbHelper.dbHelper.insertData(dbModel);
                                      controller.chatList.add(dbModel);
                                      controller.list.add(dbModel);
                                      await controller.getData(txtSearch.text);
                                      txtSearch.clear();
                                    },
                                    child: AvatarGlow(
                                      startDelay: Duration(milliseconds: 1500),
                                      glowColor: Colors.white12,
                                      glowShape: BoxShape.circle,
                                      animate: true,
                                      curve: Curves.fastOutSlowIn,
                                      child: const Icon(Icons.send,
                                          size: 25, color: Colors.deepPurple),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Center(
                  child: Text('Please Check Internet Connection', style: comic),
                ),
        ),
      ),
    );
  }
}
