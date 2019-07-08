import 'dart:convert';
import 'package:futbolito_app/controller/comunication.dart';
import 'package:futbolito_app/controller/Fuctions.dart';

class registerController{

  static final String url = Comunication.IP_CONEXION+ '/users/';
  static final Map<String, String> headers = {
    "content-type": "application/json",
    "accept": "application/json",
  };

  parameters(String user, String email, String contrasenia){
    print(Fuctions().toSha256(contrasenia+ Fuctions().toMd5(contrasenia)));
    return json.encode({
      "username": user,
      "email": email,
      "password": Fuctions().toSha256(contrasenia+ Fuctions().toMd5(contrasenia)),
      "is_staff": false
    });
  }
}
