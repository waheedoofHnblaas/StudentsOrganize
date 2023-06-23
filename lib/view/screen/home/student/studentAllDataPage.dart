import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/core/function/getDate.dart';
import '../../../../controller/auth_controllers/student/stdTestsController.dart';

class StudentAllDataPage extends StatelessWidget {
  const StudentAllDataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('all').tr()),
      body: Center(
        child: GetBuilder<StdTestsComeController>(
          builder: (controller) => ListView.builder(
            itemCount: controller.studentALLSubjectsList.length,
            itemBuilder: (context, index) => Card(

              color: Get.theme.primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(11.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          controller.studentALLSubjectsList[index].subjectName
                              .toString(),
                          style: TextStyle(
                            color: Get.theme.scaffoldBackgroundColor,
                            fontSize: 8,
                          ),
                        ),
                        Text(
                          controller.studentALLSubjectsList[index].teacherName
                              .toString(),
                          style: TextStyle(
                            color: Get.theme.scaffoldBackgroundColor,
                            fontSize: 8,
                          ),
                        ),
                        Text(
                          controller.studentALLSubjectsList[index].teacherPhone
                              .toString(),
                          style: TextStyle(
                            color: Get.theme.scaffoldBackgroundColor,
                            fontSize: 8,
                          ),
                        ),
                        Text(
                          controller.studentALLSubjectsList[index].lessonDay
                              .toString(),
                          style: TextStyle(
                            color: Get.theme.scaffoldBackgroundColor,
                            fontSize: 8,
                          ),
                        ),
                        Text(
                          AppFunctions.getDate(
                            controller.studentALLSubjectsList[index].stdLesDate
                                .toString(),
                          ),
                          style: TextStyle(
                            color: Get.theme.scaffoldBackgroundColor,
                            fontSize: 8,
                          ),
                        ),
                      ],
                    ),
                    Card(
                      color: Get.theme.primaryColor.withOpacity(0.2),
                      shape: const OutlineInputBorder(
                        borderSide: BorderSide(width: 0.5),
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(22.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            controller.studentALLSubjectsList[index].late != ''
                                ? Text(
                                    '${tr('late')} : ${controller.studentALLSubjectsList[index].late} ${tr('minute')}',
                                    style: TextStyle(
                                      color: Get.theme.scaffoldBackgroundColor,
                                      fontSize: 8,
                                    ),
                                  )
                                : Container(),
                            controller.studentALLSubjectsList[index]
                                        .studentLessonNote !=
                                    ''
                                ? Text(
                                    '${tr('note')} : ${controller.studentALLSubjectsList[index].studentLessonNote}',
                                    style: TextStyle(
                                      color: Get.theme.scaffoldBackgroundColor,
                                      fontSize: 8,
                                    ),
                                  )
                                : Container(),
                            controller.studentALLSubjectsList[index].level != ''
                                ? Text(
                                    '${tr('level')} : ${controller.studentALLSubjectsList[index].subjectMark}/${controller.studentALLSubjectsList[index].level}',
                                    style: TextStyle(
                                      color: Get.theme.scaffoldBackgroundColor,
                                      fontSize: 8,
                                    ),
                                  )
                                : Container(),
                            controller.studentALLSubjectsList[index]
                                        .studentLessonIsCome ==
                                    '0'
                                ? Text(
                                    tr('isNotCome'),
                                    style: TextStyle(
                                      color: Get.theme.scaffoldBackgroundColor,
                                      fontSize: 8,
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
