

class Complejo {
  final int nombre;
  final int direccion;
  final String telefono;
  final String puntuacion;

  Complejo({this.nombre, this.direccion, this.telefono, this.puntuacion});

  factory Complejo.fromJson(Map<String, dynamic> json) {
    return Complejo(
      nombre: json['nombre_complejo'],
      direccion: json['direccion_complejo'],
      telefono: json['telefono_complejo'],
      puntuacion: json['puntuacion_complejo'],
    );
  }
}