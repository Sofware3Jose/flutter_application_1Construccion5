import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farmacia App'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'CerrarSesion') {
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'CerrarSesion',
                  child: Text('Cerrar Sesión'),
                ),
              ];
            },
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2, 
        mainAxisSpacing: 8.0, 
        crossAxisSpacing: 8.0, 
        padding: EdgeInsets.all(8.0), 
        children: [
          _buildProductItem('Producto 1',
              'https://th.bing.com/th/id/OIP.7RcfpOAsWvAMZPVImi8X4AHaE9?w=210&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7', context),
          _buildProductItem('Producto 2',
              'https://www.hola.com/imagenes/belleza/caraycuerpo/20190618144091/cosmeticos-farmacia-mas-vendidos-verano/0-692-35/shopping-farmacia-z.jpg', context),
          _buildProductItem('Producto 3',
              'https://th.bing.com/th/id/R.2a1c400fb4a3fd3abe9904ac301c9aed?rik=nRF5MxIWZtv7gQ&pid=ImgRaw&r=0', context),
          _buildProductItem('Producto 4',
              'https://th.bing.com/th/id/OIP.hVAa7JMi67aaHmb5Zssj8QHaE8?w=237&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7', context),
        ],
      ),
    );
  }

  void _showPurchaseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String nombre = '';
        String cedula = '';
        String telefono = '';
        String direccion = '';

        return AlertDialog(
          title: const Text('Realizar Compra'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Nombre'),
                onChanged: (value) {
                  nombre = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Cédula'),
                onChanged: (value) {
                  cedula = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Teléfono'),
                onChanged: (value) {
                  telefono = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Dirección'),
                onChanged: (value) {
                  direccion = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showPurchaseSuccess(context);
              },
              child: const Text(
                'Comprar',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showPurchaseSuccess(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(
          Duration(seconds: 2),
          () {
            Navigator.of(context).pop();
          },
        );

        return const AlertDialog(
          title: Text('Compra Exitosa!!!'),
        );
      },
    );
  }

  Widget _buildProductItem(String productName, String imageUrl, BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                _showPurchaseDialog(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              child: const Text('Comprar'),
            ),
          ),
          Text(productName),
        ],
      ),
    );
  }
}
