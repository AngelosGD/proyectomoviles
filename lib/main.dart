import 'package:flutter/material.dart';
import 'screens/resumen_gastos_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Control Gastos Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 22, 2, 111),
        ),
        useMaterial3: true,
      ),
      home: const ResumenGastosScreen(),
    );
  }
}
