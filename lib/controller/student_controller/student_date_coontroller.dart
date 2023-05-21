import 'package:get/get.dart';
import 'package:students/core/constant/approutes.dart';
import 'package:students/data/datasource/remote/date/studentDateDta.dart';
import 'package:students/data/model/date_model.dart';
import 'package:students/data/model/lesson_model.dart';
import 'package:students/data/model/student_model.dart';

import '../../core/class/statusrequest.dart';
import '../../core/function/handlingdata.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/lesson/getData.dart';
import '../auth_controllers/student/login.dart';

class StudentDatesController extends GetxController {
  StatusRequest? statusRequest = StatusRequest.none;
  List<DateModel> datesModelList = [];
  List<LessonModel> lessons = [];
  StudentModel studentModel = StudentModel();

  final StudentDateData studentDateData = StudentDateData(Get.find());

  final GetLessonData getLessonData = GetLessonData(Get.find());

  @override
  void onInit() {
    StudentLoginController studentLoginController = Get.find();

    studentModel = studentLoginController.studentModel;
    update();
    getDatesByStudentId();
    super.onInit();
  }

  getDatesByStudentId() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await studentDateData.studentDateData(
      studentId: studentModel.studentId.toString(),
    );
    statusRequest = handlingData(response);
    datesModelList.clear();
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        List data = response['data'];
        for (var date in data) {
          datesModelList.add(DateModel.fromJson(date));
        }
        update();
      } else {}
    } else {
      statusRequest = StatusRequest.failure;
    }
    update();

    print(statusRequest);
    print('validate');
  }

  DateModel dateModel = DateModel();

  toLessonsDatePage(date) async {
    dateModel = date;
    Get.toNamed(AppRoute.studentLessons);
    await getLessonsByDateAndStudent();
  }

  getLessonsByDateAndStudent() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await getLessonData.getLessonData(
      dateId: dateModel.dateId.toString(),
      teacherId: dateModel.teacherId.toString(),
      studentId: studentModel.studentId.toString(),
    );
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      lessons.clear();
      if (response['status'] == 'success') {
        List data = response['data'];
        for (var lesson in data) {
          lessons.add(LessonModel.fromJson(lesson));
        }
        update();
      } else {}
    } else {
      statusRequest = StatusRequest.failure;
    }
    update();
    print('validate');
  }

  void logout() {
    MyServices myServices = Get.find();
    myServices.sharedPreferences.clear();
    Get.offAllNamed(AppRoute.userTypePage);
  }
}
