import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/controller/auth_controllers/student/friendsController.dart';
import 'package:students/core/class/handelingview.dart';

class FriendsTestsPage extends StatelessWidget {
  const FriendsTestsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('exam_friends').tr()),
      body: Center(
        child: GetBuilder<FriendsController>(
          builder: (controller) {
            return HandelingView(
              statusRequest: controller.statusRequest!,
              widget: ListView.builder(
                itemCount: controller.friendsTestsList.length,
                itemBuilder: (context, index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(controller.friendsTestsList[index].stdLesDate.toString()),
                    ListTile(
                      title: Text(
                        controller.friendsTestsList[index].studentId.toString() ==
                                controller.passedStudentSubjectModel.studentId
                                    .toString()
                            ? controller.friendsTestsList[index].studentName
                                .toString()
                            : '',
                      ),
                      trailing: Text(
                        controller.friendsTestsList[index].test.toString(),
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
