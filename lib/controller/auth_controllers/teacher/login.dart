import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:students/core/class/statusrequest.dart';
import 'package:students/core/constant/approutes.dart';
import 'package:students/core/function/validinput.dart';
import 'package:students/data/model/teacher_model.dart';

import '../../../core/function/handlingdata.dart';
import '../../../core/services/services.dart';
import '../../../data/datasource/remote/auth/teacher/login.dart';

class TeacherLoginController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  late GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool showText = true;
  StatusRequest? statusRequest = StatusRequest.none;
  final LoginData loginData = LoginData(Get.find());
  MyServices myServices = Get.find();
  TeacherModel teacherModel = TeacherModel();

  changeShow() {
    showText = !showText;
    update();
  }

  loginTeacher(bool hasData) async {
    if (hasData || formState.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      var response = await loginData.loginData(
        name: name.text,
        password: password.text,
      );
      statusRequest = handlingData(response);
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          teacherModel = TeacherModel.fromJson(response['data']);
          myServices.sharedPreferences.setStringList(
            'teacherModel',
            [
              teacherModel.teacherId.toString(),
              teacherModel.teacherName.toString(),
              password.text,
              teacherModel.teacherCreate.toString(),
              teacherModel.subjectId.toString(),
              teacherModel.teacherPhone.toString(),
            ],
          );
          myServices.sharedPreferences.setString('step', '1');
          update();
          Get.offAllNamed(AppRoute.teacherDashboard);
        } else {
          Get.snackbar('Login Error', 'Password or Name');
          statusRequest = StatusRequest.failure;

          if (hasData) {
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

  void loginTeacherWithData() {
    name = TextEditingController(
        text: myServices.sharedPreferences.getStringList('teacherModel')![1]);
    password = TextEditingController(
        text: myServices.sharedPreferences.getStringList('teacherModel')![2]);

    // validInput(password.text, 8, 50, 'password');
    loginTeacher(true);
  }
}
