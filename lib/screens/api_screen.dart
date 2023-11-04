import 'package:flutter/material.dart';
import 'package:flutter_farmacia/models/producto_models.dart';
import 'package:flutter_farmacia/screens/loading_screen.dart';
import 'package:flutter_farmacia/services/producto_services.dart';
import 'package:flutter_farmacia/widgets/listProducto.dart';
import 'package:provider/provider.dart';

class ApiScreen extends StatelessWidget {
  const ApiScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final productoService = Provider.of<ProductoService>(context);

    if (productoService.isLoading) return const LoadingScreen();

    List<ProductoModel> listProductos = productoService.productos;

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Productos'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Puedes agregar aquí la lógica de actualización si la necesitas
        },
        child: ListView.builder(
          itemCount: listProductos.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTitleProducto(producto: listProductos[index], product: listProductos[index]);


          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'producto');
        },
        child: const Icon(
          Icons.add,
          size: 40,
          color: Colors.red,
        ),
      ),
    );
  }
}
