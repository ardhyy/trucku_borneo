import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../logic/controller/pemesanan.dart';
import '../../routes/routes.dart';
import '../../util/const.dart';

class PemesananPage extends StatefulWidget {
  const PemesananPage({super.key});

  @override
  State<PemesananPage> createState() => _PemesananState();
}

class _PemesananState extends State<PemesananPage> {
  final PemesananController _pemesananController =
      Get.put(PemesananController());

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    var selectedDate = DateTime.now();
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: screenHeight / 5,
                width: screenWidth,
                decoration: const BoxDecoration(
                  color: KPColor1,
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
                        'Pemesanan',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: KdefaultPadding,
                  vertical: KdefaultPadding,
                ),
                child: Container(
                  height: 340,
                  width: 330,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 2,
                      color: KPColor1,
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(KdefaultPadding / 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TabBar(
                          unselectedLabelColor: KPColor1,
                          labelColor: Colors.white,
                          indicatorColor: Colors.white,
                          indicatorWeight: 2,
                          indicator: BoxDecoration(
                            color: KPColor1,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          controller: _pemesananController.tabController,
                          tabs: <Widget>[
                            Tab(
                              child: Text(
                                'Asal',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Tujuan',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _pemesananController.tabController,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: KdefaultPadding,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: TextField(
                                        controller: _pemesananController
                                            .alamatAsalController,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          prefixIcon: const Icon(
                                            Icons.location_on,
                                            color: KPColor1,
                                          ),
                                          hintText: 'Alamat Asal',
                                          hintStyle: GoogleFonts.poppins(
                                            color: KPColor1,
                                            fontSize: 15,
                                          ),
                                        ),
                                        onTap: _pemesananController
                                            .handleAddressAsal,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: KdefaultPadding,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: TextField(
                                        controller: _pemesananController
                                            .jumlahMuatanController,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          prefixIcon: const Icon(
                                            Icons.local_gas_station,
                                            color: KPColor1,
                                          ),
                                          hintText: 'Jumlah Muatan (Ton)',
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
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: TextField(
                                        controller: _pemesananController
                                            .tglPengambilanController,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          prefixIcon: const Icon(
                                            Icons.calendar_today,
                                            color: KPColor1,
                                          ),
                                          hintText: 'Tanggal Pengambilan',
                                          hintStyle: GoogleFonts.poppins(
                                            color: KPColor1,
                                            fontSize: 15,
                                          ),
                                        ),
                                        onTap: () async {
                                          final DateTime? picked =
                                              await showDatePicker(
                                                  context: context,
                                                  initialDate: selectedDate,
                                                  firstDate: DateTime(1900),
                                                  lastDate: DateTime(2100));
                                          if (picked != null &&
                                              picked != selectedDate)
                                            setState(() {
                                              selectedDate = picked;
                                              _pemesananController
                                                      .tglPengambilanController
                                                      .text =
                                                  DateFormat("dd-MM-yyyy")
                                                      .format(selectedDate);
                                            });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: KdefaultPadding,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: TextField(
                                        controller: _pemesananController
                                            .alamatTujuanController,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          prefixIcon: const Icon(
                                            Icons.location_on,
                                            color: KPColor1,
                                          ),
                                          hintText: 'Alamat Tujuan',
                                          hintStyle: GoogleFonts.poppins(
                                            color: KPColor1,
                                            fontSize: 15,
                                          ),
                                        ),
                                        onTap: _pemesananController
                                            .handleAddressTujuan,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: KdefaultPadding,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: TextField(
                                        controller: _pemesananController
                                            .tglPengembalianController,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          prefixIcon: const Icon(
                                            Icons.calendar_today,
                                            color: KPColor1,
                                          ),
                                          hintText: 'Tanggal Pengembalian',
                                          hintStyle: GoogleFonts.poppins(
                                            color: KPColor1,
                                            fontSize: 15,
                                          ),
                                        ),
                                        onTap: () async {
                                          final DateTime? picked =
                                              await showDatePicker(
                                                  context: context,
                                                  initialDate: selectedDate,
                                                  firstDate: DateTime(1900),
                                                  lastDate: DateTime(2100));
                                          if (picked != null &&
                                              picked != selectedDate)
                                            setState(() {
                                              selectedDate = picked;
                                              _pemesananController
                                                      .tglPengembalianController
                                                      .text =
                                                  DateFormat("dd-MM-yyyy")
                                                      .format(selectedDate);
                                            });
                                        },
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: KdefaultPadding / 4,
                  left: KdefaultPadding,
                  right: KdefaultPadding,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: screenHeight / 12,
                      width: screenWidth / 2.5,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: KPColor1,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            _pemesananController.cancelPemesanan();
                          },
                          child: Text(
                            'Batal',
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
                      height: screenHeight / 12,
                      width: screenWidth / 2.5,
                      decoration: BoxDecoration(
                        color: KPColor1,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            _pemesananController.showKonfirmasiPemesanan(
                                screenHeight, screenWidth);
                          },
                          child: Text(
                            'Konfirmasi',
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
    );
  }
}
