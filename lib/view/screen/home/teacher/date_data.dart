import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/core/class/handelingview.dart';
import 'package:students/core/constant/approutes.dart';
import 'package:students/core/function/showLongString.dart';
import 'package:students/data/model/date_model.dart';
import 'package:students/data/model/student_model.dart';

import '../../../../controller/dates_controller/teacher_date_controller.dart';

class DateDataPage extends StatelessWidget {
  const DateDataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TeacherDateController controller = Get.find();
    DateModel dateModel = controller.dateDataModel;

    studentCardWidget(int i) {
      int index = controller.studentsDateList.length - 1 - i;
      List<StudentModel> students = controller.studentsDateList;
      return InkWell(
        onLongPress: () async {
          await controller.showDeleteLessonsSnackBar(
            students[index].studentId.toString(),
            controller.teacherModel.teacherId.toString(),
            dateModel.dateId.toString(),
          );
        },
        onTap: () {
          controller.toLessonsDataPage(students[index]);
        },
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              showLongString(
                students[index].studentName.toString(),
              ),
              Text(
                students[index].studentPhone.toString(),
              ),
              Expanded(child: Container()),
            ],
          ),
        ),
      );
    }

    studentsList() {
      return Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: Get.width / 22),
          decoration: BoxDecoration(
            color: Get.theme.primaryColor.withOpacity(0.1),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: GetBuilder<TeacherDateController>(
            builder: (controller2) {
              return HandelingRequest(
                statusRequest: controller.statusRequest!,
                widget: controller.studentsDateList.isNotEmpty
                    ? ListView.builder(
                        // primary: true,
                        // shrinkWrap: true,
                        itemCount: controller.studentsDateList.length,
                        itemBuilder: (context, i) {
                          return Column(
                            children: [
                              studentCardWidget(i),
                              Container(
                                color: Get.theme.scaffoldBackgroundColor,
                                height: 2,
                              ),
                            ],
                          );
                        })
                    : ListTile(
                        title: Center(child: const Text('no_students').tr()),
                      ),
              );
            },
          ),
        ),
      );
    }

    dateData() {
      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: Get.width / 22,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: Get.theme.primaryColor.withOpacity(0.1),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('day').tr(),
                  const Text('       : '),
                  Text(dateModel.dateDay.toString()),
                ],
              ),
            ),
            Stack(
              children: [
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('time').tr(),
                      const Text('   : '),
                      Text(dateModel.dateTime.toString()),
                    ],
                  ),
                ),
                Positioned(
                  left:  Get.width / 5,
                  right:  Get.width / 5,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Get.theme.primaryColor,
                    child: Center(
                      child: GetBuilder<TeacherDateController>(
                        builder: (teacherController) {
                          return HandelingRequest(
                            statusRequest: teacherController.statusRequest!,
                            widget: Text(
                              teacherController.studentsDateList.length.toString(),
                              style:
                                  TextStyle(fontSize: 30, color: Get.theme.scaffoldBackgroundColor),
                            ),
                          );
                        }
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('period').tr(),
                  const Text(' : '),
                  Text(dateModel.datePer.toString()),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoute.chooseStudents);
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('date_date').tr(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 4,
            ),
            dateData(),
            studentsList(),
          ],
        ),
      ),
    );
  }
}
