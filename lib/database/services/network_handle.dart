import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:trucku_borneo/util/api_endpoint.dart';

import '../../routes/routes.dart';
import '../../util/widget/custom_snackbar.dart';

class NetworkHandle extends GetxService {
  static final client = http.Client();
  static final setHeader = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  static final storage = GetStorage();

  static Uri buildUri(String endPointPath) {
    final apiPath = ApiEndPoint.apiUrl + endPointPath;
    return Uri.parse(apiPath);
  }

  static Future<http.Response> postRequest(
      String endPointPath, var body) async {
    var response = await client.post(
      buildUri(endPointPath),
      body: body,
      headers: setHeader,
    );
    return response;
  }

  static Future<http.Response> postRequestWithToken(
      String endPointPath, var body) async {
    var response = await client.post(
      buildUri(endPointPath),
      body: body,
      headers: Map.from(setHeader)
        ..addAll(
            {'Authorization': 'Bearer ${await getToken(ApiEndPoint.token)}'}),
    );
    return response;
  }

  static Future<http.Response> getRequest(String endPointPath) async {
    var response = await client.get(
      buildUri(endPointPath),
      headers: Map.from(setHeader)
        ..addAll(
            {'Authorization': 'Bearer ${await getToken(ApiEndPoint.token)}'}),
    );
    return response;
  }

  static void storeToken(String token) async {
    await storage.write(ApiEndPoint.token, token);
  }

  static Future<String?> getToken(String token) async {
    return storage.read(ApiEndPoint.token);
  }

  static void removeToken() async {
    await storage.remove(ApiEndPoint.token);
  }

  static Future<void> logoutApi() async {
    var response = await client.post(
      Uri.parse(ApiEndPoint.apiUrl + ApiEndPoint.logoutApi),
      headers: Map.from(setHeader)
        ..addAll(
            {'Authorization': 'Bearer ${await getToken(ApiEndPoint.token)}'}),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      removeToken();
      storage.remove('avatar');
      storage.remove('perusahaan');
      Get.offAllNamed(Routes.login);
      customSnackBar('Sukses', 'Logout Sukses', 'success');
    } else {
      customSnackBar('Error', 'Gagal Logout', 'error');
    }
  }
}
