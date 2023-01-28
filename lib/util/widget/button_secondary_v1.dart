import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../const.dart';

buttonSecondaryV1(
    {required Size size,
    required String text,
    required Null Function() press}) {
  return Container(
    width: size.width,
    height: 50,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: TextButton(
      onPressed: () {
        press();
      },
      child: Text(
        text,
        style: GoogleFonts.poppins(
          color: KPColor1,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
