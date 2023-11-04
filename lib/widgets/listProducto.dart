import 'package:flutter/material.dart';
import 'package:flutter_farmacia/models/models.dart';
import 'package:flutter_farmacia/screens/ProductoScreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_farmacia/services/producto_services.dart';

class ListTitleProducto extends StatelessWidget {
  const ListTitleProducto({super.key, required this.producto, required ProductoModel product});

  final ProductoModel producto;
  @override
  Widget build(BuildContext context) {
    final productoService = Provider.of<ProductoService>(context);

    return ListTile(
      leading: GestureDetector(
        onTap: () {
          productoService.delete(producto);
        },
        child: const Icon(Icons.delete, color: Colors.red),
      ),
      trailing: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProductoScreen(dataReceived: producto),
            ),
          );
        },
        child: const Icon(Icons.edit, color: Colors.blue), 
      ),
      title: Row(
        children: [
          const Text('Nombre: ', style: TextStyle(fontWeight: FontWeight.bold)),
          Text(producto.nombre),
        ],
      ),
      subtitle: Column(
        children: [
          Row(
            children: [
              const Text(
                'Valor: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(producto.valor.toString()),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Text(
                'Imagen del Producto: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(producto.imgproducto),
            ],
          ),
        ],
      ),
    );
  }
}
