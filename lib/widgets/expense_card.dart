import 'package:flutter/material.dart';
import 'package:proyectomoviles/models/category.dart';
import '../models/expense.dart';

class ExpenseCard extends StatelessWidget {
  final Expense expense;

  const ExpenseCard({
    super.key,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Columna izquierda: Título y Monto
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título del gasto
                Text(
                  expense.titulo,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                // Monto
                Text(
                  expense.montoFormateado,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
          
          // Columna derecha: Ícono y Fecha
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Ícono de categoría
              Icon(
                expense.categoria.icono,
                color: Colors.black54,
                size: 24,
              ),
              const SizedBox(height: 4),
              // Fecha
              Text(
                expense.fechaFormateada,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}