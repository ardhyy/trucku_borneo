import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trucku_borneo/database/services/network_handle.dart';
import 'package:trucku_borneo/routes/routes.dart';
import 'package:trucku_borneo/util/api_endpoint.dart';

import '../../util/widget/custom_snackbar.dart';
import '../../util/widget/loader.dart';

class RegisterController extends GetxController {
  late TextEditingController nameController,
      emailController,
      passwordController,
      confirmPasswordController;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void checkRegister() {
    if (nameController.text.isEmpty) {
      customSnackBar('Error', 'Nama tidak boleh kosong', 'error');
    } else if (GetUtils.isEmail(emailController.text) == false) {
      customSnackBar('Error', 'Email tidak valid', 'error');
    } else if (emailController.text.isEmpty) {
      customSnackBar('Error', 'Email tidak boleh kosong', 'error');
    } else if (passwordController.text.isEmpty) {
      customSnackBar('Error', 'Password tidak boleh kosong', 'error');
    } else if (confirmPasswordController.text.isEmpty) {
      customSnackBar(
          'Error', 'Konfirmasi password tidak boleh kosong', 'error');
    } else if (passwordController.text != confirmPasswordController.text) {
      customSnackBar('Error', 'Password tidak sama', 'error');
    } else if (passwordController.text.length < 6) {
      customSnackBar('Error', 'Password minimal 6 karakter', 'error');
    } else {
      Get.showOverlay(
        asyncFunction: () => doRegister() as Future<void>,
        loadingWidget: const Loader(),
      );
    }
  }

  void doRegister() async {
    try {
      final response = await NetworkHandle.postRequest(
          ApiEndPoint.registerApi,
          jsonEncode({
            'nama': nameController.text,
            'email': emailController.text,
            'password': passwordController.text,
          }));
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.offAllNamed(Routes.login);
        customSnackBar('Success', 'Register Akun Sukses', 'success');
      } else {
        customSnackBar('Error', 'Gagal Register Akun', 'error');
      }
      nameController.clear();
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
    } catch (e) {
      customSnackBar('Error', '$e', 'error');
    }
  }
}
