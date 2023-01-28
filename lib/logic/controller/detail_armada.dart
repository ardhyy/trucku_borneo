import 'package:get/get.dart';

class DetailArmadaController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    setDetailArmada();
  }

  Map<String, dynamic> setDetailArmada() {
    if (Get.arguments != null) {
      final data = Get.arguments as Map<String, dynamic>;
      return data;
    } else {
      return {};
    }
  }
}
