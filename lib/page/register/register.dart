import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trucku_borneo/logic/controller/register.dart';

import '../../util/const.dart';
import 'component/body.dart';

class RegisterView extends GetView<RegisterController> {
  RegisterView({super.key});

  final registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: KPColor1,
        body: BodyRegister(size: size, registerController: registerController),
      ),
    );
  }
}
