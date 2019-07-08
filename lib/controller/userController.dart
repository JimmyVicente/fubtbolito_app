import 'dart:convert';
import 'dart:io';
import 'package:futbolito_app/controller/signinController.dart';
import 'package:futbolito_app/controller/base_api.dart';
import 'package:futbolito_app/controller/Fuctions.dart';

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
        var response = await _baseApi.get(dataUserPersistence['url'].toString());
        signinController().insertLoginPreferences(response);
        return response;
    }else{
      return dataUserPersistence;
    }
  }

}