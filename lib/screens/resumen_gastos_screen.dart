import 'package:flutter/material.dart';
import 'package:proyectomoviles/screens/a%C3%B1adir_gasto_screen.dart';
import 'package:proyectomoviles/widgets/expense_grafica.dart';
import '../models/expense.dart';
import '../models/category.dart';

class ResumenGastosScreen extends StatelessWidget {
  const ResumenGastosScreen({super.key});

  // 🎯 DATOS DE PRUEBA - Estos son gastos falsos para probar la gráfica
  List<Expense> get _expensesPrueba {
    return [
      Expense(
        titulo: 'Curso Dart',
        monto: 10099.50,
        categoria: Category.trabajo,
        fecha: DateTime(2026, 2, 10),
      ),
      Expense(
        titulo: 'Cine',
        monto: 20200.00,
        categoria: Category.divis,
        fecha: DateTime(2026, 2, 10),
      ),
      Expense(
        titulo: 'Mi Viaje',
        monto: 234.00,
        categoria: Category.viaje,
        fecha: DateTime(2026, 2, 3),
      ),
      Expense(
        titulo: 'Buffet',
        monto: 758.00,
        categoria: Category.comida,
        fecha: DateTime(2026, 2, 5),
      ),
      Expense(
        titulo: 'Viaje Nuevo',
        monto: 15000.00,
        categoria: Category.viaje,
        fecha: DateTime(2026, 2, 2),
      ),
      Expense(
        titulo: 'Comida',
        monto: 7000.00,
        categoria: Category.comida,
        fecha: DateTime(2026, 2, 2),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Control Gastos Flutter'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AgregarGastoScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 📊 GRÁFICA
          ExpenseChart(expenses: _expensesPrueba),
          
          // 📝 Mensaje temporal (aquí irá la lista de tu compañero)
          const Expanded(
            child: Center(
              child: Text(
                'Aquí va la lista de gastos\n(Tu compañero la hará)',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}