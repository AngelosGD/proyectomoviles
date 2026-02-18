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
    _expenses = [];
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
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Gasto actualizado ')));
        } else if (result['action'] == 'delete') {
          _expenses.removeAt(index);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Gasto eliminado')));
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
            onPressed: () async {
              final nuevoGasto = await Navigator.push<Expense>(
                context,
                MaterialPageRoute(
                  builder: (context) => const AgregarGastoScreen(),
                ),
              );

              if (nuevoGasto != null) {
                setState(() {
                  _expenses.add(nuevoGasto);
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Gasto agregado exitosamente ')),
                );
              }
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
                      'aun sin gastos',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: _expenses.length,
                    itemBuilder: (context, index) {
                      return ExpenseCard(
                        expense: _expenses[index],
                        onTap: () =>
                            _abrirDialogoEdicion(_expenses[index], index),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
