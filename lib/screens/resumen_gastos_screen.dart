import 'package:flutter/material.dart';
import 'package:proyectomoviles/screens/añadir_gasto_screen.dart';
import 'package:proyectomoviles/widgets/expense_grafica.dart';
import 'package:proyectomoviles/widgets/expense_card.dart';
import 'package:proyectomoviles/widgets/edit_expense.dart';
import '../models/expense.dart';
import '../models/category.dart';

class ResumenGastosScreen extends StatefulWidget {
  const ResumenGastosScreen({super.key});

  @override
  State<ResumenGastosScreen> createState() => _ResumenGastosScreenState();
}

class _ResumenGastosScreenState extends State<ResumenGastosScreen> {
  List<Expense> _expenses = [];

  @override
  void initState() {
    super.initState();
    // datos de prueba
    _expenses = [
      Expense(
        titulo: 'Curso Dart',
        monto: 1009.50,
        categoria: Category.trabajo,
        fecha: DateTime(2026, 2, 10),
      ),
      Expense(
        titulo: 'Cine',
        monto: 2020.00,
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
        monto: 1500.00,
        categoria: Category.viaje,
        fecha: DateTime(2026, 2, 2),
      ),
      Expense(
        titulo: 'Comida',
        monto: 700.00,
        categoria: Category.comida,
        fecha: DateTime(2026, 2, 2),
      ),
    ];
  }

  void _abrirDialogoEdicion(Expense expense, int index) async {
    final result = await showDialog(
      context: context,
      builder: (context) => EditExpenseDialog(expense: expense),
    );

    if (result != null) {
      setState(() {
        if (result['action'] == 'edit') {
          _expenses[index] = result['expense'];
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Gasto actualizado ✓')),
          );
        } else if (result['action'] == 'delete') {
          _expenses.removeAt(index);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Gasto eliminado 🗑️')),
          );
        }
      });
    }
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
          ExpenseChart(expenses: _expenses),
          
          Expanded(
            child: _expenses.isEmpty
                ? const Center(
                    child: Text(
                      'No hay gastos registrados\nPresiona + para agregar uno',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: _expenses.length,
                    itemBuilder: (context, index) {
                      return ExpenseCard(
                        expense: _expenses[index],
                        onTap: () => _abrirDialogoEdicion(_expenses[index], index),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}