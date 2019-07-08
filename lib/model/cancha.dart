

class Cancha {
  final int id;
  final String descripcion_cancha;
  final String valor_dia;
  final String valor_noche;
  final String estado_cancha;
  final String complejo_id;

  Cancha({this.id,
    this.descripcion_cancha,
    this.valor_dia,
    this.valor_noche,
    this.estado_cancha,
    this.complejo_id});

  factory Cancha.fromJson(Map<String, dynamic> json) {
    return new Cancha(
      id: json['id'],
      descripcion_cancha:json['descripcion_cancha'],
      valor_dia:json['valor_dia'],
      valor_noche:json['valor_noche'],
      estado_cancha: json['estado_cancha'],
      complejo_id: json['complejo_id'],
    );
  }
}