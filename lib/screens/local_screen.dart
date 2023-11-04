import 'package:flutter/material.dart';
import 'package:flutter_farmacia/screens/mercancia_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_farmacia/models/mercancia_model.dart';
import 'package:flutter_farmacia/services/mercancia_service.dart';

class LocalScreen extends StatelessWidget {
  const LocalScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final mercanciaService = Provider.of<MercanciaService>(context);
    mercanciaService.getAllMercancias();
    List<MercanciaModel> mercancias = mercanciaService.mercancias;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Mercancias Locales'),
      ),
      body: ListView.builder(
        itemCount: mercancias.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(mercancias[index].name),
            subtitle:
                Text('Precio: ${mercancias[index].precio.toStringAsFixed(2)}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            MercanciaScreen(dataReceived: mercancias[index]),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    mercanciaService.delete(mercancias[index].id!);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MercanciaScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
