import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/controller/student_controller/choose_student_controller.dart';
import 'package:students/data/datasource/remote/student/addData.dart';

import '../../core/class/statusrequest.dart';
import '../../core/function/handlingdata.dart';
import '../dates_controller/teacher_date_controller.dart';

class TeacherStudentController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  late GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool showText = true;
  StatusRequest? statusRequest = StatusRequest.none;
  final AddStudentData addStudentData = AddStudentData(Get.find());

  changeShow() {
    showText = !showText;
    update();
  }

  addStudent() async {
    if (formState.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      var response = await addStudentData.addStudentData(
        studentName: name.text,
        studentPassword: password.text,
        studentPhone: phone.text,
      );
      statusRequest = handlingData(response);
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          ChooseStudentController chooseStudentController=Get.find();
         await chooseStudentController.getStudentsByDateId('-1');
          chooseStudentController.update();
          name.clear();
          password.clear();
          phone.clear();
          update();

          Get.back();
          Get.snackbar(tr('add_student'), tr('successful'));
        } else {
          Get.snackbar('Login Error', 'Password or Name');
          statusRequest = StatusRequest.failure;

        }
        update();
      }
      update();
      print('validate');
    } else {
      print('not validate');
    }
  }
}
