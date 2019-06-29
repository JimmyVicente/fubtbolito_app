import 'dart:convert';
import 'package:futbolito_app/globales/comunication.dart';

class perfilController{

  static final String url = Link.IP_CONEXION+ '/a/perfil/cambiar-contrasenia';
  static final Map<String, String> headers = {
    "content-type": "application/json",
    "accept": "application/json",
  };

  parameters(int idAdministrador, String contrasenia){
    return json.encode({
      "idAdministrador": idAdministrador,
      "contrasenia": contrasenia,
      "pl": 1
    });
  }
}