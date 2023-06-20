import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/controller/auth_controllers/student/stdBayController.dart';

import '../../../../../core/class/handelingview.dart';

class BayModeStudentPage extends StatelessWidget {
  const BayModeStudentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StdBayController controller = Get.find();
    return Scaffold(
      appBar: AppBar(title: const Text('bay').tr()),
      body: Center(
        child: GetBuilder<StdBayController>(
          builder: (controller) {
            return HandelingRequest(
              statusRequest: controller.statusRequest!,
              widget: controller.bayModelList.isNotEmpty
                  ? Column(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${tr('sum')}  :  ${controller.sum.toString()}',
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 10,
                          child: ListView.builder(
                            itemCount: controller.bayModelList.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  controller.bayModelList[index].quantity
                                      .toString(),
                                ),
                                trailing: Text(
                                  controller.bayModelList[index].bayDate
                                      .toString(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  : const Text('no_bay').tr(),
            );
          },
        ),
      ),
    );
  }
}
