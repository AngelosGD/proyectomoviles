import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/expense.dart';
import '../models/category.dart';

class ExpenseChart extends StatelessWidget {
  final List<Expense> expenses;

  const ExpenseChart({
    super.key,
    required this.expenses,
  });

  // Calcula el total gastado por cada categoría
  Map<Category, double> _calculateCategoryTotals() {
    Map<Category, double> totals = {
      Category.comida: 0,
      Category.viaje: 0,
      Category.divis: 0,
      Category.trabajo: 0,
    };

    for (var expense in expenses) {
      totals[expense.categoria] = totals[expense.categoria]! + expense.monto;
    }

    return totals;
  }

  // Encuentra el valor máximo para escalar la gráfica
  double _getMaxValue(Map<Category, double> totals) {
    double max = totals.values.reduce((a, b) => a > b ? a : b);
    return max == 0 ? 100 : max * 1.2; // 20% más alto para que no toque el tope
  }

  @override
  Widget build(BuildContext context) {
    final totals = _calculateCategoryTotals();
    final maxY = _getMaxValue(totals);

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      height: 200,
      decoration: BoxDecoration(
        color: Colors.transparent, // Sin fondo
        borderRadius: BorderRadius.circular(20),
      ),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: maxY,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (group) => Colors.black87,
              tooltipPadding: const EdgeInsets.all(8),
              tooltipMargin: 8,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                String categoryName = Category.values[group.x.toInt()].nombre;
                return BarTooltipItem(
                  '$categoryName\n\$${rod.toY.toStringAsFixed(2)}',
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final category = Category.values[value.toInt()];
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Icon(
                      category.icono,
                      size: 24,
                      color: Colors.deepPurple.shade300, // Iconos morados
                    ),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  return Text(
                    '\$${value.toInt()}',
                    style: const TextStyle(fontSize: 10),
                  );
                },
              ),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: maxY / 5,
          ),
          borderData: FlBorderData(show: false),
          barGroups: [
            _makeBarGroup(0, totals[Category.comida]!, Category.comida.color, maxY),
            _makeBarGroup(1, totals[Category.viaje]!, Category.viaje.color, maxY),
            _makeBarGroup(2, totals[Category.divis]!, Category.divis.color, maxY),
            _makeBarGroup(3, totals[Category.trabajo]!, Category.trabajo.color, maxY),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _makeBarGroup(int x, double value, Color color, double maxY) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          color: Colors.deepPurple.shade300, // Barras moradas
          width: 50,
          borderRadius: BorderRadius.circular(8),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: maxY,
            color: Colors.grey.shade200, // Fondo gris clarito
          ),
        ),
      ],
    );
  }
}