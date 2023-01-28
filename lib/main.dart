import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:trucku_borneo/routes/routes.dart';

void main() async {
  await GetStorage.init();
  runApp(
    GetMaterialApp(
      title: 'TrucKu Borneo',
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
