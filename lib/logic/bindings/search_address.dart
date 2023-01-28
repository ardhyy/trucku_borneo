import 'package:get/get.dart';

import '../controller/search_address.dart';

class SearchAddresBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchAddressController());
  }
}
