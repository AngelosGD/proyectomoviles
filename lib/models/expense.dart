import 'package:intl/intl.dart';
import 'category.dart';

class Expense {
  final String id;
  final String titulo;
  final double monto;
  final Category categoria;
  final DateTime fecha;

  Expense({
    String? id,
    required this.titulo,
    required this.monto,
    required this.categoria,
    required this.fecha,
  }) : id = id ?? DateTime.now().toString();

  String get fechaFormateada {
    return DateFormat('M/d/yyyy').format(fecha);
  }

  String get montoFormateado {
    return '\$${monto.toStringAsFixed(2)}';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'monto': monto,
      'categoria': categoria.index,
      'fecha': fecha.toIso8601String(),
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      titulo: map['titulo'],
      monto: map['monto'],
      categoria: Category.values[map['categoria']],
      fecha: DateTime.parse(map['fecha']),
    );
  }
}