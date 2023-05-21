import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/core/constant/approutes.dart';
import 'package:students/data/datasource/remote/lesson/deleteData.dart';
import 'package:students/data/model/date_model.dart';
import 'package:students/data/model/lesson_model.dart';
import 'package:students/data/model/student_model.dart';

import '../../core/class/statusrequest.dart';
import '../../core/function/handlingdata.dart';
import '../../data/datasource/remote/lesson/add_lesson.dart';
import '../../data/datasource/remote/lesson/getData.dart';
import '../dates_controller/teacher_date_controller.dart';

class LessonController extends GetxController {
  final GetLessonData getLessonData = GetLessonData(Get.find());
  final AddLessonData addLessonData = AddLessonData(Get.find());
  final DeleteLessonData deleteLessonData = DeleteLessonData(Get.find());

  TeacherDateController teacherDateController = Get.find();
  StatusRequest? statusRequest = StatusRequest.none;

  List<LessonModel> lessonsList = [];
  StudentModel studentModel = StudentModel();
  DateModel dateModel = DateModel();
  TextEditingController noteController =
      TextEditingController(text: tr('no_comment'));
  TextEditingController mark = TextEditingController(text: tr('no_marks'));
  String late = '00.00';

  bool showNote = false;
  bool isExam = false;

  changeShowNote() {
    showNote = !showNote;
    noteController.clear();
    update();
  }

  changeIsExam() {
    isExam = !isExam;
    update();
  }

  @override
  void onInit() {
    dateModel = teacherDateController.dateDataModel;
    studentModel = teacherDateController.studentModel;
    update();
    getLessonsByDateAndStudent();
    super.onInit();
  }

  getLessonsByDateAndStudent() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await getLessonData.getLessonData(
      dateId: dateModel.dateId.toString(),
      teacherId: teacherDateController.teacherModel.teacherId.toString(),
      studentId: studentModel.studentId.toString(),
    );
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        lessonsList.clear();
        List data = response['data'];
        for (var lesson in data) {
          lessonsList.add(LessonModel.fromJson(lesson));
        }
        update();
      } else {}
    } else {}
    statusRequest = StatusRequest.success;
    update();
    print('validate');
  }

  void addLessonPage() {
    Get.toNamed(AppRoute.addLessonStudent);
  }

  addLesson() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await addLessonData.addLessonData(
      studentId: studentModel.studentId.toString(),
      teacherId: dateModel.teacherId.toString(),
      dateId: dateModel.dateId.toString(),
      lessonLate: late,
      lessonNote: noteController.text,
      lessonMark: mark.text,
      lessonIsExam: isExam ? '1' : '0',
    );
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        noteController.text = tr('new_lesson');
        mark.text = tr('no_marks');
        late = '00.00';
        showNote = false;
        update();
      } else {}
    } else {}
    statusRequest = StatusRequest.success;
    update();
    await getLessonsByDateAndStudent();
    print('validate');
  }

  deleteLesson(String lessonId) async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await deleteLessonData.getDeleteLessonData(
      lessonId: lessonId,
    );
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        // Get.snackbar(tr('delete_lesson'), tr('successful'));
        update();
      } else {}
    } else {}
    lessonsList.removeWhere((lesson) => lesson.lessonId == lessonId);
    // await getLessonsByDateAndStudent();
    statusRequest = StatusRequest.success;
    update();
    if (lessonsList.isEmpty) {
      print('=======lessonsList========');
      print(lessonsList.length);

      await teacherDateController
          .getStudentsByDateId(dateModel.dateId.toString())
          .whenComplete(() {
        Get.back();
      });
    }
  }




  showSnackBar(String string) {
    Get.showSnackbar(
      GetSnackBar(
        duration: const Duration(seconds: 2),
        title: tr('delete'),
        messageText: TextButton(
            onPressed: () async {
              await deleteLesson(string);
            },
            child: const Text('ok').tr()),
      ),
    );
  }
}
