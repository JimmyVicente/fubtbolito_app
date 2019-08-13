import 'dart:convert';
import 'package:futbolito_app/controller/comunication.dart';
import 'package:futbolito_app/controller/Fuctions.dart';
import 'dart:async';
import 'package:http/http.dart' as http;


import 'base_api.dart';

class registerController{

   String Url = Comunication.IP_CONEXION+ '/users/';
   final headersPost = Comunication.headersPost;
   static final headerGet= Comunication.headersGet;

  BaseApi _baseApi = new BaseApi();


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
        final response= await _baseApi.post(Url, headersPost, parameters);
        if(response['url']!=null){
          return 'registrado';
        }else if(response['email']!=null){
          return response['email'].toString();
        }else if(response['username']!=null){
          return response['username'].toString();
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
    var response = await _baseApi.get(Url, headerGet);
    List data= response['results'];
    for(int i=0; i<data.length;i++){
      if(email==data[i]['email'].toString()){
        emailbase= true;
      }
    }
    return emailbase;
  }

}
