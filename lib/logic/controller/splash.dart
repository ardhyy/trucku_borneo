import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:trucku_borneo/routes/routes.dart';
import 'package:trucku_borneo/util/api_endpoint.dart';

class SplashController extends GetxController {
  final getStorage = GetStorage();

  @override
  void onReady() {
    super.onReady();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (getStorage.read(ApiEndPoint.token) == null) {
          Get.offAllNamed(AppRoutes.login);
        } else {
          Get.offNamed(AppRoutes.dashboard);
        }
      },
    );
  }
}
