import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/controller/auth_controllers/teacher/studentLessonController.dart';
import 'package:students/core/class/handelingview.dart';

class StudentsLessonPage extends StatelessWidget {
  const StudentsLessonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StudentLessonController studentLessonController = Get.find();

    Widget studentCard(int index) {
      return InkWell(
        onTap: () {
          studentLessonController.toStudentLessonsPage(
              studentLessonController.studentLessonList[index]);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            shape: const OutlineInputBorder(
              borderSide: BorderSide(width: 0.4),
              borderRadius: BorderRadius.all(
                Radius.circular(18),
              ),
            ),
            textColor: Get.theme.scaffoldBackgroundColor,
            tileColor: Get.theme.primaryColor.withOpacity(0.8),
            contentPadding: EdgeInsets.symmetric(
              horizontal: Get.width / 10,
            ),
            minVerticalPadding: 10,
            title: Text(
              studentLessonController.studentLessonList[index].studentName
                  .toString(),
            ),
            trailing: Text(
              '${studentLessonController.studentLessonList[index].stdLesDate}',
            ),
          ),
        ),
      );
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          studentLessonController.toAddStudent();
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('students').tr(),
      ),
      body: Center(
        child: GetBuilder<StudentLessonController>(
          builder: (controller) {
            return HandelingRequest(
              statusRequest: controller.statusRequest!,
              widget: controller.studentLessonList.isNotEmpty
                  ? RefreshIndicator(
                      edgeOffset: Get.height / 8,
                      onRefresh: () async {
                        await controller.getStudentsLesson(
                            studentLessonController.lessonId);
                      },
                      child: ListView.builder(
                        itemCount: controller.studentLessonList.length,
                        itemBuilder: (context, index) {
                          return studentCard(index);
                        },
                      ),
                    )
                  : const Text('no_students').tr(),
            );
          },
        ),
      ),
    );
  }
}
