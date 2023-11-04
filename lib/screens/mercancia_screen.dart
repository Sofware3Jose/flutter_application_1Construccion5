import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/mercancia_model.dart';
import '../services/mercancia_service.dart';

class MercanciaScreen extends StatefulWidget {
  // Cambia el nombre de la clase a "MercanciaScreen"
  MercanciaScreen({Key? key, MercanciaModel? dataReceived}) {
    // Corrige la declaración del constructor
    reg = dataReceived;
  }

  MercanciaModel? reg;

  @override
  State<MercanciaScreen> createState() =>
      _MercanciaScreenState(); // Cambia el nombre de la clase a "_MercanciaScreenState"
}

class _MercanciaScreenState extends State<MercanciaScreen> {
  // Cambia el nombre de la clase a "_MercanciaScreenState"
  TextEditingController _name = TextEditingController();
  TextEditingController _precio = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mercanciaService =
        Provider.of<MercanciaService>(context); // Utiliza el servicio adecuado
    bool isNew = true;
    if (widget.reg != null) {
      isNew = false;
      _name.text = widget.reg!.name;
      _precio.text = widget.reg!.precio.toString();
    }
    return Scaffold(
      appBar: AppBar(
        title: isNew
            ? const Text(
                'Crear Mercancía') // Cambia el texto para crear Mercancía
            : Text(
                'Editar Mercancía ${widget.reg!.id}'), // Cambia el texto para editar Mercancía
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: _name,
              decoration: const InputDecoration(labelText: 'Nombre:'),
            ),
            TextField(
                controller: _precio,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Precio:')),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    asignarMercancia(); // Cambia el nombre de la función
                    if (isNew) {
                      await mercanciaService
                          .create(widget.reg!); // Utiliza el servicio adecuado
                    } else {
                      await mercanciaService
                          .update(widget.reg!); // Utiliza el servicio adecuado
                    }
                    Navigator.pop(context);
                  },
                  child: const Text('Guardar'),
                ),
                const SizedBox(
                  width: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cerrar'),
                )
              ],
            )
          ],
        ),
      )),
    );
  }

  asignarMercancia() {
    // Cambia el nombre de la función
    MercanciaModel mercancia = MercanciaModel(
        name: _name.text,
        precio: double.parse(_precio.text)); // Utiliza el modelo adecuado

    widget.reg ??= mercancia; // Utiliza el modelo adecuado
    widget.reg!.name = _name.text;
    widget.reg!.precio = double.parse(_precio.text);
  }
}
