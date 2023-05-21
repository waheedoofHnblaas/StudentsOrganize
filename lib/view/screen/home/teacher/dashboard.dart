import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/core/class/handelingview.dart';
import 'package:students/core/constant/approutes.dart';
import 'package:students/data/model/date_model.dart';
import 'package:students/view/widget/teacher_drawer.dart';
import '../../../../controller/dates_controller/teacher_date_controller.dart';

class TeacherDashboardPage extends StatelessWidget {
  const TeacherDashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TeacherDateController teacherDateController =
        Get.put(TeacherDateController());

    BoxDecoration cardWidgetDecoration() {
      return BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Get.theme.primaryColor.withOpacity(0.9),
            Get.theme.primaryColor.withOpacity(0.7),
            Get.theme.primaryColor.withOpacity(0.7),
            Get.theme.primaryColor.withOpacity(0.3),
          ],
          stops: const [0.0, (100 - 56.23) / 100, (100 - 56.23) / 100, 1.0],
          end: Alignment.bottomCenter,
          begin: Alignment.topCenter,
        ),
        color: Get.theme.primaryColor.withOpacity(0.5),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      );
    }

    Widget dateCardWidget(int i) {
      int index = teacherDateController.datesList.length - 1 - i;
      List<DateModel> dates = teacherDateController.datesList;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                dates[index].dateCreate.toString().split(' ')[0],
                style: Get.textTheme.bodySmall!.copyWith(color: Colors.grey),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              decoration: cardWidgetDecoration(),
              child: InkWell(
                onTap: () {
                  teacherDateController.toDataPage(dates[index]);
                },
                onLongPress: () async {
                  await teacherDateController.showDeleteDateSnackBar(
                    teacherDateController.teacherModel.teacherId.toString(),
                    dates[index].dateId.toString(),
                  );
                },
                child: ListTile(
                  style: ListTileStyle.drawer,
                  title: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 44.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          dates[index].dateDay.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(dates[index].dateTime.toString()),
                        SizedBox(
                          width: Get.width / 3,
                          child:
                              Text('${tr('period')}  ${dates[index].datePer}'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    datesList() {
      return RefreshIndicator(
        onRefresh: () async {
          return await teacherDateController.getDateByTeacherId();
        },
        child: ListView.builder(
          itemCount: teacherDateController.datesList.length,
          itemBuilder: (context, i) {
            if (teacherDateController.datesList.isNotEmpty) {
              return dateCardWidget(i);
            } else {
              return const Text('NoDates or No Internet');
            }
          },
        ),
      );
    }

    emptyListWidget() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('no_dates').tr(),
          const SizedBox(
            height: 20,
          ),
          IconButton(
            onPressed: () async {
              await teacherDateController.getDateByTeacherId();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      );
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Get.toNamed(AppRoute.addDate);
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('dates').tr(),
      ),
      drawer: const DrawerTeacherWidget(),
      body: Center(
        child: GetBuilder<TeacherDateController>(
          builder: (teacherDateController) {
            return HandelingRequest(
              statusRequest: teacherDateController.statusRequest!,
              widget: teacherDateController.datesList.isNotEmpty
                  ? datesList()
                  : emptyListWidget(),
            );
          },
        ),
      ),
    );
  }
}
