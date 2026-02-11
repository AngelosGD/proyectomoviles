import 'package:flutter/material.dart';
import 'package:proyectomoviles/screens/a%C3%B1adir_gasto_screen.dart';

class ResumenGastosScreen extends StatelessWidget {
  const ResumenGastosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Control Gastos Flutter'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AgregarGastoScreen()),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'pantalla 1 (gastos resumen)',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
