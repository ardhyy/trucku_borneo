import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trucku_borneo/logic/controller/home.dart';

import '../../../routes/routes.dart';
import '../../../util/const.dart';
import '../../../util/widget/loader.dart';

import 'card_truk.dart';
import 'header.dart';
import 'title_jenis.dart';

class BodyHome extends StatelessWidget {
  const BodyHome(
      {super.key,
      required this.size,
      required this.controller,
      required this.gambar});

  final Size size;
  final HomeController controller;
  final String gambar;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Obx(
          () => controller.isLoading.value
              ? const Loader()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Header(
                      size: size,
                      gambar: "${controller.linkImage}/$gambar",
                      nama: "${controller.nama}",
                      perusahaan: controller.perusahaan.value ==
                              "Update Profile Anda"
                          ? InkWell(
                              onTap: () {
                                Get.toNamed(AppRoutes.editProfile, arguments: {
                                  'nama': controller.nama.value,
                                  'email': controller.email.value,
                                  'no_hp': controller.noHp.value,
                                  'alamat': controller.alamat.value,
                                  'perusahaan': controller.perusahaan.value,
                                });
                              },
                              child: Text(
                                controller.perusahaan.value,
                                style: GoogleFonts.poppins(
                                  color: KtextPrimary,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            )
                          : Text(
                              controller.perusahaan.value,
                              style: GoogleFonts.poppins(
                                color: KtextPrimary,
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                      titleBanner: "${controller.dataBanner[0]['title']}",
                      subtitleBanner: "${controller.dataBanner[0]['subtitle']}",
                      imageBanner: "${controller.dataBanner[0]['image']}",
                    ),
                    TitleJenisTruk(size: size),
                    Obx(
                      () => controller.dataListArmada.isEmpty
                          ? Container(
                              margin: const EdgeInsets.only(
                                top: KdefaultPadding / 2,
                                left: KdefaultPadding,
                                right: KdefaultPadding,
                              ),
                              child: Text(
                                'Belum ada armada',
                                style: GoogleFonts.poppins(
                                  color: KtextPrimary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            )
                          : SizedBox(
                              height: size.height * 0.26,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.dataListArmada.length,
                                itemBuilder: (context, index) {
                                  return CardJenisTruk(
                                    size: size,
                                    cardID: controller.dataListArmada[index]
                                        ['id'],
                                    cardImage: controller.dataListArmada[index]
                                        ['image_armada'],
                                    cardTitle: controller.dataListArmada[index]
                                        ['jenis_truk'],
                                    cardButton: AppRoutes.detailArmada,
                                    arguments: controller.dataListArmada[index],
                                  );
                                },
                              ),
                            ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
