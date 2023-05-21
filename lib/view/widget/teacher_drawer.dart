import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/dates_controller/teacher_date_controller.dart';

class DrawerTeacherWidget extends StatelessWidget {
  const DrawerTeacherWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TeacherDateController controller=Get.find();
    return Drawer(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  Card(
                    color: Get.theme.primaryColor.withOpacity(0.7),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22.0),
                      child: Text(
                        controller.teacherModel.teacherName.toString(),
                        style: Get.textTheme.bodyLarge!.copyWith(
                            color: Get.theme.scaffoldBackgroundColor),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${tr('phone')} ',
                      ),
                      Text(
                        '${controller.teacherModel.teacherPhone}',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                // InkWell(
                //   onTap: () async {
                //     await controller.getDateByTeacherId();
                //   },
                //   child: ListTile(
                //     title: const Text('refresh').tr(),
                //     leading: const Icon(Icons.refresh),
                //   ),
                // ),
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
                    controller.logout();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: const Text('logout').tr(),
                      leading: const Icon(Icons.logout),
                    ),
                  ),
                ),
                // Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${controller.teacherModel.teacherCreate}',
                    style: Get.textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}