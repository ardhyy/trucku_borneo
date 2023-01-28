import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FooterLine extends StatelessWidget {
  const FooterLine({
    Key? key,
    required this.size,
    required this.defaultPadding,
  }) : super(key: key);

  final Size size;
  final double defaultPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: defaultPadding,
        right: defaultPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: size.width / 3,
            height: 1,
            color: Colors.white,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: defaultPadding / 2,
              right: defaultPadding / 2,
            ),
            child: Text(
              'atau',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
          Container(
            width: size.width / 3,
            height: 1,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
