import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/controller/teacher_controller/get_lessons_controller.dart';
import 'package:students/core/class/handelingview.dart';
import 'package:students/core/function/showLongString.dart';
import 'package:students/data/model/lesson_model.dart';

import '../../../widget/lessonsWidget.dart';

class LessonsData extends StatelessWidget {
  const LessonsData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LessonController lessonController = Get.put(LessonController());

    lessonsListWidget() {
      return ListView.builder(
        itemCount: lessonController.lessonsList.length,
        itemBuilder: (context, i) {
          int index = lessonController.lessonsList.length - 1 - i;
          List<LessonModel> lessons = lessonController.lessonsList;
          return InkWell(
              onLongPress: () async {
                await lessonController
                    .showSnackBar(lessons[index].lessonId.toString());
              },
              child: lessonWidget(lessons, index));
        },
      );
    }

    appBarWidget() {
      return AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            showAppBarString(
              lessonController.studentModel.studentName.toString(),
            ),
            Text(
              '${lessonController.dateModel.dateDay}/${lessonController.dateModel.dateTime}',
            ),
          ],
        ),
      );
    }

    return GetBuilder<LessonController>(
      builder: (lessonController) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              lessonController.addLessonPage();
            },
            child: const Icon(Icons.add),
          ),
          appBar: appBarWidget(),
          body: Center(
            child: HandelingView(
              statusRequest: lessonController.statusRequest!,
              widget: lessonsListWidget(),
            ),
          ),
        );
      },
    );
  }
}
