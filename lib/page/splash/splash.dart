import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trucku_borneo/util/const.dart';

import '../../logic/controller/splash.dart';

class SplashScreen extends GetView {
  final SplashController splashController = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: KPColor1,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Image.asset(
              'assets/image/logo_splash.png',
              height: size.height * 0.8,
              width: size.width * 0.8,
            ),
          ),
        ],
      ),
    );
  }
}
