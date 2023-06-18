import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/controller/auth_controllers/teacher/lessonController.dart';
import 'package:students/controller/auth_controllers/teacher/teacherController.dart';
import 'package:students/core/class/handelingview.dart';
import 'package:students/core/constant/days.dart';

class TeacherAddLesson extends StatelessWidget {
  const TeacherAddLesson({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TeacherController teacherController = Get.find();
    LessonController lessonController = Get.put(LessonController());
    chooseDay() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            weekDays.length,
            (index) => InkWell(
              onTap: () {
                lessonController.setDay(weekDays[index]);
              },
              child: Card(
                color: lessonController.addedLessonModel.lessonDay ==
                        weekDays[index]
                    ? Get.theme.primaryColor.withOpacity(0.4)
                    : null,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
                  child: Text(weekDays[index]),
                ),
              ),
            ),
          ),
        ),
      );
    }

    addNote() {
      return TextFormField(
        maxLines: 2,
        onChanged: (value) {
          lessonController.setNote(value);
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              width: 0.2,
              color: Get.theme.primaryColor,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(18),
            ),
          ),
        ),
        controller: lessonController.noteController,
      );
    }

    chooseTime() {
      return Container(
        decoration: BoxDecoration(
          color: Get.theme.primaryColor.withOpacity(0.2),
          borderRadius: const BorderRadius.all(
            Radius.circular(18),
          ),
        ),
        height: Get.height / 3.8,
        width: Get.width / 2.2,
        child: Column(
          children: [
            Expanded(
              child: CupertinoDatePicker(
                minuteInterval: 15,
                initialDateTime: lessonController.initTime,
                mode: CupertinoDatePickerMode.time,
                onDateTimeChanged: (value) => lessonController.setTime(value),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text('time').tr(),
            ),
          ],
        ),
      );
    }

    chooseDuration() {
      return Container(
        decoration: BoxDecoration(
          color: Get.theme.primaryColor.withOpacity(0.2),
          borderRadius: const BorderRadius.all(
            Radius.circular(18),
          ),
        ),
        height: Get.height / 3.8,
        width: Get.width / 2.2,
        child: Column(
          children: [
            Expanded(
              child: CupertinoTimerPicker(
                initialTimerDuration: lessonController.initDuration,
                minuteInterval: 15,
                mode: CupertinoTimerPickerMode.hm,
                onTimerDurationChanged: (value) =>
                    lessonController.setDuration(value),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text('period').tr(),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          lessonController.addLesson();
        },
        child: GetBuilder<LessonController>(
          builder: (controller) {
            return HandelingRequest(
              statusRequest: controller.statusRequest!,
              widget: const Icon(Icons.done),
            );
          },
        ),
      ),
      appBar: AppBar(
        title: Text(
          '${tr("add_lesson")} ${teacherController.teacherModel.teacherName}',
        ),
      ),
      body: Center(
        child: GetBuilder<LessonController>(
          builder: (controller) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        chooseTime(),
                        chooseDuration(),
                      ],
                    ),
                    Divider(height: Get.height / 20),
                    chooseDay(),
                    Divider(height: Get.height / 20),
                    addNote(),
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
