import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trucku_borneo/logic/controller/edit_profile.dart';

import '../../util/const.dart';
import '../../util/widget/loader.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfile();
}

class _EditProfile extends State<EditProfilePage> {
  final editController = Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final dataProfile = Get.arguments;
    return SafeArea(
      child: Scaffold(
        backgroundColor: KPColor1,
        body: SingleChildScrollView(
          controller: ScrollController(),
          child: Obx(
            () => editController.isLoading.value
                ? const Center(child: Loader())
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: size.height / 5,
                        width: size.width,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: Text(
                                'Edit Profile',
                                style: GoogleFonts.poppins(
                                  color: KPColor1,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: KdefaultPadding,
                          left: KdefaultPadding,
                          right: KdefaultPadding,
                          bottom: KdefaultPadding,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            // controller: editController.namaController =
                            //     TextEditingController(
                            //         text: dataProfile['nama']),
                            controller: editController.namaController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: const Icon(
                                Icons.person,
                                color: KPColor1,
                              ),
                              hintText: 'Nama Lengkap',
                              hintStyle: GoogleFonts.poppins(
                                color: KPColor1,
                                fontSize: 15,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                if (value.isNotEmpty) {
                                  editController.namaController.text =
                                      dataProfile['nama'];
                                  editController.update();
                                  print(value);
                                } else {
                                  editController.namaController.text = value;
                                  editController.update();
                                  print(value);
                                }
                              });
                            },
                          ),
                        ),
                      ),
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
                          child: TextField(
                            controller: editController.emailController =
                                TextEditingController(
                                    text: dataProfile['email']),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: const Icon(
                                Icons.email,
                                color: KPColor1,
                              ),
                              hintText: 'Email',
                              hintStyle: GoogleFonts.poppins(
                                color: KPColor1,
                                fontSize: 15,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                if (value.isNotEmpty) {
                                  editController.emailController.text = value;
                                  editController.update();
                                  print(value);
                                } else {
                                  editController.emailController.text =
                                      dataProfile['email'];
                                  editController.update();
                                  print(value);
                                }
                              });
                            },
                          ),
                        ),
                      ),
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
                          child: TextField(
                            controller: dataProfile['no_hp'] == 'null'
                                ? editController.noHpController
                                : editController.noHpController =
                                    TextEditingController(
                                        text: dataProfile['no_hp']),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: const Icon(
                                Icons.phone,
                                color: KPColor1,
                              ),
                              hintText: 'Nomor Telepon',
                              hintStyle: GoogleFonts.poppins(
                                color: KPColor1,
                                fontSize: 15,
                              ),
                            ),
                            onChanged: (String value) {
                              setState(() {
                                if (value.isNotEmpty) {
                                  editController.noHpController.text = value;
                                  editController.update();
                                  print(value);
                                } else {
                                  editController.noHpController.text =
                                      dataProfile['no_hp'];
                                  editController.update();
                                  print(value);
                                }
                              });
                            },
                          ),
                        ),
                      ),
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
                          child: TextField(
                            controller: dataProfile['nama_perusahaan'] ==
                                    'Update Profile Anda'
                                ? editController.perusahaanController
                                : editController.perusahaanController =
                                    TextEditingController(
                                        text: dataProfile['nama_perusahaan']),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: const Icon(
                                Icons.business,
                                color: KPColor1,
                              ),
                              hintText: 'Perusahaan',
                              hintStyle: GoogleFonts.poppins(
                                color: KPColor1,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
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
                          child: TextField(
                            controller: dataProfile['alamat_perusahaan'] ==
                                    'null'
                                ? editController.alamatController
                                : editController.alamatController =
                                    TextEditingController(
                                        text: dataProfile['alamat_perusahaan']),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: const Icon(
                                Icons.location_on,
                                color: KPColor1,
                              ),
                              hintText: 'Alamat Perusahaan',
                              hintStyle: GoogleFonts.poppins(
                                color: KPColor1,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: KdefaultPadding,
                          left: KdefaultPadding,
                          right: KdefaultPadding,
                          bottom: KdefaultPadding,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              height: 50,
                              width: size.width / 2.5,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Text(
                                    'Batalkan',
                                    style: GoogleFonts.poppins(
                                      color: KPColor1,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              width: size.width / 2.5,
                              decoration: BoxDecoration(
                                color: KPColor1,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: InkWell(
                                  onTap: () {
                                    editController.checkUpdate();
                                  },
                                  child: Text(
                                    'Submit',
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
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
