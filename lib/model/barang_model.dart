import 'dart:convert';

class BarangModel {
  String? id;
  String? name;
  String? jumlah;
  String? detail;
  String? imageUrl;

  BarangModel({
    this.id,
    required this.name,
    required this.jumlah,
    required this.detail,
    this.imageUrl,
  });

  BarangModel copyWith({
    String? id,
    String? name,
    String? phone,
    String? email,
    String? address,
    String? imageUrl,
  }) {
    return BarangModel(
      id: id ?? this.id,
      name: name ?? this.name,
      jumlah: phone ?? this.jumlah,
      detail: email ?? this.detail,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'jumlah': jumlah,
      'detail': detail,
      'imageUrl': imageUrl,
    };
  }

  factory BarangModel.fromMap(Map<String, dynamic> map) {
    return BarangModel(
      id: map['id'],
      name: map['name'] ?? '',
      jumlah: map['jumlah'] ?? '',
      detail: map['detail'] ?? '',
      imageUrl: map['imageUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BarangModel.fromJson(String source) =>
      BarangModel.fromMap(json.decode(source));
}
