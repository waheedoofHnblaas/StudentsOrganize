import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/model/lesson_model.dart';

Widget lessonWidget(List<LessonModel> lessons, int index) {
  return Column(
    children: [
      Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: lessons[index].lessonIsExam == '1'
                          ? Get.theme.primaryColor
                          : Get.theme.primaryColor.withOpacity(0.1),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            lessons[index].lessonNote.toString() == '' ||
                                    lessons[index].lessonNote.toString() ==
                                        'no_comment'
                                ? '${tr('lesson')} ${index + 1}'
                                : lessons[index].lessonNote.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            lessons[index].lessonCreate.toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      lessons[index].lessonIsExam.toString() == '1'
                          ? tr('exam_mark')
                          : '',
                      style: TextStyle(
                        color: lessons[index].lessonIsExam.toString() == '1'
                            ? Colors.red
                            : Get.theme.primaryColor,
                      ),
                    ),
                    Text(
                      '${tr('late')} : ${lessons[index].lessonLate.toString()}',
                    ),
                    Text(
                      '${tr("mark")} : ${lessons[index].lessonMark.toString()}',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      Divider()
    ],
  );
}
