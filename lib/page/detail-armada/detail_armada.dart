import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trucku_borneo/page/pemesanan/pemesanan.dart';
import 'package:trucku_borneo/routes/routes.dart';
import 'package:trucku_borneo/util/widget/custom_snackbar.dart';

import '../../logic/controller/detail_armada.dart';
import '../../util/const.dart';

class DetailArmadaPage extends GetView<DetailArmadaController> {
  DetailArmadaPage({super.key});

  final detailController = Get.put(DetailArmadaController());

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final dataPerusahaan = GetStorage().read('perusahaan');
    return Scaffold(
      backgroundColor: KBgColor,
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: KBgColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            icon: SvgPicture.asset(
              'assets/icon/icon-back.svg',
              height: 20,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        backgroundColor: KPColor1,
        elevation: 0,
      ),
      body: GetBuilder<DetailArmadaController>(
        init: DetailArmadaController(),
        builder: (controller) {
          return SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: KdefaultPadding),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: KPColor1,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: KdefaultPadding),
                            height: screenWidth * 0.7,
                            width: screenWidth * 0.7,
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  height: screenHeight * 0.7,
                                  width: screenWidth * 0.7,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: Center(
                                    child: Image.network(
                                      "${controller.setDetailArmada()['image_armada']}",
                                      width: screenWidth * 0.7,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: KdefaultPadding / 2),
                          child: Center(
                            child: Text(
                              "${controller.setDetailArmada()['jenis_truk']}",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: KdefaultPadding / 2,
                          ),
                          child: Column(
                            children: <Widget>[
                              Center(
                                child: Text(
                                  "${controller.setDetailArmada()['dimensi']}",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Center(
                                    child: Text(
                                      "${controller.setDetailArmada()['volume']}",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: screenWidth * 0.05),
                                  Center(
                                    child: Text(
                                      "${controller.setDetailArmada()['beban_maks']}",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(KdefaultPadding),
                    padding: const EdgeInsets.symmetric(
                      horizontal: KdefaultPadding,
                      vertical: KdefaultPadding / 2,
                    ),
                    decoration: BoxDecoration(
                      color: KPColor1,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          if (dataPerusahaan == null) {
                            customSnackBar(
                              'Pemberitahuan',
                              'Lengkapi Data Profile Anda Terlebih Dahulu',
                              'warning',
                            );
                          } else {
                            Get.to(() => PemesananPage(), arguments: {
                              'jenis_truk':
                                  controller.setDetailArmada()['jenis_truk'],
                              'biaya': controller.setDetailArmada()['biaya'],
                            });
                          }
                          // Get.toNamed(AppRoutes.pembayaran);
                        },
                        child: Text(
                          'Pesan Sekarang',
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
        },
      ),
    );
  }
}
