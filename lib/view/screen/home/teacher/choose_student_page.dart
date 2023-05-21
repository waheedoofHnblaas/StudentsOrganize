import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/controller/dates_controller/teacher_date_controller.dart';
import 'package:students/controller/student_controller/choose_student_controller.dart';
import 'package:students/core/class/handelingview.dart';
import 'package:students/core/constant/approutes.dart';
import 'package:students/core/function/showLongString.dart';
import 'package:students/view/widget/auth/apptextfield.dart';

import '../../../../data/model/student_model.dart';

class ChooseStudentsPage extends StatelessWidget {
  const ChooseStudentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChooseStudentController chooseStdController =
        Get.put(ChooseStudentController());
    TeacherDateController teacherDateController = Get.find();


    studentsCardWidget(StudentModel student){
      return Column(
        children: [
          Container(
            color: Get.theme.scaffoldBackgroundColor,
            height: 3,
          ),
          InkWell(
            onTap: () async {
             await teacherDateController.addLesson(student.studentId.toString());
              chooseStdController.removeFromListUi(student);
            },
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  showLongString(
                      student.studentName.toString()),
                  Text(
                    student.studentPhone.toString(),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }
    studentsListWidget() {
      return ListView.builder(
        primary: true,
        shrinkWrap: true,
        itemCount: chooseStdController.studentsList.length,
        itemBuilder: (context, i) {
          int index = chooseStdController.studentsList.length - 1 - i;
          List<StudentModel> students = chooseStdController.studentsList;
          if(chooseStdController.searchMode){
            return chooseStdController.search.text
                .isCaseInsensitiveContainsAny(students[index].studentName.toString())
                ? studentsCardWidget(students[index])
                : Container();
          }else{
            return studentsCardWidget(students[index]);
          }
        },
      );
    }
    appBarWidget(){
      return  AppBar(
        title: GetBuilder<ChooseStudentController>(
          builder: (cont) {
            if (cont.searchMode) {
              return AppTextField(
                type: tr('student'),
                iconData: Icons.close,
                inputType: TextInputType.name,
                onTap: () {
                  chooseStdController.changeSearchMode();
                },
                onChanged: (p0) {
                  chooseStdController.update();
                },
                validator: (p0) {},
                textFieldController: chooseStdController.search,
              );
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('choose_student').tr(),
                  IconButton(
                    onPressed: () {
                      chooseStdController.changeSearchMode();
                    },
                    icon: const Icon(Icons.search),
                  )
                ],
              );
            }
          },
        ),
      );
    }
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(AppRoute.addStudent);
          },
          child: const Icon(Icons.add),
        ),
        appBar: appBarWidget(),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: Get.width / 22),
          decoration: BoxDecoration(
            color: Get.theme.primaryColor.withOpacity(0.1),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: GetBuilder<ChooseStudentController>(
            builder: (controller) {
              return HandelingRequest(
                statusRequest: controller.statusRequest,
                widget: controller.studentsList.isNotEmpty
                    ? studentsListWidget()
                    : ListTile(
                        title: Center(child: const Text('no_students').tr()),
                      ),
              );
            },
          ),
        ),);
  }
}
