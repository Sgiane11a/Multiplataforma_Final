import '../models/producto.dart';
import '../models/categoria.dart';
import '../models/movimiento.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  // Simulación de base de datos en memoria para Web
  static List<Categoria> _categorias = [];
  static List<Producto> _productos = [];
  static List<Movimiento> _movimientos = [];
  static int _nextCategoriaId = 1;
  static int _nextProductoId = 1;
  static int _nextMovimientoId = 1;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<void> get database async {
    // Inicializar datos de ejemplo si están vacíos
    if (_categorias.isEmpty) {
      await _initializeData();
    }
  }

  Future<void> _initializeData() async {
    // Crear categorías de ejemplo
    _categorias = [
      Categoria(
        id: _nextCategoriaId++,
        nombre: 'Electrónicos',
        descripcion: 'Dispositivos electrónicos',
        fechaCreacion: DateTime.now(),
      ),
      Categoria(
        id: _nextCategoriaId++,
        nombre: 'Ropa',
        descripcion: 'Prendas de vestir',
        fechaCreacion: DateTime.now(),
      ),
    ];

    // Crear productos de ejemplo
    _productos = [
      Producto(
        id: _nextProductoId++,
        nombre: 'Laptop Dell',
        descripcion: 'Laptop para oficina',
        precio: 899.99,
        cantidad: 5,
        categoria: 'Electrónicos',
        fechaCreacion: DateTime.now(),
      ),
      Producto(
        id: _nextProductoId++,
        nombre: 'Camiseta Nike',
        descripcion: 'Camiseta deportiva',
        precio: 29.99,
        cantidad: 15,
        categoria: 'Ropa',
        fechaCreacion: DateTime.now(),
      ),
    ];
  }

  // ============ OPERACIONES CRUD PRODUCTOS ============

  Future<int> crearProducto(Producto producto) async {
    await database;
    final nuevoProducto = producto.copyWith(
      id: _nextProductoId++,
      fechaCreacion: DateTime.now(),
    );
    _productos.add(nuevoProducto);
    return nuevoProducto.id!;
  }

  Future<List<Producto>> obtenerProductos() async {
    await database;
    return List.from(_productos);
  }

  Future<Producto?> obtenerProductoPorId(int id) async {
    await database;
    try {
      return _productos.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<List<Producto>> obtenerProductosPorCategoria(String categoria) async {
    await database;
    return _productos.where((p) => p.categoria == categoria).toList();
  }

  Future<int> actualizarProducto(Producto producto) async {
    await database;
    final index = _productos.indexWhere((p) => p.id == producto.id);
    if (index != -1) {
      _productos[index] = producto.copyWith(fechaActualizacion: DateTime.now());
      return 1;
    }
    return 0;
  }

  Future<int> eliminarProducto(int id) async {
    await database;
    final index = _productos.indexWhere((p) => p.id == id);
    if (index != -1) {
      _productos.removeAt(index);
      return 1;
    }
    return 0;
  }

  // ============ OPERACIONES CRUD CATEGORÍAS ============

  Future<int> crearCategoria(Categoria categoria) async {
    await database;
    final nuevaCategoria = categoria.copyWith(
      id: _nextCategoriaId++,
      fechaCreacion: DateTime.now(),
    );
    _categorias.add(nuevaCategoria);
    return nuevaCategoria.id!;
  }

  Future<List<Categoria>> obtenerCategorias() async {
    await database;
    return List.from(_categorias);
  }

  Future<int> actualizarCategoria(Categoria categoria) async {
    await database;
    final index = _categorias.indexWhere((c) => c.id == categoria.id);
    if (index != -1) {
      _categorias[index] = categoria;
      return 1;
    }
    return 0;
  }

  Future<int> eliminarCategoria(int id) async {
    await database;
    final index = _categorias.indexWhere((c) => c.id == id);
    if (index != -1) {
      _categorias.removeAt(index);
      return 1;
    }
    return 0;
  }

  // ============ OPERACIONES CRUD MOVIMIENTOS ============

  Future<int> crearMovimiento(Movimiento movimiento) async {
    await database;
    final nuevoMovimiento = Movimiento(
      id: _nextMovimientoId++,
      productoId: movimiento.productoId,
      tipo: movimiento.tipo,
      cantidad: movimiento.cantidad,
      motivo: movimiento.motivo,
      fecha: DateTime.now(),
    );
    _movimientos.add(nuevoMovimiento);
    return nuevoMovimiento.id!;
  }

  Future<List<Movimiento>> obtenerMovimientos() async {
    await database;
    final movimientos = List<Movimiento>.from(_movimientos);
    movimientos.sort((a, b) => b.fecha.compareTo(a.fecha));
    return movimientos;
  }

  Future<List<Movimiento>> obtenerMovimientosPorProducto(int productoId) async {
    await database;
    final movimientos = _movimientos
        .where((m) => m.productoId == productoId)
        .toList();
    movimientos.sort((a, b) => b.fecha.compareTo(a.fecha));
    return movimientos;
  }

  // ============ OPERACIONES ESPECIALES ============

  Future<void> actualizarCantidadProducto(
    int productoId,
    int nuevaCantidad,
  ) async {
    await database;
    final index = _productos.indexWhere((p) => p.id == productoId);
    if (index != -1) {
      _productos[index] = _productos[index].copyWith(
        cantidad: nuevaCantidad,
        fechaActualizacion: DateTime.now(),
      );
    }
  }

  Future<Map<String, dynamic>> obtenerEstadisticas() async {
    await database;

    final totalProductos = _productos.length;
    final totalCategorias = _categorias.length;
    final totalMovimientos = _movimientos.length;

    final valorInventario = _productos.fold<double>(
      0.0,
      (sum, producto) => sum + (producto.precio * producto.cantidad),
    );

    return {
      'totalProductos': totalProductos,
      'totalCategorias': totalCategorias,
      'totalMovimientos': totalMovimientos,
      'valorInventario': valorInventario,
    };
  }

  Future<void> limpiarBaseDatos() async {
    await database;
    _movimientos.clear();
    _productos.clear();
    _categorias.clear();
    _nextCategoriaId = 1;
    _nextProductoId = 1;
    _nextMovimientoId = 1;
    await _initializeData();
  }
}
