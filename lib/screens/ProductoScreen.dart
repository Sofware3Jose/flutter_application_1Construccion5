import 'package:flutter/material.dart';
import 'package:flutter_farmacia/models/models.dart';
import 'package:provider/provider.dart';
import 'package:flutter_farmacia/services/producto_services.dart';

class ProductoScreen extends StatefulWidget {
  ProductoScreen({super.key, ProductoModel? dataReceived}) {
    reg = dataReceived;
  }

  ProductoModel? reg;

  @override
  State<ProductoScreen> createState() => _ProductoScreenState();
}

class _ProductoScreenState extends State<ProductoScreen> {
  TextEditingController _nombre = TextEditingController();
  TextEditingController _valor = TextEditingController();
  TextEditingController _imgproducto = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final productoService = Provider.of<ProductoService>(context);
    bool isNew = true;

    if (widget.reg != null) {
      isNew = false;
      _nombre.text = widget.reg!.nombre;
      _valor.text = widget.reg!.valor.toString();
      _imgproducto.text = widget.reg!.imgproducto;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Producto'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              TextField(
                controller: _nombre,
                decoration: const InputDecoration(labelText: 'Nombre:'),
              ),
              TextField(
                controller: _valor,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Valor:'),
              ),
              TextField(
                controller: _imgproducto,
                decoration: const InputDecoration(labelText: 'Imagen del Producto:'),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      asignarProducto();
                      if (isNew) {
                        await productoService.post(widget.reg!);
                      } else {
                        await productoService.put(widget.reg!);
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
        ),
      ),
    );
  }

  asignarProducto() {
    ProductoModel producto = ProductoModel(
      nombre: _nombre.text,
      valor: int.parse(_valor.text),
      imgproducto: _imgproducto.text,
    );

    widget.reg ??= producto;
    widget.reg!.nombre = _nombre.text;
    widget.reg!.valor = int.parse(_valor.text);
    widget.reg!.imgproducto = _imgproducto.text;
  }
}
