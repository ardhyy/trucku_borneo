import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../util/const.dart';

class TitleJenisTruk extends StatelessWidget {
  const TitleJenisTruk({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: KdefaultPadding,
        right: KdefaultPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(left: KdefaultPadding / 4),
                color: KPColor1,
                height: size.height * 0.05,
                width: size.width * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.only(left: KdefaultPadding / 2),
                child: Text(
                  'Armada',
                  style: GoogleFonts.poppins(
                    color: KtextPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
