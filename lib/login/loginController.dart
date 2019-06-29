import 'dart:convert';
import 'package:futbolito_app/globales/comunication.dart';
import 'package:futbolito_app/globales/functios.dart';

class loginController{

  static final String url = Link.IP_CONEXION+ '/a/login/autenticar';
  static final Map<String, String> headers = {
    "content-type": "application/json",
    "accept": "application/json",
  };

//  parameters(String usuario, String contrasenia){
//    print( fuctions().generateMd5(contrasenia));
//    return json.encode({
//      "usuario": usuario,
//      "contrasenia":  fuctions().generateMd5(contrasenia),
//      "pl": 1
//    });
//  }
}
