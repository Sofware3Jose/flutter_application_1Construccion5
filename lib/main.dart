import 'package:flutter/material.dart';
import 'package:flutter_farmacia/screens/local_screen.dart';
import 'package:flutter_farmacia/services/mercancia_service.dart';
import 'package:flutter_farmacia/services/uiChange_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_farmacia/services/producto_services.dart';
import 'package:flutter_farmacia/screens/screens.dart';

void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => MercanciaService()),
      ChangeNotifierProvider(create: (_) => UIMercanciaService()),
      ChangeNotifierProvider(create: (_) => ProductoService()),
    ], child: const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    final myColorScheme = ColorScheme.light(
      primary: Colors.blue,
      secondary: Colors.green,
      background: Colors.white,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mi App',
      initialRoute: 'home',
      routes: {
        'home': (context) => const HomeScreen(),
        'producto': (context) => ProductoScreen(),
        'local': (context) => const LocalScreen(), // Agrega la ruta "local"
      },
      theme: ThemeData(
        colorScheme: myColorScheme,
        useMaterial3: true,
      ),
    );
  }
}
