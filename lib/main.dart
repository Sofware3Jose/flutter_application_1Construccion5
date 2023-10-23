import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_farmacia/services/producto_services.dart';

import 'screens/screens.dart';

void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductoService()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    final myColorScheme = ColorScheme.light(
      primary: Colors.blue, // Color primario
      secondary: Colors.green, // Color secundario
      background: Colors.white, // Color de fondo
      // Personaliza otros colores según tus preferencias
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mi App',
      initialRoute: 'home',
      routes: {
        'home': (context) => const HomeScreen(),
        'producto': (context) => ProductoScreen(),
      },
      theme: ThemeData(
        // Asigna el esquema de colores personalizado
        colorScheme: myColorScheme,
        useMaterial3: true,
      ),
    );
  }
}
