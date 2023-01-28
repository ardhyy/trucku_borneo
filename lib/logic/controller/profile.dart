import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../database/services/network_handle.dart';
import '../../routes/routes.dart';
import '../../util/const.dart';
import '../../util/api_endpoint.dart';
import '../../util/widget/custom_snackbar.dart';
import '../../util/widget/loader.dart';

class ProfileController extends GetxController {
  var linkImage = '${ApiEndPoint.apiUrl}${ApiEndPoint.imgUrlApi}';

  var isLoading = false.obs;

  //User Data
  var nama = "".obs;
  var email = "".obs;
  var noHp = "".obs;
  var alamat = "".obs;
  var perusahaan = "".obs;

  var isEdit = false.obs;
  var isEditPassword = false.obs;
  var selectedImagePath = "".obs;
  var selectedImageSize = "".obs;

  //Crop Image
  var cropImagePath = "".obs;
  var cropImageSize = "".obs;

  //Comporess Image
  var compressImagePath = "".obs;
  var compressImageSize = "".obs;

  late TextEditingController pwOldController,
      pwNewController,
      pwConfirmController;

  @override
  void onInit() {
    super.onInit();
    isLoading(true);
    getProfile();
    pwOldController = TextEditingController();
    pwNewController = TextEditingController();
    pwConfirmController = TextEditingController();
    isLoading(false);
  }

  @override
  void onClose() {
    pwOldController.dispose();
    pwNewController.dispose();
    pwConfirmController.dispose();
    super.onClose();
  }

  Future<void> getProfile() async {
    try {
      final response =
          await NetworkHandle.getRequest(ApiEndPoint.userProfileApi);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var result = jsonDecode(response.body);
        nama.value = result['nama'].toString();
        email.value = result['email'].toString();
        noHp.value = result['no_telpon'].toString();
        alamat.value = result['alamat_perusahaan'].toString();
        perusahaan.value = result['nama_perusahaan'].toString();
        if (perusahaan.value == 'null') {
          perusahaan.value = 'Update Profile Anda';
        } else {
          perusahaan.value = result['nama_perusahaan'];
        }
      } else {
        customSnackBar('Error', 'Gagal Mendapatkan Data', 'error');
      }
    } catch (e) {
      customSnackBar('Error', '$e', 'error');
    }
  }

  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().getImage(source: imageSource);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      selectedImageSize.value =
          ((File(selectedImagePath.value)).lengthSync() / 1024 / 1024)
              .toStringAsFixed(2);

      final cropImageFile = await ImageCropper().cropImage(
        sourcePath: selectedImagePath.value,
        maxWidth: 512,
        maxHeight: 512,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              toolbarColor: KPrimary,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
        ],
      );

      cropImagePath.value = cropImageFile!.path;
      cropImageSize.value =
          ((File(cropImagePath.value)).lengthSync() / 1024 / 1024)
              .toStringAsFixed(2);

      //compress image
      final dir = await Directory.systemTemp.createTemp();
      final targetPath =
          "${dir.absolute.path}/profile_${DateTime.now().millisecondsSinceEpoch}.JPG";
      final result = await FlutterImageCompress.compressAndGetFile(
        cropImagePath.value,
        targetPath,
        quality: 100,
      );
      compressImagePath.value = result!.path;
      compressImageSize.value =
          ((File(compressImagePath.value)).lengthSync() / 1024 / 1024)
              .toStringAsFixed(2);
      Get.showOverlay(
        asyncFunction: () => uploadImage(result) as Future<void>,
        loadingWidget: const Loader(),
      );
    } else {
      customSnackBar('Error', 'Tidak ada gambar', 'error');
    }
  }

  void uploadImage(File file) async {
    // Get the file name and extension
    final fileName = file.path.split('/').last;
    final fileExtension = fileName.split('.').last;
    final formData =
        // Attach the image file to the request
        MultipartFile(
      file.openRead(),
      // Set the filename and content type of the image
      filename: fileName,
    );

    // Create a POST request
    final response = await NetworkHandle.postRequestWithToken(
      ApiEndPoint.editPhotoApi,
      formData,
    );
    print(response.body.toString());
    // Check the status code of the response
    if (response.statusCode != 200) {
      throw Exception('Failed to upload image');
    }
  }

  // void UploadImage(File file) async {
  //   try {
  //     final fileName = file.path.split('/').last;
  //     final formData =
  //         MultipartFile(File(file.path), filename: file.path.split('/').last);
  //     print(jsonEncode(formData.toString()));
  //     // FormData formData = new FormData.fromMap({
  //     //   'avatar': MultipartFile(fileName, filename: fileName)
  //     // });
  //     final response = await NetworkHandle.postRequestWithToken(
  //         ApiEndPoint.editPhotoApi, jsonEncode({'avatar': formData}));
  //     print(response.body.toString());
  //     // final response = await NetworkHandle.postRequestWithToken(
  //     //     ApiEndPoint.editPhotoApi,
  //     //     // jsonEncode({
  //     //     //   // 'avatar': fileName,
  //     //     //   formData
  //     //     //   // 'avatar': base64Encode(file.readAsBytesSync()),
  //     //     // }),
  //     //     // jsonEncode({
  //     //     //   'avatar': MultipartFile(file.path,
  //     //     //       filename: fileName, contentType: "image/JPG")
  //     //     // }),
  //     //     jsonEncode(formData));
  //     // print(response.body.toString());
  //     // if (response.statusCode == 200) {
  //     //   var data = response.body;
  //     //   var user = customerfromJson(data);
  //     //   // customSnackBar('Success', 'Upload Image Success', 'success');
  //     //   // GetStorage().remove('avatar');
  //     //   // GetStorage().write('avatar', user.data.avatar);
  //     //   // Get.back();
  //     // } else {
  //     //   customSnackBar('Error', 'Upload Image Failed', 'error');
  //     // }
  //   } catch (e) {
  //     customSnackBar('Error', '$e', 'error');
  //     print(e);
  //   }
  // }

  // void getImage(ImageSource source) async {
  //   await imagePicker.pickImage(source: source, imageQuality: 100).then(
  //     (value) {
  //       pickedFile = File(value!.path);
  //       setProfilePath(pickedFile!.path);
  //       Get.showOverlay(
  //         asyncFunction: () => UploadImage(),
  //         loadingWidget: const Loader(),
  //       );
  //     },
  //   );
  // }

  void checkEditPassword() {
    if (isEditPassword.value == false) {
      isEditPassword.value = true;
      if (pwOldController.text.isEmpty) {
        customSnackBar('Error', 'Masukkan Password Lama Anda', 'error');
      } else if (pwNewController.text.isEmpty) {
        customSnackBar('Error', 'Masukkan Password Baru Anda', 'error');
      } else if (pwConfirmController.text.isEmpty) {
        customSnackBar(
            'Error', 'Masukkan Konfirmasi Password Baru Anda', 'error');
      } else if (pwNewController.text != pwConfirmController.text) {
        customSnackBar('Error', 'Password Baru Tidak Sama', 'error');
      } else if (pwOldController.text.length < 8) {
        customSnackBar('Error', 'Password Lama Minimal 8 Karakter', 'error');
      } else if (pwNewController.text.length < 8) {
        customSnackBar('Error', 'Password Baru Minimal 8 Karakter', 'error');
      } else if (pwConfirmController.text.length < 8) {
        customSnackBar(
            'Error', 'Konfirmasi Password Baru Minimal 8 Karakter', 'error');
      } else {
        Get.showOverlay(
          asyncFunction: () => editPassword() as Future<void>,
          loadingWidget: const Loader(),
        );
      }
    }
  }

  // Future<void> UploadImage() async {
  //   try {
  //     final response = await AuthService.uploadImage(pickedFile!);
  //   } catch (e) {
  //     customSnackBar('Error', '$e', 'error');
  //   }
  // }

  void editPassword() async {
    try {
      final response = await NetworkHandle.postRequestWithToken(
        ApiEndPoint.editPasswordApi,
        jsonEncode({
          'old_password': pwOldController.text,
          'new_password': pwNewController.text,
        }),
      );
      if (response.statusCode == 200) {
        customSnackBar('Success', 'Edit Password Success', 'success');
        GetStorage().remove('token');
        GetStorage().remove('avatar');
        GetStorage().remove('nama_perusahaan');
        Get.offAllNamed(Routes.login);
      } else {
        customSnackBar('Error', 'Edit Password Failed', 'error');
      }
    } catch (e) {
      customSnackBar('Error', '$e', 'error');
    }
  }
}
