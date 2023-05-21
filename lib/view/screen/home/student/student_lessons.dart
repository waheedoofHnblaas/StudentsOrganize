import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/controller/student_controller/student_date_coontroller.dart';
import 'package:students/core/class/handelingview.dart';
import 'package:students/core/function/showLongString.dart';
import 'package:students/data/model/teacher_model.dart';
import 'package:students/view/widget/lessonsWidget.dart';

class StudentLessonsPage extends StatelessWidget {
  const StudentLessonsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StudentDatesController studentDatesController = Get.find();

    lessonsListWidget() {
      return ListView.builder(
        itemCount: studentDatesController.lessons.length,
        itemBuilder: (context, i) {
          int index = studentDatesController.lessons.length - 1 - i;
          return lessonWidget(studentDatesController.lessons, index);
        },
      );
    }

    AppBar appBar() {
      return AppBar(
        title: Row(
          children: [
            Text(
              studentDatesController.dateModel.dateDay.toString(),
            ),
            Expanded(child: Container()),
            showDrawerString(
                studentDatesController.dateModel.subjectName.toString()),
            showDrawerString(
                studentDatesController.dateModel.teacherName.toString()),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: appBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.phone),
      ),
      body: GetBuilder<StudentDatesController>(
        builder: (controller) {
          return HandelingRequest(
            statusRequest: controller.statusRequest!,
            widget: controller.lessons.isNotEmpty
                ? lessonsListWidget()
                : Center(
                    child: const Text('no_lessons').tr(),
                  ),
          );
        },
      ),
    );
  }
}
