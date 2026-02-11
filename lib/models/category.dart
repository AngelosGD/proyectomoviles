import 'package:flutter/material.dart';

enum Category {
  comida,
  viaje,
  divis,
  trabajo,
}

extension CategoryExtension on Category {
  String get nombre {
    switch (this) {
      case Category.comida:
        return 'Comida';
      case Category.viaje:
        return 'Viaje';
      case Category.divis:
        return 'Divis';
      case Category.trabajo:
        return 'Trabajo';
    }
  }

  IconData get icono {
    switch (this) {
      case Category.comida:
        return Icons.restaurant; 
      case Category.viaje:
        return Icons.flight; 
      case Category.divis:
        return Icons.card_giftcard; 
      case Category.trabajo:
        return Icons.work;
    }
  }

  Color get color {
    switch (this) {
      case Category.comida:
        return Colors.orange;
      case Category.viaje:
        return Colors.blue;
      case Category.divis:
        return Colors.purple;
      case Category.trabajo:
        return Colors.green;
    }
  }
}