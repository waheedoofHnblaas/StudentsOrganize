import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:students/controller/dates_controller/teacher_date_controller.dart';
import 'package:students/core/class/statusrequest.dart';

import '../../core/function/handlingdata.dart';
import '../../data/datasource/remote/student/studentsDateData.dart';
import '../../data/model/date_model.dart';
import '../../data/model/student_model.dart';

class ChooseStudentController extends GetxController {
  final StudentDateData studentDateData = StudentDateData(Get.find());
  List<StudentModel> studentsList = [];
  TeacherDateController teacherDateController = Get.find();
  StatusRequest statusRequest = StatusRequest.none;

  @override
  void onInit() {
    getStudentsByDateId('-1');
    super.onInit();
  }

  Future<List<StudentModel>> getStudentsByDateId(String dateIdData) async {
    try {
      statusRequest = StatusRequest.loading;
      update();
      var response = await studentDateData.getStudentDate(dateId: dateIdData);
      statusRequest = handlingData(response);
      if (statusRequest == StatusRequest.success) {
        studentsList.clear();
        if (response['status'] == 'success') {
          List students = await response['data'];

          for (var student in students) {
            studentsList.add(StudentModel.fromJson(student));
            for (StudentModel std in teacherDateController.studentsDateList) {
              if (std.studentId == StudentModel.fromJson(student).studentId) {
                studentsList.removeWhere(
                    (element) => element.studentId == std.studentId);
              }
            }
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
    return studentsList;
  }

  void removeFromListUi(StudentModel student) {
    studentsList.remove(student);
    update();
  }

  bool searchMode = false;
  TextEditingController search = TextEditingController();

  void changeSearchMode() {
    if (search.text.isEmpty) {
      searchMode = !searchMode;
    } else {
      search.clear();
    }
    update();
  }
}
