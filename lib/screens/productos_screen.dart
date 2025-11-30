import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/producto.dart';
import '../models/categoria.dart';
import 'producto_dialog.dart';
import 'movimiento_dialog.dart';

class ProductosScreen extends StatefulWidget {
  const ProductosScreen({Key? key}) : super(key: key);

  @override
  State<ProductosScreen> createState() => _ProductosScreenState();
}

class _ProductosScreenState extends State<ProductosScreen> {
  late Future<List<Producto>> _productosF;
  late Future<List<Categoria>> _categoriasF;
  String _filtroCategoria = 'Todas';
  final _db = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  void _cargarDatos() {
    _productosF = _db.obtenerProductos();
    _categoriasF = _db.obtenerCategorias();
    setState(() {});
  }

  Future<void> _eliminarProducto(int id) async {
    final confirmado = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: const Text('¿Deseas eliminar este producto?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('No'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Sí, eliminar'),
          ),
        ],
      ),
    );

    if (confirmado == true) {
      await _db.eliminarProducto(id);
      _cargarDatos();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Productos'),
        backgroundColor: Colors.blue.shade700,
        elevation: 0,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: Future.wait([_productosF, _categoriasF]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final productos = snapshot.data?[0] as List<Producto>? ?? [];
          final categorias = snapshot.data?[1] as List<Categoria>? ?? [];
          final categoriasNombres = [
            'Todas',
            ...categorias.map((c) => c.nombre),
          ];

          final productosFiltrados = _filtroCategoria == 'Todas'
              ? productos
              : productos
                    .where((p) => p.categoria == _filtroCategoria)
                    .toList();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: categoriasNombres
                        .map(
                          (cat) => Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: FilterChip(
                              label: Text(cat),
                              selected: _filtroCategoria == cat,
                              onSelected: (seleccionado) {
                                setState(() => _filtroCategoria = cat);
                              },
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
              Expanded(
                child: productosFiltrados.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.inventory_2,
                              size: 64,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No hay productos',
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
                        itemCount: productosFiltrados.length,
                        itemBuilder: (context, index) {
                          final producto = productosFiltrados[index];
                          final esPocoStock = producto.cantidad < 5;

                          return Card(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 8,
                            ),
                            elevation: 2,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: esPocoStock
                                    ? Colors.red.shade100
                                    : Colors.green.shade100,
                                child: Icon(
                                  Icons.inventory_2,
                                  color: esPocoStock
                                      ? Colors.red
                                      : Colors.green,
                                ),
                              ),
                              title: Text(
                                producto.nombre,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(producto.descripcion),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Chip(
                                        label: Text(
                                          '\$${producto.precio.toStringAsFixed(2)}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        backgroundColor: Colors.blue,
                                      ),
                                      const SizedBox(width: 8),
                                      Chip(
                                        label: Text(
                                          'Stock: ${producto.cantidad}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: esPocoStock
                                                ? Colors.white
                                                : Colors.black87,
                                          ),
                                        ),
                                        backgroundColor: esPocoStock
                                            ? Colors.red
                                            : Colors.green,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: PopupMenuButton(
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    child: const Text('Editar'),
                                    onTap: () async {
                                      final result = await showDialog(
                                        context: context,
                                        builder: (context) => ProductoDialog(
                                          producto: producto,
                                          categorias: categorias,
                                        ),
                                      );
                                      if (result == true) {
                                        _cargarDatos();
                                      }
                                    },
                                  ),
                                  PopupMenuItem(
                                    child: const Text('Movimiento'),
                                    onTap: () async {
                                      final result = await showDialog(
                                        context: context,
                                        builder: (context) => MovimientoDialog(
                                          producto: producto,
                                        ),
                                      );
                                      if (result == true) {
                                        _cargarDatos();
                                      }
                                    },
                                  ),
                                  PopupMenuItem(
                                    child: const Text(
                                      'Eliminar',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    onTap: () {
                                      _eliminarProducto(producto.id!);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final categorias = await _db.obtenerCategorias();
          if (!mounted) return;

          if (categorias.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Debes crear una categoría primero'),
              ),
            );
            return;
          }

          final result = await showDialog(
            context: context,
            builder: (context) => ProductoDialog(categorias: categorias),
          );

          if (result == true) {
            _cargarDatos();
          }
        },
        backgroundColor: Colors.blue.shade700,
        child: const Icon(Icons.add),
      ),
    );
  }
}
