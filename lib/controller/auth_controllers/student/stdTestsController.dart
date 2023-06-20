import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:students/controller/auth_controllers/student/friendsController.dart';
import 'package:students/core/constant/approutes.dart';
import 'package:students/data/model/studentSubjectModel.dart';

import '../../../core/class/statusrequest.dart';
import '../../../core/function/handlingdata.dart';
import '../../../core/services/services.dart';
import '../../../data/datasource/remote/student/getStudent.dart';

class StdTestsComeController extends GetxController {
  MyServices myServices = Get.find();
  StudentData studentData = StudentData(Get.find());

  StatusRequest? statusRequest = StatusRequest.none;

  late String studentModelId;

  List<StudentSubjectModel> studentSubjectsList = [];
  List<bool> comeList = [];
  List<StudentSubjectModel> notesList = [];
  List<StudentSubjectModel> testsList = [];
  List<String> testsSubjectsNameList = [];
  String sort = '';

  double subjectAvg = 0;
  int subjectCount = 0;

  void setSort(String string) {
    if (sort == string) {
      sort = '';
    } else {
      sort = string;
      subjectAvg = 0;
      subjectCount = 0;
      for (StudentSubjectModel stdTestSubject in testsList) {
        if (stdTestSubject.subjectName == sort) {
          subjectCount++;
          subjectAvg += double.parse(stdTestSubject.test.toString());
        }
      }
      subjectAvg = subjectAvg / subjectCount;
    }
    update();

    update();
  }

  getTestsNameSubjectsList() async {
    for (var element in studentSubjectsList) {
      if (!testsSubjectsNameList.contains(element.subjectName)) {
        testsSubjectsNameList.add(element.subjectName.toString());
      }
    }
    update();
  }

  getStudentSubjects(String stdId) async {
    studentModelId = stdId;
    statusRequest = StatusRequest.loading;
    update();
    studentSubjectsList.clear();
    testsList.clear();
    notesList.clear();
    comeList.clear();
    try {
      var response =
          await studentData.getStudentSubjects(studentId: studentModelId);
      statusRequest = handlingData(response);
      print(response);
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          List list = response['data'];
          for (var element in list) {
            print(element);
            print('\n');
            studentSubjectsList.add(StudentSubjectModel.fromJson(element));
            comeList.add(
              studentSubjectsList.last.studentLessonIsCome.toString() == '1'
                  ? true
                  : false,
            );
            if (studentSubjectsList.last.test.toString() != '') {
              testsList.add(StudentSubjectModel.fromJson(element));
            }
            if (studentSubjectsList.last.studentLessonNote.toString() != '') {
              notesList.add(StudentSubjectModel.fromJson(element));
            }
          }
          await getTestsNameSubjectsList();
        }
      } else {
        Get.snackbar(tr('connectionError'), "");
      }
    } catch (e) {
      print('getStudentSubjects catch $e');
    }

    statusRequest = StatusRequest.success;
    update();
  }

  void toFreindsTestsPage(int index) async {
    Get.toNamed(AppRoute.friendsTestsPage);
    FriendsController friendsController = Get.put(FriendsController());
    await friendsController.getFriendsTests(testsList[index]);
  }
}
