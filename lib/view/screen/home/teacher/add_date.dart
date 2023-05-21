import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:students/core/class/handelingview.dart';
import 'package:students/core/constant/days.dart';
import 'package:students/view/widget/auth/apploginbutton.dart';

import '../../../../controller/dates_controller/teacher_date_controller.dart';

class AddDatePage extends StatelessWidget {
  const AddDatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TeacherDateController teacherDateController = Get.find();

    setTimeWidget() {
      return Row(
        children: [
          Text(
            tr('time'),
            style: const TextStyle(fontSize: 21),
          ),
          Expanded(child: Container()),
          Column(
            children: [
              Row(
                children: [
                  Text('${tr('min')} '),
                  const Text('hour').tr(),
                ],
              ),
              SizedBox(
                height: Get.height / 6,
                width: Get.width / 1.8,
                child: CupertinoDatePicker(
                  initialDateTime: DateTime(2022, 01, 01, 08, 00, 00, 00),
                  use24hFormat: false,
                  minuteInterval: 1,
                  mode: CupertinoDatePickerMode.time,
                  onDateTimeChanged: (date) {
                    teacherDateController.dateTime =
                        date.toString().substring(11, 16);
                  },
                ),
              ),
            ],
          ),
        ],
      );
    }

    setDurationTimeWidget() {
      return Row(
        children: [
          Text(
            tr('period'),
            style: const TextStyle(fontSize: 21),
          ),
          Expanded(child: Container()),
          SizedBox(
            height: Get.height / 6,
            width: Get.width / 1.8,
            child: CupertinoTimerPicker(
              minuteInterval: 15,
              initialTimerDuration: const Duration(hours: 1, minutes: 30),
              mode: CupertinoTimerPickerMode.hm,
              onTimerDurationChanged: (value) {
                teacherDateController.datePeriod =
                    '${value.toString().split(':').first}:${value.toString().split(':')[1]}';
              },
            ),
          ),
        ],
      );
    }

    setDayWidget() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            weekDays.length,
            (index) => Card(
              color: teacherDateController.dateDay == weekDays[index]
                  ? Get.theme.primaryColor
                  : Get.theme.scaffoldBackgroundColor,
              child: InkWell(
                onTap: () {
                  teacherDateController.setDay(weekDays[index]);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(weekDays[index]),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('add_date').tr(),
      ),
      body: GetBuilder<TeacherDateController>(
        builder: (controller) {
          return HandelingRequest(
            statusRequest: controller.statusRequest!,
            widget: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                ),
                child: Column(
                  children: [
                    setTimeWidget(),
                    const Divider(
                      height: 22,
                    ),
                    setDurationTimeWidget(),
                    const Divider(
                      height: 22,
                    ),
                    setDayWidget(),
                    Expanded(child: Container()),
                    AppSignUpAndLoginButton(
                      text: tr('add_date'),
                      onPressed: () async {
                        await teacherDateController.addDate();
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
