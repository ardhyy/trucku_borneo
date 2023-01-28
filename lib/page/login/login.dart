import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trucku_borneo/logic/controller/login.dart';

import '../../util/const.dart';
import 'component/body.dart';

class LoginView extends GetView<LoginController> {
  LoginView({super.key});

  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: KPColor1,
        body: BodyLogin(size: size, loginController: loginController),
      ),
    );
  }
}
