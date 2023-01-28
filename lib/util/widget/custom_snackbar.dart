import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../const.dart';

customSnackBar(title, msg, type) {
  Get.snackbar(
    title,
    msg,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: type == 'success' ? KPrimary : KWarning,
    colorText: KBgColor,
    icon: Icon(
      type == 'success' ? Icons.check : Icons.error,
      color: Colors.white,
    ),
    duration: const Duration(seconds: 3),
  );
}
