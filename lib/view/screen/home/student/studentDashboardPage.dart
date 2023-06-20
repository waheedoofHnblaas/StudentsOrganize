import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/controller/auth_controllers/student/studentDashboardController.dart';

class StudentDashboardPage extends StatelessWidget {
  const StudentDashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StudentDashboardController studentDashboardController =
        Get.put(StudentDashboardController());

    gradViewWidget() {
      return GridView(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        children: [
          InkWell(
            onTap: () {
              studentDashboardController.toStudentBayPage();
            },
            child: Card(
              shape: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(18),
                ),
                borderSide: BorderSide(
                  color: Get.theme.primaryColor,
                ),
              ),
              child: Center(
                child: Text(
                  'bay',
                  style: TextStyle(
                      color: Get.theme.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 21),
                ).tr(),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              studentDashboardController.toStudentSubjectsTestsPage();
            },
            child: Card(
              shape: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(18),
                ),
                borderSide: BorderSide(
                  color: Get.theme.primaryColor,
                ),
              ),
              child: Center(
                child: Text(
                  'exams',
                  style: TextStyle(
                      color: Get.theme.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 21),
                ).tr(),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              studentDashboardController.toStudentSubjectsComesPage();
            },
            child: Card(
              shape: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(18),
                ),
                borderSide: BorderSide(
                  color: Get.theme.primaryColor,
                ),
              ),
              child: Center(
                child: Text(
                  'isCome',
                  style: TextStyle(
                      color: Get.theme.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 21),
                ).tr(),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              studentDashboardController.toStudentSubjectsNotesPage();
            },
            child: Card(
              shape: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(18),
                ),
                borderSide: BorderSide(
                  color: Get.theme.primaryColor,
                ),
              ),
              child: Center(
                child: Text(
                  'note',
                  style: TextStyle(
                      color: Get.theme.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 21),
                ).tr(),
              ),
            ),
          ),
        ],
      );
    }

    customDrawerButton({required Null Function() onTap, required String text}) {
      return InkWell(
        onTap: onTap,
        child: Card(
          shape: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(11),
            ),
            borderSide: BorderSide(
              color: Get.theme.primaryColor,
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(11.0),
              child: Text(
                text,
                style: TextStyle(
                  color: Get.theme.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ).tr(),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      endDrawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              DrawerHeader(
                child: Container(
                  decoration: BoxDecoration(
                    color: Get.theme.primaryColor.withOpacity(0.3),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          studentDashboardController.studentModel.studentName
                              .toString(),
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          studentDashboardController.studentModel.studentPhone
                              .toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          studentDashboardController.studentModel.studentCreate
                              .toString(),
                          style: const TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              customDrawerButton(
                onTap: () {
                  studentDashboardController.toStudentBayPage();
                },
                text: 'bay',
              ),
              customDrawerButton(
                onTap: () {
                  studentDashboardController.toStudentSubjectsTestsPage();
                },
                text: 'exams',
              ),
              customDrawerButton(
                onTap: () {
                  studentDashboardController.toStudentSubjectsComesPage();
                },
                text: 'isCome',
              ),
              customDrawerButton(
                onTap: () {
                  studentDashboardController.toStudentSubjectsNotesPage();
                },
                text: 'notes',
              ),
              Expanded(child: Container()),
              customDrawerButton(
                onTap: () {
                  studentDashboardController.logout();
                },
                text: 'logout',
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Row(
          children: [
            const Text('student').tr(),
            Expanded(child: Container()),
            Text(
                studentDashboardController.studentModel.studentName.toString()),
          ],
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            tileMode: TileMode.mirror,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Get.theme.scaffoldBackgroundColor,
              Get.theme.scaffoldBackgroundColor,
              Get.theme.primaryColor,
            ],
            stops: const [0.1, 0.1, 0.7],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: Get.height / 10,
          ),
          child: gradViewWidget(),
        ),
      ),
    );
  }
}
