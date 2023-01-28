import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:trucku_borneo/database/services/network_handle.dart';
import 'package:trucku_borneo/routes/routes.dart';

import '../../database/model/costumer.dart';
import '../../util/api_endpoint.dart';
import '../../util/widget/custom_snackbar.dart';
import '../../util/widget/loader.dart';

class LoginController extends GetxController {
  final getStorage = GetStorage();
  late TextEditingController emailController, passwordController;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void checkLogin() {
    if (GetUtils.isEmail(emailController.text) == false) {
      if (emailController.text.isEmpty) {
        customSnackBar('Error', 'Email Tidak Boleh Kosong', 'error');
      } else {
        customSnackBar('Error', 'Email Tidak Valid', 'error');
      }
    } else if (passwordController.text.isEmpty) {
      customSnackBar('Error', 'Password tidak boleh kosong', 'error');
    } else {
      Get.showOverlay(
        asyncFunction: () => doLogin() as Future<void>,
        loadingWidget: const Loader(),
      );
    }
  }

  void doLogin() async {
    try {
      final response = await NetworkHandle.postRequest(
          ApiEndPoint.loginApi,
          jsonEncode({
            'email': emailController.text,
            'password': passwordController.text,
          }));
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = response.body;
        var user = costumerModelFromJson(data);
        Get.offAllNamed(Routes.dashboard);
        customSnackBar('Sukses', 'Login Sukses', 'success');
        NetworkHandle.storeToken(user.token);
        getStorage.write('avatar', user.data.avatar);
        getStorage.write('perusahaan', user.data.perusahaan);
      } else {
        customSnackBar('Error',
            'Email / Password salah Atau Akun Anda Belum Di Aktifkan', 'error');
      }
      emailController.clear();
      passwordController.clear();
    } catch (e) {
      customSnackBar('Error', '$e', 'error');
    }
  }
}
