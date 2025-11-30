class Categoria {
  int? id;
  String nombre;
  String descripcion;
  DateTime fechaCreacion;

  Categoria({
    this.id,
    required this.nombre,
    required this.descripcion,
    required this.fechaCreacion,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'fecha_creacion': fechaCreacion.toIso8601String(),
    };
  }

  factory Categoria.fromMap(Map<String, dynamic> map) {
    return Categoria(
      id: map['id'],
      nombre: map['nombre'],
      descripcion: map['descripcion'],
      fechaCreacion: DateTime.parse(map['fecha_creacion']),
    );
  }

  Categoria copyWith({
    int? id,
    String? nombre,
    String? descripcion,
    DateTime? fechaCreacion,
  }) {
    return Categoria(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      fechaCreacion: fechaCreacion ?? this.fechaCreacion,
    );
  }
}
