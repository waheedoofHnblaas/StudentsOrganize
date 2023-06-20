import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/controller/auth_controllers/student/stdTestsController.dart';
import 'package:students/core/class/handelingview.dart';
import 'package:students/core/function/getDate.dart';

class TestsModeStudentPage extends StatelessWidget {
  const TestsModeStudentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StdTestsComeController controller = Get.find();

    Widget testWidget(int index) {
      return InkWell(
        onTap: () {
          print(controller.testsList[index].subjectName);
          controller.toFreindsTestsPage(index);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    AppFunctions.getDate(
                      controller.testsList[index].stdLesDate.toString(),
                    ),
                    style: const TextStyle(fontSize: 9),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    controller.testsList[index].lessonDay.toString(),
                    style: const TextStyle(fontSize: 9),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    controller.testsList[index].lessonTime.toString(),
                    style: const TextStyle(fontSize: 9),
                  ),
                ],
              ),
              ListTile(
                shape: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide(color: Get.theme.primaryColor),
                ),
                title: Row(
                  children: [
                    SizedBox(
                      width: Get.width / 5,
                      child: Text(
                        controller.testsList[index].subjectName.toString(),
                      ),
                    ),
                    Text(
                      controller.testsList[index].teacherName.toString(),
                      style: const TextStyle(
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                subtitle: Text(
                  controller.testsList[index].studentLessonNote.toString(),
                ),
                trailing: Container(
                  decoration: BoxDecoration(
                    color: Get.theme.primaryColor.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(14),
                    ),
                  ),
                  width: Get.width / 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.testsList[index].test.toString(),
                        style: TextStyle(
                            color: Get.theme.primaryColor, fontSize: 18),
                      ),
                      const Text('/'),
                      Text(
                        controller.testsList[index].subjectMark.toString(),
                        style: const TextStyle(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('subjects').tr(),
      ),
      body: Center(
        child: GetBuilder<StdTestsComeController>(
          builder: (controller) {
            return HandelingRequest(
              statusRequest: controller.statusRequest!,
              widget: controller.testsList.isNotEmpty
                  ? Column(
                      children: [
                        SizedBox(
                          height: Get.height / 11,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.testsSubjectsNameList.length,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                controller.setSort(
                                    controller.testsSubjectsNameList[index]);
                                print(controller.sort);
                              },
                              child: Card(
                                color: controller.sort ==
                                        controller.testsSubjectsNameList[index]
                                    ? Get.theme.primaryColor.withOpacity(0.5)
                                    : Get.theme.scaffoldBackgroundColor,
                                child: Padding(
                                  padding: EdgeInsets.all(Get.width / 33),
                                  child: Center(
                                    child: Text(
                                      controller.testsSubjectsNameList[index],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12),
                              ),
                              color: Get.theme.primaryColor.withOpacity(0.3)),
                          height: controller.sort == '' ? 0 : Get.height / 14,
                          width: controller.sort == '' ? 0 : Get.width / 1.5,
                          child: Center(
                            child: Text(
                              '${tr('avg')} : ${controller.subjectAvg}',
                              style: const TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: controller.testsList.length,
                            itemBuilder: (context, index) {
                              if (controller.sort == '') {
                                return testWidget(index);
                              } else {
                                if (controller.testsList[index].subjectName ==
                                    controller.sort) {
                                  return testWidget(index);
                                } else {
                                  return Container();
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    )
                  : const Text('no_dates').tr(),
            );
          },
        ),
      ),
    );
  }
}
