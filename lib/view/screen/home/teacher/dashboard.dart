import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/controller/auth_controllers/teacher/teacherController.dart';
import 'package:students/core/class/handelingview.dart';
import 'package:students/core/constant/approutes.dart';

class TeacherDashboard extends StatelessWidget {
  const TeacherDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TeacherController teacherController = Get.put(TeacherController());

    Widget lessonCard(int index) {
      return InkWell(
        onTap: () {
          teacherController.toLessonStudentsPage(
            teacherController.teacherLessonsList[index].lessonId.toString(),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListTile(
            shape: const OutlineInputBorder(
              borderSide: BorderSide(width: 0.4),
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            textColor: Get.theme.scaffoldBackgroundColor,
            tileColor: Get.theme.primaryColor.withOpacity(0.75),
            contentPadding: EdgeInsets.symmetric(
              horizontal: Get.width / 10,
            ),
            minVerticalPadding: 10,
            title: Text(
              teacherController.teacherLessonsList[index].lessonDay.toString(),
            ),
            subtitle: Text(
              teacherController.teacherLessonsList[index].lessonNote.toString(),
            ),
            trailing: Text(
              teacherController.teacherLessonsList[index].lessonTime.toString(),
            ),
          ),
        ),
      );
    }

    drawerWidget() {
      return Column(
        children: [
          InkWell(
            onTap: () {
              teacherController.toAllStudentsBayPage();
            },
            child: ListTile(
              title: const Text(
                'bay',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ).tr(),
            ),
          ),
          InkWell(
            onTap: () {
              teacherController.logout();
            },
            child: ListTile(
              title: const Text(
                'logout',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ).tr(),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      endDrawer: Drawer(
        child: SafeArea(
          child: drawerWidget(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          teacherController.toAddLessonPage();
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        title: Row(
          children: [
            const Text('teacher').tr(),
            const SizedBox(
              width: 5,
            ),
            Text(': ${teacherController.teacherModel.teacherName!}'),
          ],
        ),
      ),
      body: Center(
        child: GetBuilder<TeacherController>(
          builder: (controller) {
            return HandelingRequest(
              statusRequest: controller.statusRequest!,
              widget: controller.teacherLessonsList.isNotEmpty
                  ? RefreshIndicator(
                      color: Get.theme.primaryColor,
                      onRefresh: () async {
                        await controller.getTeacherLessons();
                      },
                      child: ListView.builder(
                        itemCount: controller.teacherLessonsList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              lessonCard(index),
                              controller.teacherLessonsList.length == index+1
                                  ? SizedBox(
                                      height: Get.height / 8,
                                    )
                                  : Container(),
                            ],
                          );
                        },
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('no_lessons').tr(),
                        const SizedBox(
                          height: 33,
                        ),
                        IconButton(
                          onPressed: () async {
                            await teacherController.getTeacherLessons();
                          },
                          icon: const Icon(Icons.refresh),
                        )
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }
}
