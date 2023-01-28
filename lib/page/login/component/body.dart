import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trucku_borneo/util/widget/button_secondary_v1.dart';
import 'package:trucku_borneo/util/widget/input_field_v1.dart';

import '../../../logic/controller/login.dart';
import '../../../routes/routes.dart';
import '../../../util/const.dart';
import 'body_heading.dart';
import 'body_title.dart';
import 'footer_button.dart';
import 'footer_line.dart';

class BodyLogin extends StatelessWidget {
  const BodyLogin({
    Key? key,
    required this.size,
    required this.loginController,
  }) : super(key: key);

  final Size size;
  final LoginController loginController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: GetBuilder<LoginController>(builder: (controller) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            BodyHeading(size: size, logoImage: 'assets/image/logo-text.png'),
            const BodyTitle(defaultPadding: KdefaultPadding, title: 'Login'),
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
                    obscureText: false,
                    prefixIcon: const Icon(
                      Icons.email,
                      color: KPColor1,
                    ),
                    hintText: 'Email',
                    controller: loginController.emailController),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: KdefaultPadding,
                right: KdefaultPadding,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: inputField_v1(
                    obscureText: true,
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: KPColor1,
                    ),
                    hintText: 'Password',
                    controller: loginController.passwordController),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: KdefaultPadding,
                right: KdefaultPadding,
                top: KdefaultPadding / 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Get.dialog(
                        AlertDialog(
                          title: const Text('Lupa Password'),
                          content: const Text(
                              'Silahkan hubungi admin untuk mereset password anda'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Text(
                      'Lupa Password?',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
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
                  text: "Login",
                  press: () {
                    loginController.checkLogin();
                  }),
            ),
            FooterLine(size: size, defaultPadding: KdefaultPadding),
            FooterButton(
              defaultPadding: KdefaultPadding,
              press: () {
                Get.offAllNamed(AppRoutes.register);
              },
            ),
          ],
        );
      }),
    );
  }
}
