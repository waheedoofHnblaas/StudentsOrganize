import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/controller/auth_controllers/teacher/allStudentsBayController.dart';
import 'package:students/controller/auth_controllers/teacher/studentDataController.dart';
import 'package:students/core/class/handelingview.dart';

class StudentBayPage extends StatelessWidget {
  const StudentBayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AllStudentsBayController allStudentsBayController=Get.put(AllStudentsBayController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          allStudentsBayController.addStudentBay();
          print(allStudentsBayController.studentId.toString());
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(title: const Text('bay').tr()),
      body: Center(
        child: GetBuilder<StudentDataController>(
          builder: (controller) {
            return HandelingRequest(
              statusRequest: controller.statusRequest!,
              widget: controller.bayModelList.isNotEmpty
                  ? Column(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${tr('sum')}  :  ${controller.sum.toString()}',
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 10,
                          child: ListView.builder(
                            itemCount: controller.bayModelList.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(controller
                                    .bayModelList[index].quantity
                                    .toString()),
                                trailing: Text(controller
                                    .bayModelList[index].bayDate
                                    .toString()),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  : const Text('no_bay').tr(),
            );
          },
        ),
      ),
    );
  }
}
