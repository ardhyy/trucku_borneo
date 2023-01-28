import 'dart:convert';

import 'package:get/get.dart';
import 'package:trucku_borneo/database/model/jenis_truk.dart';
import 'package:trucku_borneo/database/services/network_handle.dart';
import 'package:trucku_borneo/util/api_endpoint.dart';
import 'package:trucku_borneo/util/widget/custom_snackbar.dart';

class HomeController extends GetxController {
  final linkImage = '${ApiEndPoint.apiUrl}${ApiEndPoint.imgUrlApi}';
  var isLoading = false.obs;
  var nama = ''.obs;
  var perusahaan = ''.obs;
  var email = ''.obs;
  var noHp = ''.obs;
  var alamat = ''.obs;

  final dataListArmada = [].obs;
  final dataBanner = [
    {
      'id': 1,
      'image': 'assets/image/img_banner.png',
      'title': 'Trucku Borneo',
      'subtitle': 'Cari Truck dengan Mudah, Instan, Aman dan Terpercaya',
    },
  ].obs;

  @override
  void onReady() {
    super.onReady();
    isLoading(true);
    getProfile();
    getArmada();
    update();
    isLoading(false);
  }

  Future<void> getProfile() async {
    try {
      final response =
          await NetworkHandle.getRequest(ApiEndPoint.userProfileApi);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var result = jsonDecode(response.body);
        nama.value = result['nama'].toString();
        email.value = result['email'].toString();
        noHp.value = result['no_hp'].toString();
        alamat.value = result['alamat'].toString();
        perusahaan.value = result['nama_perusahaan'].toString();
        if (perusahaan.value == 'null') {
          perusahaan.value = 'Update Profile Anda';
        } else {
          perusahaan.value = result['nama_perusahaan'];
        }
      } else {
        customSnackBar('Error', 'Gagal Mendapatkan Data', 'error');
      }
    } catch (e) {
      customSnackBar('Error', '$e', 'error');
    }
  }

  Future<void> getArmada() async {
    try {
      final response = await NetworkHandle.getRequest(ApiEndPoint.armadaApi);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var result = response.body;
        final truckresponse = jenistruckFromJson(result);
        for (var i = 0; i < truckresponse.data.length; i++) {
          dataListArmada.add(truckresponse.data[i].toJson());
        }
      } else {
        customSnackBar('Error', 'Gagal Mendapatkan Data', 'error');
      }
    } catch (e) {
      customSnackBar('Error', '$e', 'error');
    }
  }
}
