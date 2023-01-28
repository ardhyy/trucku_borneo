import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trucku_borneo/logic/controller/dashboard.dart';

import '../../../util/const.dart';

class MyNavbar extends StatelessWidget {
  MyNavbar(
      {super.key,
      required this.currentIndex,
      required this.onTap,
      required this.controller});

  var bottomTextStyle = GoogleFonts.poppins(
    fontSize: 10,
    color: Colors.black,
  );

  final int currentIndex;
  final Null Function(dynamic index) onTap;
  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: KdefaultPadding * 1,
        right: KdefaultPadding * 1,
      ),
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: KPrimary.withOpacity(0.38),
            spreadRadius: 2,
            blurRadius: 35,
            offset: const Offset(0, 5),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: BottomNavigationBar(
        selectedLabelStyle: bottomTextStyle,
        unselectedLabelStyle: bottomTextStyle,
        selectedItemColor: KPrimary,
        unselectedItemColor: Colors.black,
        onTap: controller.changeTabIndex,
        currentIndex: currentIndex,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 0,
        items: [
          _bottomNavigationBarItem(
            icon: currentIndex == 0
                ? SvgPicture.asset(
                    'assets/icon/home-color.svg',
                    height: 20,
                  )
                : SvgPicture.asset(
                    'assets/icon/icon-home.svg',
                    height: 20,
                  ),
            label: 'Home',
          ),
          _bottomNavigationBarItem(
            icon: currentIndex == 1
                ? SvgPicture.asset(
                    'assets/icon/list-color.svg',
                    height: 20,
                  )
                : SvgPicture.asset(
                    'assets/icon/list.svg',
                    height: 20,
                  ),
            label: 'Riwayat',
          ),
          _bottomNavigationBarItem(
            icon: currentIndex == 2
                ? SvgPicture.asset(
                    'assets/icon/user-color.svg',
                    height: 20,
                  )
                : SvgPicture.asset(
                    'assets/icon/user.svg',
                    height: 20,
                  ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  _bottomNavigationBarItem({required String label, required SvgPicture icon}) {
    return BottomNavigationBarItem(
      icon: icon,
      label: label,
    );
  }
}
