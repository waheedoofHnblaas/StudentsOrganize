import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/auth_controllers/student/stdTestsController.dart';
import '../../../../../core/class/handelingview.dart';

class ComeModeStudentPage extends StatelessWidget {
  const ComeModeStudentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StdTestsComeController controller = Get.find();
    comeWidget(int index) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          tileColor:
              controller.comeList[index] ? null : Colors.red.withOpacity(0.2),
          shape: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide: BorderSide(color: Get.theme.primaryColor),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              controller.comeList[index]
                  ? controller.studentSubjectsList[index].late.toString() == ''
                      ? const Icon(
                          Icons.done_outline_rounded,
                          color: Colors.greenAccent,
                        )
                      : Row(
                          children: [
                            const Text('late').tr(),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              controller.studentSubjectsList[index].late
                                  .toString(),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            const Text('minute').tr(),
                          ],
                        )
                  : const Text(
                      'isNotCome',
                      style: TextStyle(fontSize: 21),
                    ).tr(),
              Column(
                children: [
                  Text(
                    controller.studentSubjectsList[index].lessonDay.toString(),
                    style: const TextStyle(fontSize: 11),
                  ),
                  Text(
                    controller.studentSubjectsList[index].lessonTime.toString(),
                    style: const TextStyle(fontSize: 11),
                  ),
                ],
              ),
              // Expanded(child: Container()),
              Text(
                controller.studentSubjectsList[index].stdLesDate
                    .toString()
                    .replaceRange(
                        10,
                        controller.studentSubjectsList[index].stdLesDate
                            .toString()
                            .length,
                        ''),
                style: const TextStyle(fontSize: 8),
              ),
            ],
          ),
          // subtitle:
          //     : ,
          trailing: Text(
            controller.studentSubjectsList[index].subjectName.toString(),
          ),
        ),
      );
    }

    return GetBuilder<StdTestsComeController>(
      builder: (controller) {
        return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  const Text('isCome').tr(),
                  Expanded(child: Container()),
                  Text(
                    '${tr('isNotCome')} ${controller.comeList.where((element) => !element).length}',
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
            body: Center(
                child: HandelingRequest(
              statusRequest: controller.statusRequest!,
              widget: controller.studentSubjectsList.isNotEmpty
                  ? ListView.builder(
                      itemCount: controller.comeList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async {
                            // print(controller.studentSubjectsList.length);
                            // await controller
                            //     .getStudentSubjects(controller.studentModelId);
                          },
                          child: comeWidget(index),
                        );
                      },
                    )
                  : const Text('no_dates').tr(),
            )));
      },
    );
  }
}
