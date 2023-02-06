import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trucku_borneo/logic/controller/search_address.dart';
import 'package:trucku_borneo/util/const.dart';
import 'package:trucku_borneo/util/widget/loader.dart';

class searchAddressPage extends StatefulWidget {
  const searchAddressPage({super.key});

  @override
  State<searchAddressPage> createState() => _searchAddress();
}

final homeScaffoldKey = GlobalKey<ScaffoldState>();
final loc_controller = Get.put(SearchAddressController());
// LatLng _initialcameraposition = LatLng(3.1390, 101.6869);

class _searchAddress extends State<searchAddressPage> {
  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    final sizeWidth = MediaQuery.of(context).size.width;
    return GetBuilder<SearchAddressController>(
      init: SearchAddressController(),
      builder: (controller) => Scaffold(
        key: homeScaffoldKey,
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(controller.lat.value, controller.lng.value),
                // target: _initialcameraposition,
                zoom: 15,
              ),
              markers: controller.markersL.toSet(),
              mapType: MapType.normal,
              onMapCreated: controller.onMapCreated,
            ),
            Positioned(
              top: KdefaultPadding * 2,
              left: KdefaultPadding,
              child: FloatingActionButton(
                onPressed: controller.handleButtonSearch,
                child: Icon(Icons.search),
                backgroundColor: KPColor1,
              ),
            ),
            Positioned(
              bottom: KdefaultPadding * 2,
              right: KdefaultPadding * 4,
              left: KdefaultPadding * 4,
              child: Container(
                height: sizeHeight * 0.1,
                width: sizeWidth * 0.05,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  border: Border.all(
                    color: KPColor1,
                    width: 2,
                  ),
                ),
                child: TextButton(
                  onPressed: controller.handleButtonConfirm,
                  child: Text(
                    'Pilih Lokasi',
                    style: GoogleFonts.poppins(
                      color: KPColor1,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
