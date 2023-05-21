import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/controller/teacher_controller/get_lessons_controller.dart';
import 'package:students/core/class/handelingview.dart';
import 'package:students/view/widget/auth/apptextfield.dart';

class AddLessonStudentPage extends StatelessWidget {
  const AddLessonStudentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LessonController lessonController = Get.find();

    setMarkWidget() {
      return GetBuilder<LessonController>(
        builder: (cont) {
          return Row(
            children: [
              Expanded(
                flex: 6,
                child: AppTextField(
                  auto: cont.isExam ? true : false,
                  lines: 1,
                  type: cont.isExam ? tr('exam_mark') : tr('mark'),
                  iconData: Icons.note_add_outlined,
                  inputType: TextInputType.text,
                  onChanged: (p0) {},
                  validator: (p0) {},
                  textFieldController: lessonController.mark,
                ),
              ),
              Column(
                children: [
                  const Text('exam').tr(),
                  Switch(
                    value: lessonController.isExam,
                    onChanged: (value) {
                      lessonController.changeIsExam();
                    },
                  ),
                ],
              ),
              Expanded(child: Container()),
            ],
          );
        },
      );
    }

    floatingBtn() {
      return FloatingActionButton(
        onPressed: () async {
          await lessonController.addLesson();
          Get.back();
        },
        child: GetBuilder<LessonController>(
          builder: (controller) => HandelingRequest(
            statusRequest: controller.statusRequest!,
            widget: const Icon(Icons.done),
          ),
        ),
      );
    }

    appBar() {
      return AppBar(
        title: Text(
          '${tr('add_lesson')} ${lessonController.studentModel.studentName.toString()}',
        ),
      );
    }

    setLateWidget() {
      return SizedBox(
        height: Get.height / 8,
        width: Get.width / 1.2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              tr('late'),
              style: const TextStyle(fontSize: 21),
            ),
            Expanded(
              child: CupertinoTimerPicker(
                minuteInterval: 5,
                mode: CupertinoTimerPickerMode.hm,
                onTimerDurationChanged: (value) {
                  lessonController.late =
                      '${value.toString().split(':').first}:${value.toString().split(':')[1]}';
                },
              ),
            ),
            TextButton(
              onPressed: () {
                lessonController.changeShowNote();
              },
              child: const Text('add_note').tr(),
            ),
          ],
        ),
      );
    }

    setNoteWidget() {
      return GetBuilder<LessonController>(
        builder: (controller) => lessonController.showNote
            ? AppTextField(
                lines: 2,
                type: tr('note'),
                iconData: Icons.note_add_outlined,
                inputType: TextInputType.text,
                onChanged: (p0) {},
                validator: (p0) {},
                textFieldController: lessonController.noteController,
              )
            : Container(),
      );
    }

    return Scaffold(
      floatingActionButton: floatingBtn(),
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            setMarkWidget(),
            const Divider(
              height: 22,
            ),
            setLateWidget(),
            const Divider(
              height: 22,
            ),
            setNoteWidget(),
          ],
        ),
      ),
    );
  }
}
