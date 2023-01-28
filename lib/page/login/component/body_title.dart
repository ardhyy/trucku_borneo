import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BodyTitle extends StatelessWidget {
  const BodyTitle({
    Key? key,
    required this.defaultPadding,
    required this.title,
  }) : super(key: key);

  final double defaultPadding;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: defaultPadding / 1,
        left: defaultPadding,
        right: defaultPadding,
        bottom: defaultPadding,
      ),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
