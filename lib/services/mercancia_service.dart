import 'package:flutter/material.dart';
import '../models/mercancia_model.dart'; 
import 'package:flutter_farmacia/services/sqlite_service.dart';


class MercanciaService extends ChangeNotifier { // Cambia el nombre de la clase a "MercanciaService"
  List<MercanciaModel> mercancias = []; // Cambia el nombre de la lista a "mercancias"

  getAllMercancias() async { // Cambia el nombre de la función a "getAllMercancias"
    final mercancias = await SQLiteService.db.getAllMercancias(); // Cambia el nombre de la función a "getAllMercancias"
    this.mercancias = [...mercancias];
    notifyListeners();
  }

  delete(int id) async {
    final int res = await SQLiteService.db.deleteMercancia(id); // Cambia el nombre de la función a "deleteMercancia"
    if (res > 0) {
      getAllMercancias();
    }
  }

  create(MercanciaModel mercancia) async { // Cambia el nombre de la función a "create"
    final int res = await SQLiteService.db.insertMercancia(mercancia); // Cambia el nombre de la función a "insertMercancia"
    mercancia.id = res;
    return mercancia;
  }

  update(MercanciaModel mercancia) async { // Cambia el nombre de la función a "update"
    await SQLiteService.db.updateMercancia(mercancia); // Cambia el nombre de la función a "updateMercancia"
    return mercancia;
  }
}
