import 'package:flutter/material.dart';
import 'screens/home_screen.dart';  // Importamos la pantalla HomeScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Universidad',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),  // Referencia a la pantalla principal
    );
  }
}
