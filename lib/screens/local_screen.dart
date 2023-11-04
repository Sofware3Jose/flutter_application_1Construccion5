import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_farmacia/models/mercancia_model.dart';
import 'package:flutter_farmacia/services/mercancia_service.dart';
import 'package:flutter_farmacia/screens/mercancia_screen.dart';

class LocalScreen extends StatefulWidget {
  const LocalScreen({Key? key});

  @override
  _LocalScreenState createState() => _LocalScreenState();
}

class _LocalScreenState extends State<LocalScreen> {
  @override
  void initState() {
    super.initState();
    final mercanciaService = Provider.of<MercanciaService>(context, listen: false);
    mercanciaService.getAllMercancias();
  }

  @override
  Widget build(BuildContext context) {
    final mercanciaService = Provider.of<MercanciaService>(context);
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
            subtitle: Text('Precio: ${mercancias[index].precio.toStringAsFixed(2)}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MercanciaScreen(dataReceived: mercancias[index]),
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
