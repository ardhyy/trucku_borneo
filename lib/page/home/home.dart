import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:trucku_borneo/logic/controller/home.dart';

import 'component/body.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final gambar = GetStorage().read('avatar');
    return Scaffold(
      body: BodyHome(size: size, controller: homeController, gambar: gambar),
    );
  }
}
