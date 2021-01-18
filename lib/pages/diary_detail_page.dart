import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_diary/models/diary_model.dart';
import 'package:my_diary/static_data.dart';

class DiaryDetailPage extends StatelessWidget {
  DiaryModel diary;
  @override
  Widget build(BuildContext context) {
    diary = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: StaticData.bgColor,
        title: Text("${diary.title}"),
        actions: [
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Get.toNamed("/diary/form", arguments: diary);
              }),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
              width: Get.width,
              height: Get.height,
              child:
                  Text(diary.content, style: TextStyle(color: Colors.black87))),
        ),
      ),
    );
  }
}
