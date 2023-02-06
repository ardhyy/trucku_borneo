import 'package:get/get.dart';
import 'package:trucku_borneo/logic/controller/pembayaran.dart';

class PembayaranBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PembayaranController());
  }
}
