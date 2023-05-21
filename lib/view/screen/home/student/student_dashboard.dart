import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/controller/student_controller/student_date_coontroller.dart';
import 'package:students/core/class/handelingview.dart';
import 'package:students/view/widget/student_drawer.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StudentDatesController studentDatesController =
    Get.put(StudentDatesController());

    Widget dateCardWidget(int index) {
      return Column(
        children: [
          InkWell(
            onTap: () {
              studentDatesController.toLessonsDatePage(
                  studentDatesController.datesModelList[index]);
            },
            child: ListTile(
              title: Row(
                children: [
                  Text(
                    studentDatesController.datesModelList[index].dateDay
                        .toString(),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    studentDatesController.datesModelList[index].dateTime
                        .toString(),
                  ),
                  Expanded(child: Container()),
                  Text(
                    studentDatesController.datesModelList[index].teacherName
                        .toString(),
                  ),
                ],
              ),
            ),
          ),
          const Divider()
        ],
      );
    }

    datesListWidget() {
      return RefreshIndicator(
        onRefresh: () async {
          return await studentDatesController
              .getDatesByStudentId();
        },
        child: ListView.builder(
          itemCount: studentDatesController.datesModelList.length,
          itemBuilder: (context, index) {
            return dateCardWidget(index);
          },
        ),
      );
    }
    emptyListWidget() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('no_dates').tr(),
          const SizedBox(
            height: 20,
          ),
          IconButton(
            onPressed: () async {
              await studentDatesController.getDatesByStudentId();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      );
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.phone),
      ),
      drawer: const DrawerStudentWidget(),
      appBar: AppBar(
        title: const Text('dates').tr(),
      ),
      body: Center(
        child: GetBuilder<StudentDatesController>(
          builder: (controller) {
            return HandelingRequest(
              statusRequest: controller.statusRequest!,
              widget: controller.datesModelList.isNotEmpty
                  ? datesListWidget()
                  : emptyListWidget(),
            );
          },
        ),
      ),
    );
  }

}
