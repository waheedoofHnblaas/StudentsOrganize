import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/core/class/statusrequest.dart';

class HandelingView extends StatelessWidget {
  HandelingView({Key? key, required this.statusRequest, required this.widget})
      : super(key: key);

  final StatusRequest statusRequest;
  Widget widget;

  @override
  Widget build(BuildContext context) {
    if (statusRequest == StatusRequest.loading) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircularProgressIndicator(
            color: Get.theme.scaffoldBackgroundColor,
            backgroundColor: Get.theme.primaryColor,
          ),
        ),
      );
    } else if (statusRequest == StatusRequest.success) {
      return widget;
    } else if (statusRequest == StatusRequest.failure) {
      return const Text('no data');
    } else {
      return const Text('Error');
    }
  }
}

class HandelingRequest extends StatelessWidget {
  HandelingRequest(
      {Key? key, required this.statusRequest, required this.widget})
      : super(key: key);

  final StatusRequest statusRequest;
  Widget widget;

  @override
  Widget build(BuildContext context) {
    if (statusRequest == StatusRequest.loading) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircularProgressIndicator(
            color: Get.theme.scaffoldBackgroundColor,
            backgroundColor: Get.theme.primaryColor,
          ),
        ),
      );
    } else if (statusRequest == StatusRequest.serverExp ||
        statusRequest == StatusRequest.offline) {
      return Column(

        children: [const Text('Error'), widget],
      );
    } else {
      return widget;
    }
  }
}
