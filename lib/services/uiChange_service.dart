import 'package:flutter/material.dart';

class UIMercanciaService extends ChangeNotifier { // Cambia el nombre de la clase a "UIMercanciaService"
  int _selectedMercanciaOpt = 0; // Cambia el nombre de la variable a "_selectedMercanciaOpt"

  int get selectedMercanciaOpt {
    return _selectedMercanciaOpt;
  }

  set selectedMercanciaOpt(int value) {
    _selectedMercanciaOpt = value;
    notifyListeners();
  }
}
