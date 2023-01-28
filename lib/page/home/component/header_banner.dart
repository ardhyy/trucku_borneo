import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../util/const.dart';

class HeaderDataBanner extends StatelessWidget {
  const HeaderDataBanner({
    Key? key,
    required this.size,
    required this.titleBanner,
    required this.subtitleBanner,
    required this.imageBanner,
  }) : super(key: key);

  final Size size;
  final String titleBanner;
  final String subtitleBanner;
  final String imageBanner;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: KdefaultPadding,
        right: KdefaultPadding,
        top: KdefaultPadding * 6.5,
      ),
      height: 150,
      width: size.width,
      decoration: const BoxDecoration(
        color: color1,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: KdefaultPadding + 10,
            left: KdefaultPadding,
            child: Text(
              titleBanner,
              maxLines: 20,
              style: GoogleFonts.poppins(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: KdefaultPadding * 3,
            left: KdefaultPadding,
            width: 150,
            child: Text(
              subtitleBanner,
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
              style: GoogleFonts.poppins(
                fontSize: 12,
              ),
            ),
          ),
          Positioned(
            right: 5,
            top: 45,
            height: 75,
            child: Image.asset(
              imageBanner,
            ),
          )
        ],
      ),
    );
  }
}
