import 'dart:convert';

MercanciaModel mercanciaModelFromJson(String str) =>
    MercanciaModel.fromJson(json.decode(str));

String mercanciaModelToJson(MercanciaModel data) => json.encode(data.toJson());

class MercanciaModel {
  int? id;
  String name;
  double precio;

  MercanciaModel({
    this.id,
    required this.name,
    required this.precio,
  });

  factory MercanciaModel.fromJson(Map<String, dynamic> json) => MercanciaModel(
        id: json["id"],
        name: json["name"],
        precio: double.parse(json["precio"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "precio": precio,
      };
}
