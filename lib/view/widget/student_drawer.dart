import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/core/function/showLongString.dart';

import '../../controller/student_controller/student_date_coontroller.dart';

class DrawerStudentWidget extends StatelessWidget {
  const DrawerStudentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StudentDatesController studentDatesController = Get.find();
    return Drawer(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  showAppBarString(
                    studentDatesController.studentModel.studentName
                        .toString(),
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '${tr('phone')} ',
                      ),
                      Text(
                        '${studentDatesController.studentModel.studentPhone}',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [

                InkWell(
                  onTap: () async {
                    if (context.locale == const Locale('ar', 'DZ')) {
                      context.locale = const Locale('en', 'US');
                    } else {
                      context.locale = const Locale('ar', 'DZ');
                    }
                    Get.updateLocale(context.locale);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: const Text('language').tr(),
                      leading: const Icon(Icons.language),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    studentDatesController.logout();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: const Text('logout').tr(),
                      leading: const Icon(Icons.logout),
                    ),
                  ),
                ),
              ],
            ),

            Expanded(child: Container()),
            Text(
              '${studentDatesController.studentModel.studentCreate}',
              style: Get.textTheme.bodySmall,
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
