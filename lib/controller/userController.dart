import 'dart:convert';
import 'dart:io';
import 'package:futbolito_app/controller/signinController.dart';
import 'package:futbolito_app/controller/base_api.dart';
import 'package:futbolito_app/controller/Fuctions.dart';

import 'comunication.dart';

class userController extends Fuctions{

  BaseApi _baseApi = new BaseApi();

  static final Map<String, String> headers = {
    "content-type": "application/json",
    "accept": "application/json",
  };

  parameters(String usuario){
    return json.encode({
      "username": "",
      "email": "",
      "password": "",
      "is_staff": false
    });
  }

  Future<dynamic> getDataUser() async{
    var dataUserPersistence = await signinController().loadSesion();
    var coneccion= await verificarConecionInternet();
    if(coneccion){
      var afterIp=dataUserPersistence['url'].toString();
      var Ip='http://'+Comunication.IP+afterIp.substring(21);
      print(Ip);
      var response = await _baseApi.get(Ip);
        signinController().insertLoginPreferences(response);
        return response;
    }else{
      return dataUserPersistence;
    }
  }

}