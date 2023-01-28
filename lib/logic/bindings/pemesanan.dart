import 'package:get/get.dart';

import '../controller/pemesanan.dart';
import '../controller/search_address.dart';

class PemesananBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchAddressController());
    Get.lazyPut(() => PemesananController());
  }
}
