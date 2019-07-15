import 'dart:convert';
import 'package:futbolito_app/controller/comunication.dart';
import 'package:futbolito_app/controller/Fuctions.dart';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;


import 'base_api.dart';

class registerController{

  static final String Url = Comunication.IP_CONEXION+ '/users/';

  BaseApi _baseApi = new BaseApi();

  static final Map<String, String> headers = {
    "content-type": "application/json",
    "accept": "application/json",
    HttpHeaders.authorizationHeader: "Basic amx2aWNlbnRlOjE1MjM="
  };

  parameters(String firstName, String lastName,String username, String email, String contrasenia){
    return json.encode({
      "first_name": firstName,
      "last_name": lastName,
      "username": username,
      "email": email,
      "password": Fuctions().toSha256(contrasenia+ Fuctions().toMd5(contrasenia)),
      "is_staff": false
    });
  }

  Future<String> postSignup(String firstName, String lastName,String username, String email, String contrasenia) async {
    var parameters= json.encode({
      "first_name": firstName,
      "last_name": lastName,
      "username": username,
      "email": email,
      "password": Fuctions().toSha256(contrasenia+ Fuctions().toMd5(contrasenia)),
      "is_staff": false
    });
    final coneccionInternet = await Fuctions().verificarConecionInternet();
    if(coneccionInternet){
      final responseGetEmailUsers = await getEmailUsers(email);
      if(responseGetEmailUsers==false){
        http.Response response = await http.post(Url, body: parameters, headers: headers);
        var dataResponse=json.decode(response.body);
        if(dataResponse['url']!=null){
          return 'registrado';
        }else{
          return 'Ya existe un usuario con este nombre';
        }
      }else{
        return 'Alguien mas tiene este correo';
      }
    }else{
      return 'No Hay conexión a internet :(';
    }
  }

  Future<bool> getEmailUsers(String email) async {
    bool emailbase= false;
    var response = await _baseApi.get(Url);
    List data= response['results'];
    for(int i=0; i<data.length;i++){
      if(email==data[i]['email'].toString()){
        emailbase= true;
      }
    }
    return emailbase;
  }

}
