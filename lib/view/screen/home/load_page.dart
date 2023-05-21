import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/core/constant/approutes.dart';

class LoadPage extends StatefulWidget {
  const LoadPage({Key? key}) : super(key: key);

  @override
  State<LoadPage> createState() => _LoadPageState();
}

class _LoadPageState extends State<LoadPage> {
  @override
  Widget build(BuildContext context) {
    print('========LoadPageLoadPageLoadPage=================');

    if (late == 0) {
      Timer(const Duration(seconds: 8), () {
        late++;
        setState(() {});
        print('========$late=================');
      });
    }

    return Scaffold(
      appBar: AppBar(title: Text('${tr('wait')}...')),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          late > 0?
              const Text('connectionError').tr()
              :
          CircularProgressIndicator(
            color: Get.theme.primaryColor,
          ),
           SizedBox(
            height: Get.height/8,
          ),
          late > 0
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      late=0;
                    });
                    Get.offAllNamed(AppRoute.load);
                  },
                  icon: Icon(Icons.refresh, color: Get.theme.primaryColor),
                )
              : Container()
        ],
      )),
    );
  }
}

int late = 0;
