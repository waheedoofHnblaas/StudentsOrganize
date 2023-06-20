import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:students/core/class/statusrequest.dart';
import 'package:students/data/model/friendTestModel.dart';
import 'package:students/data/model/studentSubjectModel.dart';

import '../../../core/function/handlingdata.dart';
import '../../../core/services/services.dart';
import '../../../data/datasource/remote/student_lesson/getStudentLessons.dart';

class FriendsController extends GetxController {
  StudentLessonsData studentLessonsData = StudentLessonsData(Get.find());
  List<FriendTestModel> friendsTestsList = [];
  MyServices myServices = Get.find();
  StatusRequest? statusRequest = StatusRequest.none;
  late StudentSubjectModel passedStudentSubjectModel;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getFriendsTests(StudentSubjectModel subjectModel) async {
    statusRequest = StatusRequest.loading;
    update();
    passedStudentSubjectModel = subjectModel;
    friendsTestsList.clear();
    try {
      var response = await studentLessonsData.getStudentFriendTestsData(
        lessonId: passedStudentSubjectModel.lessonId.toString(),
      );
      statusRequest = handlingData(response);
      print(response);
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          bool allowAdd = true;
          List list = response['data'];
          for (var element in list) {
            FriendTestModel friendTestModel = FriendTestModel.fromJson(element);
            for (FriendTestModel stdTest in friendsTestsList) {
              if (stdTest.studentId == friendTestModel.studentId) {
                allowAdd = false;
              }
            }

            if (allowAdd) {
              friendsTestsList.add(friendTestModel);
            }
          }
        }
      } else {
        Get.snackbar(tr('connectionError'), "");
      }
    } catch (e) {
      print('getStudentBay catch $e');
    }

    statusRequest = StatusRequest.success;
    update();
  }
}
