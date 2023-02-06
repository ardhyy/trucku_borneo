import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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

  double latTujuan = 0.0;
  double lngTujuan = 0.0;
  String alamatTujuan = "".obs.toString();

  double distance = 0.0;

  int biayaSewa = 0;
  String jenisArmada = "".obs.toString();

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    alamatAsalController = TextEditingController();
    alamatTujuanController = TextEditingController();
    jumlahMuatanController = TextEditingController();
    tglPengambilanController = TextEditingController();
    tglPengembalianController = TextEditingController();
    setDetailArmada();
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

  Map<String, dynamic> setDetailArmada() {
    if (Get.arguments != null) {
      final data = Get.arguments as Map<String, dynamic>;
      jenisArmada = data['jenis_truk'];
      biayaSewa = data['biaya'];
      return data;
    } else {
      return {};
    }
  }

  void handleAddressAsal() async {
    try {
      final dynamic result = await Get.toNamed(Routes.searchAddress);
      if (result != null) {
        latAsal = result[0];
        lngAsal = result[1];
        alamatAsal = result[2];
        if (alamatAsal != "" && alamatAsal.isNotEmpty) {
          alamatAsalController.value = TextEditingValue(text: alamatAsal);
          update();
        }
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  void handleAddressTujuan() async {
    try {
      final dynamic result = await Get.toNamed(Routes.searchAddress);
      if (result != null) {
        latTujuan = result[0];
        lngTujuan = result[1];
        alamatTujuan = result[2];
        if (result != "" && result.isNotEmpty) {
          alamatTujuanController.value = TextEditingValue(text: alamatTujuan);
          update();
        }
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  void hitungJarak() {
    if (alamatAsalController.text.isNotEmpty &&
        alamatTujuanController.text.isNotEmpty) {
      var jarak =
          Geolocator.distanceBetween(latAsal, lngAsal, latTujuan, lngTujuan);
      distance = jarak / 1000;
      distance = double.parse(distance.toStringAsFixed(2));
      print('jarak: $distance km');
      return;
    } else {
      customSnackBar(
          'Error', 'Alamat Asal dan Tujuan tidak boleh kosong', 'error');
    }
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
      return;
    } else {
      customSnackBar('Error',
          'Tanggal Pengambilan dan Pengembalian tidak boleh kosong', 'error');
    }
  }

  void showKonfirmasiPemesanan(double screenHeight, double screenWidth) {
    if (alamatAsalController.text.isNotEmpty &&
        alamatTujuanController.text.isNotEmpty) {
      if (jumlahMuatanController.text.isNotEmpty) {
        if (tglPengambilanController.text.isNotEmpty &&
            tglPengembalianController.text.isNotEmpty) {
          Get.bottomSheet(
            Container(
              height: screenHeight * 2,
              width: screenWidth,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: KdefaultPadding,
                      left: KdefaultPadding,
                      right: KdefaultPadding,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Konfirmasi Pemesanan',
                          style: GoogleFonts.poppins(
                            color: KPColor1,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Icons.close,
                            color: KPColor1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      top: KdefaultPadding / 2,
                      left: KdefaultPadding,
                      right: KdefaultPadding,
                    ),
                    child: Divider(
                      color: KPColor1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: KdefaultPadding,
                      left: KdefaultPadding,
                      right: KdefaultPadding,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Alamat Asal :',
                          style: GoogleFonts.poppins(
                            color: KPColor1,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: screenWidth / 2.2,
                          child: Text(
                            alamatAsalController.text,
                            style: GoogleFonts.poppins(
                              color: KPColor1,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: KdefaultPadding,
                      left: KdefaultPadding,
                      right: KdefaultPadding,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Alamat Tujuan :',
                          style: GoogleFonts.poppins(
                            color: KPColor1,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: screenWidth / 2.2,
                          child: Text(
                            alamatTujuanController.text,
                            style: GoogleFonts.poppins(
                              color: KPColor1,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: KdefaultPadding,
                      left: KdefaultPadding,
                      right: KdefaultPadding,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Jenis Truck :',
                          style: GoogleFonts.poppins(
                            color: KPColor1,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          jenisArmada,
                          style: GoogleFonts.poppins(
                            color: KPColor1,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: KdefaultPadding,
                      left: KdefaultPadding,
                      right: KdefaultPadding,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Total Biaya :',
                          style: GoogleFonts.poppins(
                            color: KPColor1,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          NumberFormat.currency(
                            locale: 'id',
                            symbol: 'Rp. ',
                            decimalDigits: 0,
                          ).format(
                            // totalHarga,
                            hitungTotalHargaSewa(),
                          ),
                          style: GoogleFonts.poppins(
                            color: KPColor1,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      top: KdefaultPadding / 2,
                      left: KdefaultPadding,
                      right: KdefaultPadding,
                    ),
                    child: Divider(
                      color: KPColor1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: KdefaultPadding / 2,
                      left: KdefaultPadding,
                      right: KdefaultPadding,
                    ),
                    child: SizedBox(
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.07,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: KPColor1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          confirmPemesanan();
                        },
                        child: Text(
                          'Pesan',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      }
    } else {
      customSnackBar('Error', 'Mohon isi semua data terlebih dahulu', 'error');
    }
  }

  int hitungTotalHargaSewa() {
    var jumlah_muatan = int.parse(jumlahMuatanController.text);
    var totalHargaSewa = ((jumlah_muatan * biayaSewa) + (distance * biayaSewa));
    var totalHarga = totalHargaSewa.toInt();
    print('total harga sewa: $totalHarga');
    return totalHarga;
  }

  void confirmPemesanan() {
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
              style: GoogleFonts.poppins(fontSize: 14, color: KtextColorLight)),
        ),
        TextButton(
          onPressed: () {
            Get.toNamed(AppRoutes.pembayaran,
                arguments: hitungTotalHargaSewa());
          },
          child: Text("Konfirmasi",
              style: GoogleFonts.poppins(fontSize: 14, color: KtextColorLight)),
        ),
      ],
    );
  }

  void cancelPemesanan() {
    if (alamatAsalController.text.isNotEmpty &&
        alamatTujuanController.text.isNotEmpty) {
      if (jumlahMuatanController.text.isNotEmpty) {
        if (tglPengambilanController.text.isNotEmpty &&
            tglPengembalianController.text.isNotEmpty) {
          Get.defaultDialog(
            title: "Batalkan Pemesanan",
            content: Padding(
              padding: const EdgeInsets.only(
                  left: KdefaultPadding, right: KdefaultPadding),
              child: Column(
                children: [
                  Text("Apakah anda yakin ingin membatalkan pemesanan?",
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
                  Get.back();
                },
                child: Text("Tidak",
                    style: GoogleFonts.poppins(
                        fontSize: 14, color: KtextColorLight)),
              ),
              TextButton(
                onPressed: () {
                  Get.offAllNamed(AppRoutes.dashboard);
                  dispose();
                },
                child: Text("Ya",
                    style: GoogleFonts.poppins(
                        fontSize: 14, color: KtextColorLight)),
              ),
            ],
          );
        }
      }
    } else {
      Get.offAllNamed(AppRoutes.dashboard);
    }
  }
}
