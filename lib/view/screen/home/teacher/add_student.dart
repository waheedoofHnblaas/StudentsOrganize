import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/teacher_controller/add_student_controller.dart';
import '../../../../core/class/handelingview.dart';
import '../../../../core/function/validinput.dart';
import '../../../widget/auth/apploginbutton.dart';
import '../../../widget/auth/apptextfield.dart';

class TeacherAddStudentPage extends StatelessWidget {
  const TeacherAddStudentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(TeacherStudentController());
    return Scaffold(
      appBar: AppBar(title: const Text('add_student').tr()),
      body: Center(
        child: GetBuilder<TeacherStudentController>(
          builder: (teacherController) {
            return Form(
              key: teacherController.formState,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppTextField(
                      type: tr('name'),
                      iconData: Icons.person,
                      inputType: TextInputType.text,
                      onChanged: (p0) {},
                      validator: (p0) {
                        // return validInput(p0!, 4, 50, 'username');
                      },
                      textFieldController: teacherController.name,
                    ),
                    AppTextField(
                      type: tr('phone'),
                      iconData: Icons.phone,
                      inputType: TextInputType.number,
                      onChanged: (p0) {},
                      validator: (p0) {
                        return validInput(p0!, 4, 20, 'phone');
                      },
                      textFieldController: teacherController.phone,
                    ),
                    AppTextField(
                      type: tr('password'),
                      obscureText: teacherController.showText,
                      onTap: () {
                        teacherController.changeShow();
                      },
                      iconData: Icons.password,
                      inputType: TextInputType.visiblePassword,
                      onChanged: (p0) {},
                      validator: (p0) {
                        return validInput(p0!, 8, 50, 'password');
                      },
                      textFieldController: teacherController.password,
                    ),
                    HandelingRequest(
                      statusRequest: teacherController.statusRequest!,
                      widget: AppSignUpAndLoginButton(
                        text: tr('add'),
                        onPressed: () async {
                          await teacherController.addStudent();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
