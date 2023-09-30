import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/Admin.dart';
import 'package:flutter_application_1/screens/Home.dart';
import 'package:flutter_application_1/screens/Login.dart';
import 'package:flutter_application_1/screens/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Farmacia App',
      initialRoute: '/login', // Ruta inicial
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
        '/admin': (context) => const AdminPage(),
      },
    );
  }
}
