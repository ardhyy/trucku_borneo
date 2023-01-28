import 'dart:convert';

JenisTruck jenistruckFromJson(String str) =>
    JenisTruck.fromJson(json.decode(str));

String jenisToJson(JenisTruck data) => json.encode(data.toJson());

class JenisTruck {
  JenisTruck({
    required this.message,
    required this.data,
  });

  String message;
  List<Datum> data;

  factory JenisTruck.fromJson(Map<String, dynamic> json) => JenisTruck(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())).toList(),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.jenisTruk,
    required this.dimensi,
    required this.volume,
    required this.bebanMaks,
    required this.biaya,
  });

  int id;
  String jenisTruk;
  String dimensi;
  String volume;
  String bebanMaks;
  int biaya;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        jenisTruk: json["jenis_truk"],
        dimensi: json["dimensi"],
        volume: json["volume"],
        bebanMaks: json["beban_maks"],
        biaya: json["biaya"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "jenis_truk": jenisTruk,
        "dimensi": dimensi,
        "volume": volume,
        "beban_maks": bebanMaks,
        "biaya": biaya,
      };
}
