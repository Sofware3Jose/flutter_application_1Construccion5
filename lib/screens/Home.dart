import 'package:flutter/material.dart';
import 'package:flutter_farmacia/screens/loading_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_farmacia/models/models.dart';
import 'package:flutter_farmacia/screens/ProductoScreen.dart';
import 'package:flutter_farmacia/services/producto_services.dart';
import 'package:flutter_farmacia/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  Future<void> onRefresh(ProductoService service) async {
    await service.load(isUsedLoading: false);
  }

  @override
  Widget build(BuildContext context) {
    final productoService = Provider.of<ProductoService>(context);

    if (productoService.isLoading) return const LoadingScreen();

    List<ProductoModel> listProductos = productoService.productos;

    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Productos')),
      body: RefreshIndicator(
        onRefresh: () => onRefresh(productoService),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Dos columnas
          ),
          itemCount: listProductos.length,
          itemBuilder: (BuildContext context, int index) {
            return ProductCard(producto: listProductos[index], onEdit: () {  },);
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
          color: Colors.white,
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductoModel producto;
  final VoidCallback onEdit;

  ProductCard({required this.producto, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: ListView(
        shrinkWrap: true, 
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: producto.imgproducto,
            width: 150,  
            height: 150, 
            fit: BoxFit.cover, 
          ),
          SizedBox(height: 10),
          Text(
            producto.nombre,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            'Valor: \$${producto.valor.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  // Lógica para eliminar el producto
                  final productoService =
                      Provider.of<ProductoService>(context, listen: false);
                  productoService.delete(producto);
                },
              ),
              IconButton(
                icon: Icon(Icons.edit, color: Colors.blue),
                onPressed: () {
                  // Navegar a la pantalla de edición
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProductoScreen(dataReceived: producto),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
