import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trucku_borneo/database/services/network_handle.dart';
import 'package:trucku_borneo/logic/controller/profile.dart';
import 'package:trucku_borneo/routes/routes.dart';

import '../../util/const.dart';
import '../../util/widget/custom_shape.dart';

class ProfilePage extends GetView<ProfileController> {
  ProfilePage({super.key});

  final _profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final gambar = GetStorage().read('avatar');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: KPColor1,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: GetBuilder<ProfileController>(builder: (controller) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin:
                      const EdgeInsets.only(bottom: KdefaultPadding * 2 / 5),
                  child: Stack(
                    children: <Widget>[
                      ClipPath(
                        clipper: CustomShape(),
                        child: Container(
                          height: size.height * 2.5 / 6,
                          color: KPColor1,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(
                              top: KdefaultPadding - 10,
                              left: KdefaultPadding,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '${controller.nama}',
                                  style: GoogleFonts.poppins(
                                    color: KtextPrimary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '${controller.email}',
                                  style: GoogleFonts.poppins(
                                    color: KtextColorLight,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: KdefaultPadding - 10,
                              right: KdefaultPadding,
                            ),
                            child: Stack(
                              children: [
                                Obx(
                                  () => _profileController
                                              .selectedImagePath.value ==
                                          ''
                                      ? CircleAvatar(
                                          radius: 35,
                                          backgroundColor: KBgColor,
                                          child: CircleAvatar(
                                            radius: 30,
                                            backgroundImage: NetworkImage(
                                              "${_profileController.linkImage}/$gambar",
                                            ),
                                          ),
                                        )
                                      : CircleAvatar(
                                          radius: 35,
                                          backgroundColor: KBgColor,
                                          child: CircleAvatar(
                                            radius: 30,
                                            backgroundImage: Image.file(
                                              File(_profileController
                                                  .selectedImagePath.value),
                                            ).image,
                                          ),
                                        ),
                                ),
                                Positioned(
                                  bottom: 1,
                                  right: 1,
                                  child: InkWell(
                                    onTap: () {
                                      Get.bottomSheet(Container(
                                        height: size.height * 0.3,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                top: KdefaultPadding,
                                                bottom: KdefaultPadding * 2,
                                              ),
                                              child: Text(
                                                'Pilih Gambar Profile',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    controller.getImage(
                                                        ImageSource.gallery);
                                                  },
                                                  child: Column(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/icon/gallery.svg',
                                                        height: 30,
                                                        color: KPrimary,
                                                      ),
                                                      const SizedBox(
                                                        height:
                                                            KdefaultPadding / 2,
                                                      ),
                                                      Text(
                                                        'Galeri',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    controller.getImage(
                                                        ImageSource.camera);
                                                  },
                                                  child: Column(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/icon/camera.svg',
                                                        height: 30,
                                                        color: KPrimary,
                                                      ),
                                                      const SizedBox(
                                                        height:
                                                            KdefaultPadding / 2,
                                                      ),
                                                      Text(
                                                        'Kamera',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 3,
                                            color: Colors.white,
                                          ),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(
                                              50,
                                            ),
                                          ),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              offset: const Offset(2, 4),
                                              color: Colors.black.withOpacity(
                                                0.3,
                                              ),
                                              blurRadius: 3,
                                            ),
                                          ]),
                                      child: const Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: Icon(
                                          Icons.add_a_photo,
                                          color: Colors.black,
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Card(
                        margin: const EdgeInsets.only(
                          top: KdefaultPadding * 5,
                          left: KdefaultPadding,
                          right: KdefaultPadding,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(
                              height: KdefaultPadding * 2,
                              child: ListTile(
                                title: Text(
                                  "Personal Info",
                                  style: GoogleFonts.lato(
                                    color: KtextPrimary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    Get.toNamed(
                                      AppRoutes.editProfile,
                                      arguments: {
                                        'nama': controller.nama.value,
                                        'email': controller.email.value,
                                        'no_hp': controller.noHp.value,
                                        'alamat_perusahaan':
                                            controller.alamat.value,
                                        'nama_perusahaan':
                                            controller.perusahaan.value,
                                      },
                                    );
                                  },
                                  icon: SvgPicture.asset(
                                    "assets/icon/settings.svg",
                                    height: KdefaultPadding,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: KdefaultPadding * 2.5,
                              child: ListTile(
                                title: Text(
                                  'No. Handphone',
                                  style: GoogleFonts.lato(
                                    color: KtextColorLight,
                                    fontSize: 12,
                                  ),
                                ),
                                subtitle: Text(
                                  '${controller.noHp}',
                                  style: GoogleFonts.lato(
                                    color: KtextSecondary,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: KdefaultPadding * 3.5,
                              child: ListTile(
                                title: Text(
                                  'Perusahaan',
                                  style: GoogleFonts.lato(
                                    color: KtextColorLight,
                                    fontSize: 12,
                                  ),
                                ),
                                subtitle: Text(
                                  '${controller.perusahaan}',
                                  style: GoogleFonts.lato(
                                    color: KtextSecondary,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: KdefaultPadding * 13.5,
                          left: KdefaultPadding,
                          right: KdefaultPadding,
                        ),
                        child: InkWell(
                          onTap: () {
                            Get.bottomSheet(
                              Container(
                                height: size.height * 0.5,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                child: ListView(
                                  children: <Widget>[
                                    Container(
                                      margin: const EdgeInsets.only(
                                        top: KdefaultPadding,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Ganti Password",
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                        top: KdefaultPadding,
                                        left: KdefaultPadding,
                                        right: KdefaultPadding,
                                      ),
                                      child: TextFormField(
                                        obscureText: true,
                                        controller:
                                            _profileController.pwOldController,
                                        decoration: InputDecoration(
                                          labelText: "Password Lama",
                                          labelStyle: GoogleFonts.poppins(
                                            color: KtextColorLight,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          hintText: "Masukkan Password Lama",
                                          hintStyle: GoogleFonts.poppins(
                                            color: KtextColorLight,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                              color: KPColor1,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                              color: KPColor1,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                        top: KdefaultPadding,
                                        left: KdefaultPadding,
                                        right: KdefaultPadding,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                            width: size.width * 0.4,
                                            child: TextFormField(
                                              obscureText: true,
                                              controller: _profileController
                                                  .pwNewController,
                                              decoration: InputDecoration(
                                                labelText: "Password Baru",
                                                labelStyle: GoogleFonts.poppins(
                                                  color: KtextColorLight,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                hintText:
                                                    "Masukkan Password Baru",
                                                hintStyle: GoogleFonts.poppins(
                                                  color: KtextColorLight,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                    color: KPColor1,
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                    color: KPColor1,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.4,
                                            child: TextFormField(
                                              obscureText: true,
                                              controller: _profileController
                                                  .pwConfirmController,
                                              decoration: InputDecoration(
                                                labelText:
                                                    "Konfirmasi Password",
                                                labelStyle: GoogleFonts.poppins(
                                                  color: KtextColorLight,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                hintText:
                                                    "Masukkan Konfirmasi Password",
                                                hintStyle: GoogleFonts.poppins(
                                                  color: KtextColorLight,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                    color: KPColor1,
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                    color: KPColor1,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                        top: KdefaultPadding,
                                        left: KdefaultPadding,
                                        right: KdefaultPadding,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                            width: size.width * 0.4,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    KtextColorLight,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              child: Text(
                                                "Batal",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.4,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                _profileController
                                                    .checkEditPassword();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: KPColor1,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              child: Text(
                                                "Simpan",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.all(KdefaultPadding),
                              child: Row(
                                children: <Widget>[
                                  SvgPicture.asset(
                                    "assets/icon/lock.svg",
                                    height: 22,
                                  ),
                                  const SizedBox(width: KdefaultPadding),
                                  Text(
                                    "Ganti Password",
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const Spacer(),
                                  SvgPicture.asset(
                                    "assets/icon/angle-right.svg",
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: KdefaultPadding * 17.5,
                          left: KdefaultPadding,
                          right: KdefaultPadding,
                        ),
                        child: InkWell(
                          onTap: (() {
                            NetworkHandle.logoutApi();
                          }),
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.all(KdefaultPadding),
                              child: Row(
                                children: <Widget>[
                                  SvgPicture.asset(
                                    "assets/icon/logout.svg",
                                    height: 22,
                                  ),
                                  const SizedBox(width: KdefaultPadding),
                                  Text(
                                    "Logout",
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const Spacer(),
                                  SvgPicture.asset(
                                    "assets/icon/angle-right.svg",
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
