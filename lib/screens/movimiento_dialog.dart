import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/producto.dart';
import '../models/movimiento.dart';

class MovimientoDialog extends StatefulWidget {
  final Producto producto;

  const MovimientoDialog({Key? key, required this.producto}) : super(key: key);

  @override
  State<MovimientoDialog> createState() => _MovimientoDialogState();
}

class _MovimientoDialogState extends State<MovimientoDialog> {
  late TextEditingController _cantidadController;
  late TextEditingController _motivoController;
  String _tipoMovimiento = 'entrada';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _cantidadController = TextEditingController();
    _motivoController = TextEditingController();
  }

  @override
  void dispose() {
    _cantidadController.dispose();
    _motivoController.dispose();
    super.dispose();
  }

  Future<void> _guardarMovimiento() async {
    if (_cantidadController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Ingresa una cantidad')));
      return;
    }

    final cantidad = int.tryParse(_cantidadController.text);
    if (cantidad == null || cantidad <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('La cantidad debe ser mayor a 0')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final db = DatabaseHelper();

      // Crear el movimiento
      final movimiento = Movimiento(
        productoId: widget.producto.id!,
        tipo: _tipoMovimiento,
        cantidad: cantidad,
        motivo: _motivoController.text,
        fecha: DateTime.now(),
      );

      await db.crearMovimiento(movimiento);

      // Actualizar cantidad del producto
      final nuevaCantidad = _tipoMovimiento == 'entrada'
          ? widget.producto.cantidad + cantidad
          : widget.producto.cantidad - cantidad;

      if (nuevaCantidad < 0) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No hay suficiente stock')),
          );
        }
        return;
      }

      await db.actualizarCantidadProducto(widget.producto.id!, nuevaCantidad);

      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Registrar Movimiento'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Producto: ${widget.producto.nombre}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Stock actual: ${widget.producto.cantidad}',
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 20),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(
                  value: 'entrada',
                  label: Text('Entrada'),
                  icon: Icon(Icons.arrow_downward),
                ),
                ButtonSegment(
                  value: 'salida',
                  label: Text('Salida'),
                  icon: Icon(Icons.arrow_upward),
                ),
              ],
              selected: {_tipoMovimiento},
              onSelectionChanged: (Set<String> newSelection) {
                setState(() => _tipoMovimiento = newSelection.first);
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _cantidadController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Cantidad',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.numbers),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _motivoController,
              decoration: InputDecoration(
                labelText: 'Motivo',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.description),
                hintText: 'Ej: Compra, devolución, etc',
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _guardarMovimiento,
          style: ElevatedButton.styleFrom(
            backgroundColor: _tipoMovimiento == 'entrada'
                ? Colors.green
                : Colors.orange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : const Text('Guardar'),
        ),
      ],
    );
  }
}
