import 'package:get/get.dart';
import 'package:trucku_borneo/logic/controller/dashboard.dart';
import 'package:trucku_borneo/logic/controller/home.dart';
import 'package:trucku_borneo/logic/controller/history_order.dart';
import 'package:trucku_borneo/logic/controller/profile.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<HistoryOrderController>(() => HistoryOrderController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
