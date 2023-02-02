import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:trucku_borneo/util/widget/custom_snackbar.dart';

import '../../page/search_address/search_address.dart';
import '../../util/const.dart';

class SearchAddressController extends GetxController {
  var isLoading = false.obs;
  late GoogleMapController mpController;
  late CameraPosition cameraPosition;
  RxDouble lat = 0.0.obs;
  RxDouble lng = 0.0.obs;
  String address = "".obs.toString();
  List<Marker> markersL = <Marker>[];
  Set<Marker> get markers => markersL.toSet();

  Marker initialMarker = Marker(
      markerId: MarkerId("1"),
      position: LatLng(0.0, 0.0),
      infoWindow: InfoWindow(title: "Lokasi Anda"));

  void onMapCreated(GoogleMapController controller) {
    mpController = controller;
  }

  @override
  void onReady() {
    isLoading(true);
    super.onReady();
    // getCurrentLocation();
    checkLocationPermission();
    // update();
    isLoading(false);
  }

  @override
  void dispose() {
    super.dispose();
    mpController.dispose();
    markersL.clear();
  }

  checkLocationPermission() async {
    if (await Permission.location.isGranted) {
      getCurrentLocation();
    } else {
      if (await Permission.location.isDenied) {
        await Permission.location.request();
        if (await Permission.location.isGranted) {
          getCurrentLocation();
        } else {
          customSnackBar("Error", "Permission denied", "error");
        }
      }
    }
  }

  void getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      lat.value = position.latitude;
      lng.value = position.longitude;

      mpController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(lat.value, lng.value), zoom: 17)));
      markersL.add(Marker(
          markerId: MarkerId("1"),
          position: LatLng(lat.value, lng.value),
          infoWindow: InfoWindow(title: "Posisi Anda")));
      update();
    } catch (e) {
      customSnackBar("Error", e.toString(), "error");
    }
  }

  Future<void> handleButtonSearch() async {
    Prediction? p = await PlacesAutocomplete.show(
      context: homeScaffoldKey.currentContext!,
      apiKey: googleApiKey,
      mode: Mode.overlay,
      language: "id",
      types: [""],
      strictbounds: false,
      decoration: InputDecoration(
          hoverColor: KPColor1,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(KdefaultPadding)),
          hintText: "Cari Alamat",
          hintStyle: GoogleFonts.poppins(color: KPColor1, fontSize: 14)),
      components: [Component(Component.country, "id")],
      onError: (res) {
        customSnackBar("Error", res.errorMessage!, "error");
      },
    );
    if (p != null) {
      displayPrediction(p, homeScaffoldKey.currentState);
    }
  }

  Future<void> displayPrediction(
      Prediction p, ScaffoldState? currentState) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
      apiKey: googleApiKey,
      apiHeaders: await GoogleApiHeaders().getHeaders(),
    );
    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);
    lat.value = detail.result.geometry!.location.lat;
    lng.value = detail.result.geometry!.location.lng;
    address = detail.result.formattedAddress!;
    mpController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(lat.value, lng.value),
        zoom: 17.0,
      ),
    ));

    markersL.clear();
    markersL.add(
      Marker(
        markerId: MarkerId(p.placeId!),
        position: LatLng(lat.value, lng.value),
        infoWindow: InfoWindow(
          title: detail.result.name,
          snippet: p.description,
        ),
      ),
    );
  }

  Future<void> handleButtonConfirm() async {
    if (lat.value == 0.0 && lng.value == 0.0) {
      customSnackBar("Error", "Lokasi tidak ditemukan", "error");
    } else {
      Get.back(result: [lat.value, lng.value, address]);
    }
  }
}
