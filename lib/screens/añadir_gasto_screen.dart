import 'package:flutter/material.dart';

class AgregarGastoScreen extends StatefulWidget {
  const AgregarGastoScreen({super.key});

  @override
  State<AgregarGastoScreen> createState() => _AgregarGastoScreenState();
}

class _AgregarGastoScreenState extends State<AgregarGastoScreen> {
  final _tituloController = TextEditingController();
  final _montoController = TextEditingController();
  

  DateTime? _fechaSeleccionada; 
  String _categoriaSeleccionada = 'Comida';

  final List<String> _categorias = ['Comida', 'Viaje', 'Divis', 'Trabajo'];

  
  void _mostrarSelectorFecha() async {
    final fechaActual = DateTime.now();
    
    final primeraFecha = DateTime(fechaActual.year - 1, fechaActual.month, fechaActual.day);
    
    final ultimaFecha = DateTime(fechaActual.year + 1, fechaActual.month, fechaActual.day);

    final fechaElegida = await showDatePicker(
      context: context,
      initialDate: fechaActual,
      firstDate: primeraFecha,
      lastDate: ultimaFecha,
    );

    if (fechaElegida != null) {
      setState(() {
        _fechaSeleccionada = fechaElegida;
      });
    }
  }

  void _enviarDatos() {
    if (_tituloController.text.isEmpty || 
        _montoController.text.isEmpty || 
        _fechaSeleccionada == null) {
      return;
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Nuevo Gasto'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _tituloController,
              decoration: const InputDecoration(labelText: 'Título del gasto'),
            ),
            
            
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _montoController,
                    decoration: const InputDecoration(labelText: 'Monto (\$)'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                
               
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _fechaSeleccionada == null
                            ? 'Sin fecha'
                            : '${_fechaSeleccionada!.day}/${_fechaSeleccionada!.month}/${_fechaSeleccionada!.year}',
                      ),
                      IconButton(
                        onPressed: _mostrarSelectorFecha,
                        icon: const Icon(Icons.calendar_month),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('Categoría: '),
                DropdownButton<String>(
                  value: _categoriaSeleccionada,
                  items: _categorias.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _categoriaSeleccionada = newValue!;
                    });
                  },
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                ElevatedButton(
                  onPressed: _enviarDatos,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                  ),
                  child: const Text(
                    'Guardar Gasto',
                    style: TextStyle(color: Colors.white),
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