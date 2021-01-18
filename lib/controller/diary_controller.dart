import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_diary/utils/firebase_database_util.dart';

class DiaryController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  FirebaseDatabaseUtil databaseUtil;
  void onInit() {
    databaseUtil = new FirebaseDatabaseUtil();
    databaseUtil.initState();
    super.onInit();
  }
}
