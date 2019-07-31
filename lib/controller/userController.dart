import 'dart:convert';
import 'dart:io';
import 'package:futbolito_app/controller/signinController.dart';
import 'package:futbolito_app/controller/base_api.dart';
import 'package:futbolito_app/controller/Fuctions.dart';

import 'comunication.dart';

class userController extends Fuctions{

  BaseApi _baseApi = new BaseApi();

  static final headerGet= Comunication.headersGet;
  static final headerPost= Comunication.headersPost;


  parameters(String usuario){
    return json.encode({
      "username": "",
      "email": "",
      "password": "",
      "is_staff": false
    });
  }

  Future<dynamic> getDataUser(Map UserPercistence) async{
    var coneccion= await verificarConecionInternet();
    if(coneccion){
      var Ip=UserPercistence['url'].toString();
      var response = await _baseApi.get(Ip, headerGet);
        signinController().insertLoginPreferences(response);
        return response;
    }else{
      return UserPercistence;
    }
  }

  Future<String> putDataUser(Map user, String pass1, String pass2) async{
    var passwordNow= Fuctions().toSha256(pass1+ Fuctions().toMd5(pass1));
    var passwordEdit= Fuctions().toSha256(pass2+ Fuctions().toMd5(pass2));
    if(passwordNow==user['password']){
      var parameters= json.encode({
        "url": user['url'],
        "id": user['id'],
        "first_name": user['first_name'],
        "last_name": user['last_name'],
        "username": user['username'],
        "email": user['email'],
        "password": passwordEdit,
        "is_staff": false
      });
      var resposeEditApi= await _baseApi.put(user['url'], headerPost, parameters);
      print(resposeEditApi);
      return 'editado';
    }else{
      return 'Escriba bien su contraseña actual';
    }
  }

}