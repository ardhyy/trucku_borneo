import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../util/const.dart';

class CardJenisTruk extends StatelessWidget {
  const CardJenisTruk({
    Key? key,
    required this.size,
    required this.cardImage,
    required this.cardTitle,
    required this.cardID,
    required this.arguments,
    required this.cardButton,
  }) : super(key: key);

  final Size size;
  final String cardImage, cardTitle;
  final int cardID;
  final dynamic arguments;
  final String cardButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: KdefaultPadding,
        vertical: KdefaultPadding / 2,
      ),
      width: size.width * 0.9,
      height: size.height * 0.26,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: 136,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: KPColor1,
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 15),
                  blurRadius: 27,
                  color: Colors.black12,
                ),
              ],
            ),
            child: Container(
              margin: const EdgeInsets.only(right: KdefaultPadding / 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 0,
            child: Hero(
              tag: cardID,
              child: Container(
                padding: const EdgeInsets.only(
                  left: KdefaultPadding,
                  top: KdefaultPadding,
                  right: KdefaultPadding / 2,
                ),
                height: 100,
                width: 170,
                child: Image.network(
                  cardImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              height: 136,
              width: size.width - 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: KdefaultPadding / 2,
                      right: KdefaultPadding,
                    ),
                    child: Text(
                      cardTitle,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: KtextPrimary,
                      ),
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Get.toNamed(cardButton, arguments: arguments);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: KdefaultPadding * 1.5,
                        vertical: KdefaultPadding / 4,
                      ),
                      decoration: const BoxDecoration(
                        color: KPColor1,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(22),
                          topRight: Radius.circular(22),
                        ),
                      ),
                      child: Text(
                        "Detail",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
