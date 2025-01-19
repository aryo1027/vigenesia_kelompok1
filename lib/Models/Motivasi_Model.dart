import 'dart:convert';

List<MotivasiModel> motivasiModelFromJson(String str) =>
    List<MotivasiModel>.from(
        json.decode(str).map((x) => MotivasiModel.fromJson(x)));

String motivasiModelToJson(List<MotivasiModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MotivasiModel {
  MotivasiModel({
    this.id = '',
    this.isiMotivasi = '',
    this.idKategori = '',
    this.tanggalInput,
    this.tanggalUpdate = '',
  });

  String id;
  String isiMotivasi;
  String idKategori;
  DateTime tanggalInput;
  String tanggalUpdate;

  // Factory constructor to create an instance from JSON
  factory MotivasiModel.fromJson(Map<String, dynamic> json) => MotivasiModel(
        id: json["id"] ?? '',
        isiMotivasi: json["isi_motivasi"] ?? '',
        idKategori: json["id_kategori"] ?? '',
        tanggalInput: json["tanggal_input"] != null
            ? DateTime.parse(json["tanggal_input"])
            : DateTime.now(), // Default to current date if missing
        tanggalUpdate: json["tanggal_update"] ?? '',
      );

  // Convert the instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "isi_motivasi": isiMotivasi,
      "id_kategori": idKategori,
      "tanggal_input":
          "${tanggalInput.year.toString().padLeft(4, '0')}-${tanggalInput.month.toString().padLeft(2, '0')}-${tanggalInput.day.toString().padLeft(2, '0')}",
      "tanggal_update": tanggalUpdate, // Allow empty string for tanggalUpdate
    };
  }
}
