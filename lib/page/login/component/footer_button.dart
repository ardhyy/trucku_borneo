import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FooterButton extends StatelessWidget {
  const FooterButton({
    Key? key,
    required this.defaultPadding,
    required this.press,
  }) : super(key: key);

  final double defaultPadding;
  final Function press;

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
          Text(
            'Belum punya akun?',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          TextButton(
            onPressed: () {
              press();
            },
            child: Text(
              'Register',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
