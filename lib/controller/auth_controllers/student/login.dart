import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:students/core/class/statusrequest.dart';
import 'package:students/core/constant/approutes.dart';
import 'package:students/core/function/validinput.dart';
import 'package:students/data/datasource/remote/auth/student/loginDate.dart';
import 'package:students/data/model/student_model.dart';
import 'package:students/data/model/teacher_model.dart';

import '../../../core/function/handlingdata.dart';
import '../../../core/services/services.dart';
import '../../../data/datasource/remote/auth/teacher/login.dart';

class StudentLoginController extends GetxController {
  TextEditingController password = TextEditingController();
  late GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool showText = true;
  StatusRequest? statusRequest = StatusRequest.none;
  final LoginInfoData loginData = LoginInfoData(Get.find());
  MyServices myServices = Get.find();
  StudentModel studentModel = StudentModel();

  changeShow() {
    showText = !showText;
    update();
  }

  loginStudent(bool hasData) async {
    if (hasData || formState.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      var response = await loginData.loginInfoData(
        password: password.text,
      );
      statusRequest = handlingData(response);
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          studentModel = StudentModel.fromJson(response['data']);
          myServices.sharedPreferences.setStringList(
            'studentModel',
            [
              studentModel.studentId.toString(),
              studentModel.studentName.toString(),
              password.text,
              studentModel.studentCreate.toString(),
              studentModel.studentPhone.toString(),
            ],
          );
          myServices.sharedPreferences.setString('step', '2');
          update();
          Get.offAllNamed(AppRoute.studentDashboard);
        } else {
          Get.snackbar('Login Error', 'Password');
          statusRequest = StatusRequest.failure;
          if(hasData) {
            Get.offNamed(AppRoute.userTypePage);
          }

        }
      }
      update();
      print('validate');
    } else {
      print('not validate');
    }
  }

  void loginStudentWithData() async {
    password = TextEditingController(
        text: myServices.sharedPreferences.getStringList('studentModel')![2]);

    // validInput(password.text, 8, 50, 'password');
    await loginStudent(true);

  }
}
