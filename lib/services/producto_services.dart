import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_farmacia/models/models.dart';
import 'package:http/http.dart' as http;

class ProductoService extends ChangeNotifier {
  List<ProductoModel> productos = [];
  bool isLoading = true;

  ProductoService() {
    load();
  }

  Future<List<ProductoModel>> load({bool isUsedLoading = true}) async {
    if (isUsedLoading) {
      isLoading = true;
      notifyListeners();
    }

    final url = Uri.parse('https://farmacia-cace5-default-rtdb.firebaseio.com/Productos.json');

    final response = await http.get(url);
    productos.clear();

    if (response.body != "null") {
      final Map<String, dynamic> productoMap = json.decode(response.body);
      productoMap.forEach((key, value) {
        final productoTemp = ProductoModel.fromJson(value);
        productoTemp.id = key;
        productos.add(productoTemp);
      });
    }

    if (isUsedLoading) isLoading = false;
    notifyListeners();

    return productos;
  }

  Future<void> post(ProductoModel producto) async {
    final url = Uri.parse('https://farmacia-cace5-default-rtdb.firebaseio.com/Productos.json');

    String data = jsonEncode(producto);
    final response = await http.post(url, body: data);
    load();
  }

  Future<void> put(ProductoModel producto) async {
    final url = Uri.parse('https://farmacia-cace5-default-rtdb.firebaseio.com/Productos/${producto.id}.json');

    String data = jsonEncode(producto);
    final response = await http.put(url, body: data);
    load();
  }

  Future<void> delete(ProductoModel producto) async {
    final url = Uri.parse('https://farmacia-cace5-default-rtdb.firebaseio.com/Productos/${producto.id}.json');
    
    final response = await http.delete(url);
    load();
  }
}
