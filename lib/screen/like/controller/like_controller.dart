import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LikeController extends GetxController {
  // RxList<DbModel> searchList = <DbModel>[].obs;

  // Future<void> getData() async {
  //   List<DbModel> favorite = await DbHelper.dbHelper.readData();
  //   searchList.value = favorite;
  // }
  RxBool isLight = false.obs;
  void copyToClipboard(String data) {
    Clipboard.setData(
      ClipboardData(text: data),
    );
  }
}
