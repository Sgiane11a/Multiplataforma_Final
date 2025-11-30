class Producto {
  int? id;
  String nombre;
  String descripcion;
  double precio;
  int cantidad;
  String categoria;
  DateTime fechaCreacion;
  DateTime? fechaActualizacion;

  Producto({
    this.id,
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.cantidad,
    required this.categoria,
    required this.fechaCreacion,
    this.fechaActualizacion,
  });

  // Convertir a Map para la base de datos
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'precio': precio,
      'cantidad': cantidad,
      'categoria': categoria,
      'fecha_creacion': fechaCreacion.toIso8601String(),
      'fecha_actualizacion': fechaActualizacion?.toIso8601String(),
    };
  }

  // Convertir desde Map
  factory Producto.fromMap(Map<String, dynamic> map) {
    return Producto(
      id: map['id'],
      nombre: map['nombre'],
      descripcion: map['descripcion'],
      precio: (map['precio'] as num).toDouble(),
      cantidad: map['cantidad'],
      categoria: map['categoria'],
      fechaCreacion: DateTime.parse(map['fecha_creacion']),
      fechaActualizacion: map['fecha_actualizacion'] != null
          ? DateTime.parse(map['fecha_actualizacion'])
          : null,
    );
  }

  // Copiar con cambios
  Producto copyWith({
    int? id,
    String? nombre,
    String? descripcion,
    double? precio,
    int? cantidad,
    String? categoria,
    DateTime? fechaCreacion,
    DateTime? fechaActualizacion,
  }) {
    return Producto(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      precio: precio ?? this.precio,
      cantidad: cantidad ?? this.cantidad,
      categoria: categoria ?? this.categoria,
      fechaCreacion: fechaCreacion ?? this.fechaCreacion,
      fechaActualizacion: fechaActualizacion ?? this.fechaActualizacion,
    );
  }
}
