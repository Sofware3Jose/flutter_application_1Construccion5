import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List<Product> productList = [
    Product('Producto 1', 'https://th.bing.com/th/id/OIP.7RcfpOAsWvAMZPVImi8X4AHaE9?w=210&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7', 10.0),
    Product('Producto 2', 'https://www.hola.com/imagenes/belleza/caraycuerpo/20190618144091/cosmeticos-farmacia-mas-vendidos-verano/0-692-35/shopping-farmacia-z.jpg', 20.0),
    Product('Producto 3', 'https://th.bing.com/th/id/R.2a1c400fb4a3fd3abe9904ac301c9aed?rik=nRF5MxIWZtv7gQ&pid=ImgRaw&r=0', 30.0),
    Product('Producto 4', 'https://th.bing.com/th/id/OIP.hVAa7JMi67aaHmb5Zssj8QHaE8?w=237&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7', 40.0),
  ];

  Product? selectedProduct;

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
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        ),
        padding: const EdgeInsets.all(8.0),
        itemCount: productList.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildProductItem(productList[index]);
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _showSelectProductForDeleteDialog(context);
              },
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                _showCreateProductDialog(context);
              },
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                _showSelectProductForEditDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductItem(Product product) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: Image.network(
              product.imageUrl, 
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
void _showCreateProductDialog(BuildContext context) {
  String productName = '';
  String imageUrl = '';
  double price = 0.0;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Crear Producto'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Nombre del Producto'),
                  onChanged: (value) {
                    setState(() {
                      productName = value;
                    });
                  },
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'URL de la Imagen'),
                  onChanged: (value) {
                    setState(() {
                      imageUrl = value;
                    });
                  },
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Precio del Producto'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      price = double.tryParse(value) ?? 0.0;
                    });
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
                  setState(() {
                    productList.add(Product(productName, imageUrl, price));
                  });

                  Navigator.of(context).pop();

                  _showProductCreatedSuccess(context);
                },
                child: const Text(
                  'Crear',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}

void _showProductCreatedSuccess(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Producto Creado Exitosamente!!!'),
      duration: Duration(seconds: 2),
    ),
  );
}


  void _showSelectProductForEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Seleccionar Producto para Editar'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<Product>(
                hint: const Text('Seleccionar Producto'),
                value: selectedProduct,
                onChanged: (Product? newValue) {
                  setState(() {
                    selectedProduct = newValue;
                  });
                },
                items: productList.map((Product product) {
                  return DropdownMenuItem<Product>(
                    value: product,
                    child: Text(product.name),
                  );
                }).toList(),
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
                if (selectedProduct != null) {
                  Navigator.of(context).pop(); 
                  _showEditProductDialog(context);
                }
              },
              child: const Text(
                'Editar',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showEditProductDialog(BuildContext context) {
    String productName = selectedProduct!.name;
    String imageUrl = selectedProduct!.imageUrl;
    double price = selectedProduct!.price;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Producto'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Nombre del Producto'),
                onChanged: (value) {
                  productName = value;
                },
                controller: TextEditingController(text: productName),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'URL de la Imagen'),
                onChanged: (value) {
                  imageUrl = value;
                },
                controller: TextEditingController(text: imageUrl),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Precio del Producto'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  price = double.tryParse(value) ?? 0.0;
                },
                controller: TextEditingController(text: price.toStringAsFixed(2)),
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
                setState(() {
                  selectedProduct!.name = productName;
                  selectedProduct!.imageUrl = imageUrl;
                  selectedProduct!.price = price;
                });

                Navigator.of(context).pop(); 

                _showProductEditedSuccess(context);
              },
              child: const Text(
                'Modificar',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showSelectProductForDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Seleccionar Producto para Eliminar'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<Product>(
                hint: const Text('Seleccionar Producto'),
                value: selectedProduct,
                onChanged: (Product? newValue) {
                  setState(() {
                    selectedProduct = newValue;
                  });
                },
                items: productList.map((Product product) {
                  return DropdownMenuItem<Product>(
                    value: product,
                    child: Text(product.name),
                  );
                }).toList(),
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
                if (selectedProduct != null) {
                  Navigator.of(context).pop(); 
                  _showDeleteProductConfirmation(context);
                }
              },
              child: const Text(
                'Eliminar',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteProductConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eliminar Producto'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                selectedProduct!.imageUrl, 
                fit: BoxFit.cover,
              ),
              Text(selectedProduct!.name),
              Text('\$${selectedProduct!.price.toStringAsFixed(2)}'),
              const Text('¿Estás seguro de eliminar el producto?'),
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
                setState(() {
                  productList.remove(selectedProduct);
                  selectedProduct = null; 
                });

                Navigator.of(context).pop(); 

                _showProductDeletedSuccess(context);
              },
              child: const Text(
                'Eliminar',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }




  void _showProductEditedSuccess(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(
          const Duration(seconds: 2),
          () {
            Navigator.of(context).pop();
          },
        );

        return const AlertDialog(
          title: Text('Producto Editado Exitosamente!!!'),
        );
      },
    );
  }

  void _showProductDeletedSuccess(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(
          const Duration(seconds: 2),
          () {
            Navigator.of(context).pop();
          },
        );

        return const AlertDialog(
          title: Text('Producto Eliminado Exitosamente!!!'),
        );
      },
    );
  }
}

class Product {
  String name;
  String imageUrl;
  double price;

  Product(this.name, this.imageUrl, this.price);
}

