import 'package:flutter/material.dart';

class BodyHeading extends StatelessWidget {
  const BodyHeading({
    Key? key,
    required this.size,
    required this.logoImage,
  }) : super(key: key);

  final Size size;
  final String logoImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height / 5,
      width: size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image(
              image: AssetImage(
                logoImage,
              ),
              width: 250,
              fit: BoxFit.contain,
            ),
          )
        ],
      ),
    );
  }
}
