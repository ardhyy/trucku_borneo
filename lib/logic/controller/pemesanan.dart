import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:trucku_borneo/util/const.dart';
import 'package:trucku_borneo/util/widget/custom_snackbar.dart';

import '../../routes/routes.dart';

class PemesananController extends GetxController
    with SingleGetTickerProviderMixin {
  late TabController tabController;
  late TextEditingController alamatAsalController,
      alamatTujuanController,
      jumlahMuatanController,
      tglPengambilanController,
      tglPengembalianController;

  final lamaSewa = 0.obs;
  double latAsal = 0.0;
  double lngAsal = 0.0;
  String alamatAsal = "".obs.toString();

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    alamatAsalController = TextEditingController();
    alamatTujuanController = TextEditingController();
    jumlahMuatanController = TextEditingController();
    tglPengambilanController = TextEditingController();
    tglPengembalianController = TextEditingController();
  }

  @override
  void onClose() {
    tabController.dispose();
    alamatAsalController.dispose();
    alamatTujuanController.dispose();
    jumlahMuatanController.dispose();
    tglPengambilanController.dispose();
    tglPengembalianController.dispose();
    super.onClose();
  }

  void handleAddressAsal() async {
    final dynamic result = await Get.toNamed(Routes.searchAddress);
    latAsal = result[0];
    lngAsal = result[1];
    alamatAsal = result[2];
    if (alamatAsal != "" && alamatAsal.isNotEmpty) {
      alamatAsalController.value = TextEditingValue(text: alamatAsal);
      update();
    }
    print("langtitude asal: ${lngAsal}");
    print("latitude asal: ${latAsal}");
    print(alamatAsal);
    // print(result);
  }

  void hitungLamaSewa() {
    if (tglPengambilanController.text.isNotEmpty &&
        tglPengembalianController.text.isNotEmpty) {
      var tglAmbil =
          DateFormat('dd-MM-yyyy').parse(tglPengambilanController.text);
      var tglKembali =
          DateFormat('dd-MM-yyyy').parse(tglPengembalianController.text);
      var selisih = tglKembali.difference(tglAmbil);
      lamaSewa.value = selisih.inDays;
      print('lama sewa: $lamaSewa' + ' hari');
    } else {
      customSnackBar('Error',
          'Tanggal Pengambilan dan Pengembalian tidak boleh kosong', 'error');
    }
  }

  void hitungTotalHargaSewa() {
    hitungLamaSewa();

    var totalHargaSewa = lamaSewa.value * 100000;
    print('total harga sewa: $totalHargaSewa');
  }

  void confirmPemesanan() {
    if (alamatAsalController.text.isNotEmpty &&
        alamatTujuanController.text.isNotEmpty) {
      if (jumlahMuatanController.text.isNotEmpty) {
        if (tglPengambilanController.text.isNotEmpty &&
            tglPengembalianController.text.isNotEmpty) {
          Get.defaultDialog(
            title: "Lanjut Pembayaran",
            content: Padding(
              padding: const EdgeInsets.only(
                  left: KdefaultPadding, right: KdefaultPadding),
              child: Column(
                children: [
                  Text(
                      "Apakah anda yakin ingin melakukan pemesanan dan melanjutkan ke pembayaran?",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      )),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.offAllNamed(AppRoutes.dashboard);
                },
                child: Text("Batal",
                    style: GoogleFonts.poppins(
                        fontSize: 14, color: KtextColorLight)),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("Konfirmasi",
                    style: GoogleFonts.poppins(
                        fontSize: 14, color: KtextColorLight)),
              ),
            ],
          );
          hitungTotalHargaSewa();
        }
      }
    } else {
      customSnackBar('Error', 'Lengkapi Data Form Pemesanan', 'error');
    }
  }
}
