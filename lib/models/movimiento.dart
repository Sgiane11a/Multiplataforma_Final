class Movimiento {
  int? id;
  int productoId;
  String tipo; // 'entrada' o 'salida'
  int cantidad;
  String motivo;
  DateTime fecha;

  Movimiento({
    this.id,
    required this.productoId,
    required this.tipo,
    required this.cantidad,
    required this.motivo,
    required this.fecha,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'producto_id': productoId,
      'tipo': tipo,
      'cantidad': cantidad,
      'motivo': motivo,
      'fecha': fecha.toIso8601String(),
    };
  }

  factory Movimiento.fromMap(Map<String, dynamic> map) {
    return Movimiento(
      id: map['id'],
      productoId: map['producto_id'],
      tipo: map['tipo'],
      cantidad: map['cantidad'],
      motivo: map['motivo'],
      fecha: DateTime.parse(map['fecha']),
    );
  }
}
