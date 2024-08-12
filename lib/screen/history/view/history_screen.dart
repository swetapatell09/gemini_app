import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gemini_app/screen/history/controller/history_controller.dart';
import 'package:gemini_app/screen/home/controller/home_controller.dart';
import 'package:gemini_app/utils/db_helper.dart';
import 'package:gemini_app/utils/text_style.dart';
import 'package:get/get.dart';
import 'package:theme_change/theme_change.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _LikeScreenState();
}

class _LikeScreenState extends State<HistoryScreen> {
  HomeController controller = Get.put(HomeController());
  HistoryController lController = Get.put(HistoryController());

  @override
  void initState() {
    super.initState();
    controller.dbData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('History', style: comic),
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
            Obx(
              () => controller.chatList.isEmpty
                  ? const Center(child: Text('No Data'))
                  : AnimationLimiter(
                      child: ListView.builder(
                        itemCount: controller.chatList.length,
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: Duration(milliseconds: 500),
                            child: SlideAnimation(
                              verticalOffset: 50,
                              child: FadeInAnimation(
                                child: Align(
                                  alignment:
                                      controller.chatList[index].status == 0
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                  child: Container(
                                    padding: const EdgeInsets.all(15),
                                    margin: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: ThemeChange.themeController
                                                      .pTheme.value ==
                                                  true
                                              ? [
                                                  Colors.white.withOpacity(0.4),
                                                  Colors.blue.withOpacity(0.4)
                                                ]
                                              : [
                                                  Colors.red.withOpacity(0.25),
                                                  Colors.blue.withOpacity(0.25)
                                                ],
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SelectableText(
                                            '${controller.chatList[index].result}',
                                            style: txt18),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: IconButton(
                                              onPressed: () {
                                                deleteDialog(context, index);
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> deleteDialog(BuildContext context, int index) async {
    bool isDeleted = false;
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Are you sure to Delete',
            style: TextStyle(fontFamily: 'comic'),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      isDeleted = true;
                      DbHelper.dbHelper
                          .deleteData(id: controller.chatList[index].id!);
                      controller.dbData();
                      Get.back();
                      Get.snackbar('Delete', 'Success',
                          duration: const Duration(milliseconds: 1000));
                    },
                    child: const Text(
                      'Yes',
                      style: TextStyle(fontFamily: 'comic'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      isDeleted = false;
                      Get.back();
                    },
                    child: const Text(
                      'No',
                      style: TextStyle(fontFamily: 'comic'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ).then(
      (value) {
        return isDeleted;
      },
    );
  }
}
