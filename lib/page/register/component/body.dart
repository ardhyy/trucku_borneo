import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../logic/controller/register.dart';
import '../../../routes/routes.dart';
import '../../../util/const.dart';
import '../../../util/widget/button_secondary_v1.dart';
import '../../../util/widget/input_field_v1.dart';
import 'body_heading.dart';
import 'body_title.dart';
import 'footer_button.dart';
import 'footer_line.dart';

class BodyRegister extends StatelessWidget {
  const BodyRegister({
    Key? key,
    required this.size,
    required this.registerController,
  }) : super(key: key);

  final Size size;
  final RegisterController registerController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: GetBuilder<RegisterController>(builder: (controller) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            BodyHeading(size: size, logoImage: 'assets/image/logo-text.png'),
            const Padding(
              padding: EdgeInsets.only(
                top: KdefaultPadding / 1,
                left: KdefaultPadding,
                right: KdefaultPadding,
                bottom: KdefaultPadding,
              ),
              child: BodyTitlePage(
                title: 'Register',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: KdefaultPadding,
                right: KdefaultPadding,
                bottom: KdefaultPadding,
              ),
              child: inputField_v1(
                controller: registerController.nameController,
                obscureText: false,
                prefixIcon: const Icon(
                  Icons.person,
                  color: KPColor1,
                ),
                hintText: 'Nama Lengkap',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: KdefaultPadding,
                right: KdefaultPadding,
                bottom: KdefaultPadding,
              ),
              child: inputField_v1(
                controller: registerController.emailController,
                obscureText: false,
                prefixIcon: const Icon(
                  Icons.email,
                  color: KPColor1,
                ),
                hintText: 'Email',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: KdefaultPadding,
                right: KdefaultPadding,
                bottom: KdefaultPadding,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: inputField_v1(
                  controller: registerController.passwordController,
                  obscureText: true,
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: KPColor1,
                  ),
                  hintText: 'Password',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: KdefaultPadding,
                right: KdefaultPadding,
                bottom: KdefaultPadding * 1.5,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: inputField_v1(
                  controller: registerController.confirmPasswordController,
                  obscureText: true,
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: KPColor1,
                  ),
                  hintText: 'Confirm Password',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: KdefaultPadding,
                right: KdefaultPadding,
                bottom: KdefaultPadding,
              ),
              child: buttonSecondaryV1(
                size: size,
                text: 'Register',
                press: () {
                  registerController.checkRegister();
                },
              ),
            ),
            FooterLine(size: size, defaultPadding: KdefaultPadding),
            FooterButton(
              defaultPadding: KdefaultPadding,
              press: () {
                Get.offAllNamed(AppRoutes.login);
              },
            ),
          ],
        );
      }),
    );
  }
}
