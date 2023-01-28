import "package:flutter/material.dart";

import '../../../util/const.dart';
import '../../../util/widget/custom_shape.dart';

import 'header_banner.dart';
import 'header_profile.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.size,
    required this.gambar,
    required this.nama,
    required this.perusahaan,
    required this.titleBanner,
    required this.subtitleBanner,
    required this.imageBanner,
  });

  final Size size;
  final String gambar, nama, titleBanner, subtitleBanner, imageBanner;
  final StatelessWidget perusahaan;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: KdefaultPadding),
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: CustomShape(),
            child: Container(
              height: size.height * 2.5 / 5,
              color: KPColor1,
            ),
          ),
          HeaderHomeProfile(
            size: size,
            gambar: gambar,
            nama: nama,
            perusahaan: perusahaan,
          ),
          HeaderDataBanner(
              size: size,
              titleBanner: titleBanner,
              subtitleBanner: subtitleBanner,
              imageBanner: imageBanner),
        ],
      ),
    );
  }
}
