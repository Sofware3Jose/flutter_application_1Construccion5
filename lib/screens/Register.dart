import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {

  const RegisterPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Completa el formulario de registro'),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Usuario',
                    ),
                  ),
                  SizedBox(height: 16.0), 
                  
                  TextField(
                    obscureText: true, 
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: const Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}
