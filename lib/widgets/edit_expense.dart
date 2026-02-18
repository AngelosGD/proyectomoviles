import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../models/category.dart';

class EditExpenseDialog extends StatefulWidget {
  final Expense expense;

  const EditExpenseDialog({super.key, required this.expense});

  @override
  State<EditExpenseDialog> createState() => _EditExpenseDialogState();
}

class _EditExpenseDialogState extends State<EditExpenseDialog> {
  late TextEditingController _tituloController;
  late TextEditingController _montoController;
  late Category _categoriaSeleccionada;
  late DateTime _fechaSeleccionada;

  @override
  void initState() {
    super.initState();
    _tituloController = TextEditingController(text: widget.expense.titulo);
    _montoController = TextEditingController(
      text: widget.expense.monto.toString(),
    );
    _categoriaSeleccionada = widget.expense.categoria;
    _fechaSeleccionada = widget.expense.fecha;
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _montoController.dispose();
    super.dispose();
  }

  Future<void> _seleccionarFecha() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _fechaSeleccionada,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _fechaSeleccionada) {
      setState(() {
        _fechaSeleccionada = picked;
      });
    }
  }

  void _guardarCambios() {
    if (_tituloController.text.isEmpty || _montoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor completa todos los campos')),
      );
      return;
    }

    final expenseEditado = Expense(
      id: widget.expense.id,
      titulo: _tituloController.text,
      monto: double.tryParse(_montoController.text) ?? 0,
      categoria: _categoriaSeleccionada,
      fecha: _fechaSeleccionada,
    );

    Navigator.of(context).pop({'action': 'edit', 'expense': expenseEditado});
  }

  void _eliminarGasto() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('¿Eliminar gasto?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pop({'action': 'delete'});
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Editar Gasto',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 20),

            TextField(
              controller: _tituloController,
              decoration: const InputDecoration(
                labelText: 'Título',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.title),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _montoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Monto',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.attach_money),
              ),
            ),
            const SizedBox(height: 16),

            DropdownButtonFormField<Category>(
              initialValue: _categoriaSeleccionada,
              decoration: const InputDecoration(
                labelText: 'Categoría',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.category),
              ),
              items: Category.values.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Row(
                    children: [
                      Icon(category.icono, size: 20),
                      const SizedBox(width: 8),
                      Text(category.nombre),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _categoriaSeleccionada = value!;
                });
              },
            ),
            const SizedBox(height: 16),

            InkWell(
              onTap: _seleccionarFecha,
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Fecha',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                child: Text(
                  '${_fechaSeleccionada.day}/${_fechaSeleccionada.month}/${_fechaSeleccionada.year}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Botón Eliminar
                TextButton.icon(
                  onPressed: _eliminarGasto,
                  icon: const Icon(Icons.delete, color: Colors.red),
                  label: const Text(
                    'Eliminar',
                    style: TextStyle(color: Colors.red),
                  ),
                ),

                ElevatedButton.icon(
                  onPressed: _guardarCambios,
                  icon: const Icon(Icons.save),
                  label: const Text('Guardar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
