import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/controller/auth_controllers/teacher/login.dart';
import 'package:students/core/class/statusrequest.dart';
import 'package:students/core/constant/approutes.dart';
import 'package:students/core/constant/days.dart';
import 'package:students/data/datasource/remote/date/addDateData.dart';
import 'package:students/data/datasource/remote/date/dateDate.dart';
import 'package:students/data/model/teacher_model.dart';

import '../../../core/function/handlingdata.dart';
import '../../../core/services/services.dart';
import '../../../data/model/date_model.dart';
import '../../data/datasource/remote/date/deleteData.dart';
import '../../data/datasource/remote/lesson/add_lesson.dart';
import '../../data/datasource/remote/lesson/deleteStudentLessons.dart';
import '../../data/datasource/remote/student/studentsDateData.dart';
import '../../data/model/student_model.dart';

class TeacherDateController extends GetxController {
  StatusRequest? statusRequest = StatusRequest.none;
  final DateData dateData = DateData(Get.find());
  MyServices myServices = Get.find();
  TeacherModel teacherModel = TeacherModel();
  StudentModel studentModel = StudentModel();
  final AddDateData addDateData = AddDateData(Get.find());
  final DeleteDateData deleteDateData = DeleteDateData(Get.find());
  final AddLessonData addLessonData = AddLessonData(Get.find());
  final DeleteStudentLessonsData deleteStudentLessons = DeleteStudentLessonsData(Get.find());

  TeacherLoginController loginController = Get.find();
  List<DateModel> datesList = [];

  String dateTime = '08.00';
  String datePeriod = '1.5';
  String dateDay = weekDays.first;

  @override
  void onInit() {
    teacherModel = loginController.teacherModel;
    getDateByTeacherId();
    super.onInit();
  }

  getDateByTeacherId() async {
    try {
      statusRequest = StatusRequest.loading;
      update();
      var response =
          await dateData.dateData(teacherId: teacherModel.teacherId.toString());
      statusRequest = handlingData(response);
      datesList.clear();
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          List dates = response['data'];
          for (var date in dates) {
            datesList.add(DateModel.fromJson(date));
          }
          update();
        } else {
          // Get.snackbar('Date Error', 'Internet');
          statusRequest = StatusRequest.success;
        }
      }
      statusRequest = StatusRequest.success;

      update();
      print('validate');
    } catch (e) {}
  }

  addDate() async {
    statusRequest = StatusRequest.loading;
    update();

    print('${teacherModel.teacherId} $dateDay $dateTime $datePeriod');
    var response = await addDateData.addDateData(
      teacherId: teacherModel.teacherId.toString(),
      dateDay: dateDay,
      dateTime: dateTime,
      datePer: datePeriod,
    );
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        update();
        Get.back();
        Get.snackbar(tr('add_date'), tr('successful'));
      } else {}
      await getDateByTeacherId();
    } else {}
    statusRequest = StatusRequest.success;
    update();
    print('validate');
  }

  void setDay(String weekDay) {
    dateDay = weekDay;
    update();
  }

  late DateModel dateDataModel;

  Future<void> toDataPage(DateModel dat) async {
    dateDataModel = dat;
    update();
    Get.toNamed(AppRoute.dateDataPage);
    await getStudentsByDateId(dat.dateId.toString());
  }

  final StudentDateData studentDateData = StudentDateData(Get.find());
  List<StudentModel> studentsDateList = [];


  Future<List<StudentModel>> getStudentsByDateId(String dateIdData) async {
    try {
      statusRequest = StatusRequest.loading;
      update();
      var response = await studentDateData.getStudentDate(dateId: dateIdData);
      statusRequest = handlingData(response);
      if (statusRequest == StatusRequest.success) {
        studentsDateList.clear();
        if (response['status'] == 'success') {
          List students = response['data'];
          for (var student in students) {
            studentsDateList.add(StudentModel.fromJson(student));
          }
          statusRequest = StatusRequest.success;
          update();
        } else if (response['status'] == 'failure') {
          statusRequest = StatusRequest.failure;
        } else {
          statusRequest = StatusRequest.failure;
        }
      }
      print('validate');
      statusRequest = StatusRequest.success;
      update();
    } catch (e) {}
    return studentsDateList;
  }

  Future addLesson(String studentId) async {
    statusRequest = StatusRequest.loading;
    update();

    print('================');
    print(studentId);
    print(dateDataModel.dateId.toString());
    var response = await addLessonData.addLessonData(
      studentId: studentId,
      teacherId: teacherModel.teacherId.toString(),
      dateId: dateDataModel.dateId.toString(),
      lessonIsExam: '0',
      lessonLate: '',
      lessonMark: '',
      lessonNote: '',
    );
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        update();
      } else {}
      await getDateByTeacherId();
    } else {}
    statusRequest = StatusRequest.success;
    update();
    await getStudentsByDateId(dateDataModel.dateId.toString());
    print('validate');
  }

  deleteDateMethod(String teacherId,String dateId,) async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await deleteDateData.getDeleteDateData(
      dateId: dateId,
      teacherId: teacherId,
    );
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        // Get.snackbar(tr('delete_lesson'), tr('successful'));
        datesList.removeWhere((date) => date.dateId==dateId&&date.teacherId==teacherId);
        update();
      } else {}
    } else {}

    statusRequest = StatusRequest.success;
    update();

  }
  deleteStudentLessonsMethod(String studentId,String teacherId,String dateId,) async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await deleteStudentLessons.getStudentLessonsData(
      studentId: studentId,
      dateId: dateId,
      teacherId: teacherId,
    );
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        // Get.snackbar(tr('delete_lesson'), tr('successful'));
        studentsDateList.removeWhere((std) => std.studentId==studentId);
        update();
      } else {}
    } else {}
    statusRequest = StatusRequest.success;
    update();
  }

  showDeleteLessonsSnackBar(String studentId,String teacherId,String dateId) {
    Get.showSnackbar(
      GetSnackBar(
        duration: const Duration(seconds: 2),
        title: tr('delete'),
        messageText: TextButton(
            onPressed: () async {
              await deleteStudentLessonsMethod(studentId, teacherId, dateId);
            },
            child: const Text('ok').tr()),
      ),
    );
  }
  showDeleteDateSnackBar(String teacherId,String dateId) {
    Get.showSnackbar(
      GetSnackBar(
        duration: const Duration(seconds: 2),
        title: tr('delete'),
        messageText: TextButton(
            onPressed: () async {
              await deleteDateMethod(teacherId, dateId);
            },
            child: const Text('ok').tr()),
      ),
    );
  }

  void toLessonsDataPage(StudentModel student) {
    studentModel = student;
    Get.toNamed(AppRoute.lessonsData);
  }

  void logout() {
    myServices.sharedPreferences.clear();
    Get.offAllNamed(AppRoute.userTypePage);
  }
}
