import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
   
    String username = '';
    String password = '';

    return Scaffold(
      appBar: AppBar(title: const Text('Inicio de Sesión')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Usuario'),
                onChanged: (value) {
                  
                  username = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                onChanged: (value) {
                  
                  password = value;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  
                  if (username == 'admin' && password == 'admin') {
                    
                    Navigator.pushReplacementNamed(context, '/admin');
                  } else {
                    
                    Navigator.pushNamed(context, '/home');
                  }
                },
                child: const Text('Iniciar Sesión'),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text('¿No tienes una cuenta? Regístrate aquí'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
