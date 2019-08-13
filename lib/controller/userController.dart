import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:futbolito_app/controller/signinController.dart';
import 'package:futbolito_app/controller/base_api.dart';
import 'package:futbolito_app/controller/Fuctions.dart';
import 'package:futbolito_app/model/user.dart';

import 'comunication.dart';

class userController extends Fuctions{

  BaseApi _baseApi = new BaseApi();
  static final headerGet= Comunication.headersGet;
  static final headerPost= Comunication.headersPost;

  Future<dynamic> getDataUser(BuildContext context,Map UserPercistence) async{
    var coneccion= await verificarConecionInternet();
    if(coneccion){
      var Ip=UserPercistence['url'].toString();
      var response = await _baseApi.get(Ip, headerGet);
      if(response==false){
        signinController().clearSesion();
        Navigator.of(context).pushReplacementNamed('/signin');
      }else{
        await signinController().insertLoginPreferences(response);
        return response;
      }
    }else{
      return UserPercistence;
    }
  }

  Future<String> putDataUser(String pass1, String pass2, String pass3) async{
    var passwordNow= Fuctions().toSha256(pass1+ Fuctions().toMd5(pass1));
    var passwordEdit= Fuctions().toSha256(pass2+ Fuctions().toMd5(pass2));
    var passwordConfirmEdit= Fuctions().toSha256(pass2+ Fuctions().toMd5(pass3));
    if(passwordNow==User.password){
      if(passwordEdit!=User.password){
        if(passwordEdit==passwordConfirmEdit){
          var parameters= json.encode({
            "url": User.url,
            "id": User.id,
            "first_name": User.first_name,
            "last_name": User.last_name,
            "username": User.username,
            "email": User.email,
            "password": passwordEdit,
            "is_staff": false
          });
          var resposeEditApi= await _baseApi.put(User.url, headerPost, parameters);
          User().insertUser(resposeEditApi); //Actualizar datos
          return 'editado';
        }else{
          Fluttertoast.showToast(
              msg: "No coiciden las credenciales de la nueva contrseña",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
      }else{
        Fluttertoast.showToast(
            msg: "La contraseña nueva no puede ser la misma que la anterior",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    }else{
      Fluttertoast.showToast(
          msg: "La contraseña actual no coicide",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

}