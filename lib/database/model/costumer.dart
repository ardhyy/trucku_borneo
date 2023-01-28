// To parse this JSON data, do
//
//     final costumerModel = costumerModelFromJson(jsonString);

import 'dart:convert';

CostumerModel costumerModelFromJson(String str) =>
    CostumerModel.fromJson(json.decode(str));

String costumerModelToJson(CostumerModel data) => json.encode(data.toJson());

class CostumerModel {
  CostumerModel({
    required this.success,
    required this.message,
    required this.data,
    required this.token,
  });

  bool success;
  String message;
  Data data;
  String token;

  factory CostumerModel.fromJson(Map<String, dynamic> json) => CostumerModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
        "token": token,
      };
}

class Data {
  Data({
    required this.id,
    required this.nama,
    required this.email,
    required this.avatar,
    this.noTelpon,
    required this.statusUser,
    this.perusahaan,
    this.idPerusahaan,
    this.namaPerusahaan,
    this.alamatPerusahaan,
  });

  int id;
  String nama;
  String email;
  String avatar;
  dynamic noTelpon;
  int statusUser;
  dynamic perusahaan;
  dynamic idPerusahaan;
  dynamic namaPerusahaan;
  dynamic alamatPerusahaan;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        nama: json["nama"],
        email: json["email"],
        avatar: json["avatar"],
        noTelpon: json["no_telpon"],
        statusUser: json["status_user"],
        perusahaan: json["perusahaan"],
        idPerusahaan: json["id_perusahaan"],
        namaPerusahaan: json["nama_perusahaan"],
        alamatPerusahaan: json["alamat_perusahaan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "email": email,
        "avatar": avatar,
        "no_telpon": noTelpon,
        "status_user": statusUser,
        "perusahaan": perusahaan,
        "id_perusahaan": idPerusahaan,
        "nama_perusahaan": namaPerusahaan,
        "alamat_perusahaan": alamatPerusahaan,
      };
}
