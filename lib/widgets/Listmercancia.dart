import 'package:flutter/material.dart';
import 'package:flutter_farmacia/screens/mercancia_screen.dart';
import 'package:provider/provider.dart';
import '../models/mercancia_model.dart'; // Importa el modelo adecuado
import '../screens/screens.dart';
import '../services/mercancia_service.dart'; // Importa el servicio adecuado

class ListTitleMercancias extends StatelessWidget {
  const ListTitleMercancias({Key? key, required this.mercancia}); // Corrige la declaración del constructor

  final MercanciaModel mercancia; // Utiliza el modelo adecuado
  @override
  Widget build(BuildContext context) {
    final mercanciaService = Provider.of<MercanciaService>(context); // Utiliza el servicio adecuado

    return ListTile(
      leading: GestureDetector(
          onTap: () {
            mercanciaService.delete(mercancia.id!); // Utiliza el servicio adecuado y la variable adecuada
          },
          child: const Icon(Icons.delete, color: Colors.red)),
      trailing: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MercanciaScreen(dataReceived: mercancia), // Utiliza el modelo adecuado
              ),
            );
          },
          child: const Icon(Icons.arrow_forward_ios)),
      title: Row(
        children: [
          const Text('Producto: ',
              style: TextStyle(fontWeight: FontWeight.bold)),
          Text(mercancia.name), // Utiliza la variable adecuada
        ],
      ),
      subtitle: Column(
        children: [
          Row(
            children: [
              const Text(
                'Precio: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(mercancia.precio.toString()), // Utiliza la variable adecuada
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Text(
                'Id: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(mercancia.id.toString()), // Utiliza la variable adecuada
            ],
          ),
        ],
      ),
    );
  }
}
