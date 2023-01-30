import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trucku_borneo/logic/controller/history_order.dart';

import '../../util/const.dart';
import '../../util/widget/custom_shape.dart';

class HistoryOrderPage extends StatefulWidget {
  const HistoryOrderPage({super.key});

  @override
  State<HistoryOrderPage> createState() => _HistoryOrder();
}

class _HistoryOrder extends State<HistoryOrderPage> {
  @override
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(bottom: KdefaultPadding * 2 / 10),
                child: Stack(
                  children: <Widget>[
                    ClipPath(
                      clipper: CustomShape(),
                      child: Container(
                        height: size.height * 2.5 / 8,
                        color: KPColor1,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: KdefaultPadding * 2,
                        left: KdefaultPadding,
                        right: KdefaultPadding,
                      ),
                      child: Center(
                        child: Text(
                          'Riwayat Pemesanan',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        right: KdefaultPadding,
                        left: KdefaultPadding,
                        top: KdefaultPadding * 8,
                      ),
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 2,
                          color: KPColor1,
                        ),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            left: KdefaultPadding / 2,
                            top: KdefaultPadding / 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: KdefaultPadding / 2),
                                  child: Text(
                                    "JBorneo_01",
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: KtextColorLight,
                                    ),
                                  ),
                                ),
                                Text("Jumlah Muatan")
                              ],
                            ),
                          ),
                        ],
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
