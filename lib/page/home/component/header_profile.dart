import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../util/const.dart';

class HeaderHomeProfile extends StatelessWidget {
  const HeaderHomeProfile({
    Key? key,
    required this.size,
    required this.gambar,
    required this.nama,
    required this.perusahaan,
  }) : super(key: key);

  final Size size;
  final String gambar;
  final String nama;
  final StatelessWidget perusahaan;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: KdefaultPadding * 2,
        left: KdefaultPadding,
        right: KdefaultPadding,
      ),
      child: Row(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 30,
              child: SizedBox(
                width: size.width * 0.2,
                height: size.height * 0.2,
                child: ClipOval(
                  child: Image.network(
                    gambar,
                    height: KdefaultPadding * 4,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                nama,
                style: GoogleFonts.poppins(
                  color: KBgColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              perusahaan,
            ],
          ),
        ],
      ),
    );
  }
}
