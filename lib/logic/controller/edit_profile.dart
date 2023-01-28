import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:trucku_borneo/util/widget/custom_snackbar.dart';

import '../../database/services/network_handle.dart';
import '../../util/api_endpoint.dart';
import '../../util/widget/loader.dart';

class EditProfileController extends GetxController {
  var isButtonEnabled = false.obs;
  var isLoading = false.obs;
  RxString nama = ''.obs;
  RxString email = ''.obs;
  RxString noHp = ''.obs;
  RxString alamat = ''.obs;
  RxString perusahaan = ''.obs;

  late TextEditingController namaController,
      emailController,
      noHpController,
      alamatController,
      perusahaanController;

  @override
  void onInit() {
    super.onInit();
    isLoading(true);
    setDetailProfile();
    namaController = TextEditingController(text: nama.value);
    emailController = TextEditingController(text: email.value);
    noHpController = TextEditingController(text: noHp.value);
    alamatController = TextEditingController(text: alamat.value);
    perusahaanController = TextEditingController(text: perusahaan.value);
    isLoading(false);
  }

  @override
  void onClose() {
    super.onClose();
    namaController.dispose();
    emailController.dispose();
    noHpController.dispose();
    alamatController.dispose();
    perusahaanController.dispose();
  }

  Map<String, dynamic> setDetailProfile() {
    if (Get.arguments != null) {
      final data = Get.arguments as Map<String, dynamic>;
      return data;
    } else {
      return {};
    }
  }

  void checkUpdate() {
    if (namaController.text != nama.value ||
        emailController.text != email.value ||
        noHpController.text != noHp.value ||
        alamatController.text != alamat.value ||
        perusahaanController.text != perusahaan.value) {
      Get.showOverlay(
        asyncFunction: () => doUpdate() as Future<void>,
        loadingWidget: const Loader(),
      );
      isButtonEnabled(true);
    } else {
      customSnackBar('error', 'Tidak Ada Perubahan Data', 'error');
      isButtonEnabled(false);
    }
  }

  void doUpdate() async {
    try {
      final response = await NetworkHandle.postRequestWithToken(
        ApiEndPoint.editProfileApi,
        jsonEncode({
          'nama': namaController.text,
          'email': emailController.text,
          'no_telpon': noHpController.text,
          'nama_perusahaan': perusahaanController.text,
          'alamat_perusahaan': alamatController.text,
        }),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        update();
        Get.back();
        customSnackBar('Sukses', data['message'], 'success');
      } else {
        customSnackBar('error', 'Terjadi Kesalahan', 'error');
      }
    } catch (e) {
      customSnackBar('error', e, 'error');
    }
  }
}
