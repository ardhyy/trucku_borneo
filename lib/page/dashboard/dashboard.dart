import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trucku_borneo/logic/controller/dashboard.dart';
import 'package:trucku_borneo/page/history_order/history_order.dart';
import 'package:trucku_borneo/page/home/home.dart';
import 'package:trucku_borneo/page/profile/profile.dart';

import 'component/bottom_navigation.dart';

class DashboardPage extends GetWidget<DashboardController> {
  final DashboardController dashboardController =
      Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        var currentIndex = controller.tabIndex;
        return Scaffold(
            body: SafeArea(
              child: IndexedStack(
                index: controller.tabIndex,
                children: [
                  HomeView(),
                  const HistoryOrderPage(),
                  ProfilePage(),
                ],
              ),
            ),
            bottomNavigationBar: MyNavbar(
              controller: controller,
              currentIndex: currentIndex,
              onTap: (index) {
                controller.tabIndex = index;
              },
            ));
      },
    );
  }
}
