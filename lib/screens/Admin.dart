import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Farmacia App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildProductItem('Producto 1',
                  'https://th.bing.com/th/id/OIP.7RcfpOAsWvAMZPVImi8X4AHaE9?w=210&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7'),
              _buildProductItem('Producto 2',
                  'https://www.hola.com/imagenes/belleza/caraycuerpo/20190618144091/cosmeticos-farmacia-mas-vendidos-verano/0-692-35/shopping-farmacia-z.jpg'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildProductItem('Producto 3',
                  'https://th.bing.com/th/id/R.2a1c400fb4a3fd3abe9904ac301c9aed?rik=nRF5MxIWZtv7gQ&pid=ImgRaw&r=0'),
              _buildProductItem('Producto 4',
                  'https://th.bing.com/th/id/OIP.hVAa7JMi67aaHmb5Zssj8QHaE8?w=237&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7'),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
               
              },
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                
              },
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductItem(String productName, String imageUrl) {
    return Column(
      children: [
        Image.network(
          imageUrl,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        ElevatedButton(
          onPressed: () {
           
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
          ),
          child: const Text('Comprar'),
        ),
        Text(productName),
      ],
    );
  }
}
