import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_farmacia/services/uiChange_service.dart'; // Importa el servicio adecuado

class BottomNavigationBarCustom extends StatelessWidget {
  const BottomNavigationBarCustom({Key? key}) : super(key: key); // Corrige la declaración del constructor

  @override
  Widget build(BuildContext context) {
    final uiService = Provider.of<UIMercanciaService>(context); // Utiliza el servicio adecuado

    final currentIndex = uiService.selectedMercanciaOpt; // Utiliza la variable adecuada

    return BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (int index) => uiService.selectedMercanciaOpt = index, // Utiliza la variable adecuada
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.filter_drama), label: 'home Crud'),
          BottomNavigationBarItem(icon: Icon(Icons.save), label: 'Local Crud'),
        ]);
  }
}
