import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../database/database_helper.dart';
import '../models/movimiento.dart';

class MovimientosScreen extends StatefulWidget {
  const MovimientosScreen({Key? key}) : super(key: key);

  @override
  State<MovimientosScreen> createState() => _MovimientosScreenState();
}

class _MovimientosScreenState extends State<MovimientosScreen> {
  late Future<List<Movimiento>> _movimientosF;
  final _db = DatabaseHelper();
  final _formato = DateFormat('dd/MM/yyyy HH:mm');

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  void _cargarDatos() {
    _movimientosF = _db.obtenerMovimientos();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de Movimientos'),
        backgroundColor: Colors.orange.shade700,
        elevation: 0,
      ),
      body: FutureBuilder<List<Movimiento>>(
        future: _movimientosF,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final movimientos = snapshot.data ?? [];

          return movimientos.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.history,
                        size: 64,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No hay movimientos',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: movimientos.length,
                  itemBuilder: (context, index) {
                    final movimiento = movimientos[index];
                    final esEntrada = movimiento.tipo == 'entrada';

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      elevation: 2,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: esEntrada
                              ? Colors.green.shade100
                              : Colors.red.shade100,
                          child: Icon(
                            esEntrada
                                ? Icons.arrow_downward
                                : Icons.arrow_upward,
                            color: esEntrada ? Colors.green : Colors.red,
                          ),
                        ),
                        title: Text(
                          'Producto ID: ${movimiento.productoId}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Tipo: ${esEntrada ? 'Entrada' : 'Salida'}'),
                            Text(
                              'Cantidad: ${movimiento.cantidad}',
                              style: TextStyle(
                                color: esEntrada ? Colors.green : Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (movimiento.motivo.isNotEmpty)
                              Text('Motivo: ${movimiento.motivo}'),
                            Text(
                              'Fecha: ${_formato.format(movimiento.fecha)}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
