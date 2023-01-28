import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../const.dart';

inputField_v1(
    {required Icon prefixIcon,
    required String hintText,
    required TextEditingController controller,
    required bool obscureText}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hintText,
        prefixIcon: prefixIcon,
        hintStyle: GoogleFonts.poppins(
          color: KPColor1,
          fontSize: 15,
        ),
      ),
    ),
  );
}
