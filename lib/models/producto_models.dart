import 'dart:convert';

class ProductoModel {
  String nombre;
  int valor;
  String imgproducto;
  String? id;

  ProductoModel({
    required this.nombre,
    required this.valor,
    required this.imgproducto,
  });

  factory ProductoModel.fromRawJson(String str) =>
      ProductoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
        nombre: json["Nombre"],
        valor: json["Valor"],
        imgproducto: json["imgproducto"],
      );

  Map<String, dynamic> toJson() => {
        "Nombre": nombre,
        "Valor": valor,
        "imgproducto": imgproducto,
      };
}
