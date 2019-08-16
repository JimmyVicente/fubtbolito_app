import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:futbolito_app/controller/signinController.dart';
import 'package:futbolito_app/controller/base_api.dart';
import 'package:futbolito_app/controller/Fuctions.dart';
import 'package:futbolito_app/model/user.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import 'comunication.dart';

//mailer
import 'dart:io';
import 'package:args/args.dart';
import 'package:logging/logging.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

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
  Future<dynamic> putDataUserPassword(String pass1, String pass2, String pass3) async{
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
          return resposeEditApi;
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
          return null;
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
        return null;
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
      return null;
    }
  }
  Future<dynamic> putDataUserNames(String firstname, String lastName) async{
    var parameters= json.encode({
      "url": User.url,
      "id": User.id,
      "first_name": firstname,
      "last_name": lastName,
      "username": User.username,
      "email": User.email,
      "password": User.password,
      "is_staff": false
    });
    var resposeEditApi= await _baseApi.put(User.url, headerPost, parameters);
    User().insertUser(resposeEditApi); //Actualizar datos
    return resposeEditApi;
  }


  Future<dynamic> sendCorreo(String user) async{
    var Url=Comunication.ip_conexion+'/users/';
    final coneccionInternet = await Fuctions().verificarConecionInternet();
    if(coneccionInternet){
      String url='';
      if(Fuctions().verificarCorreo(user)){
        url= Url+'?email=';
      }else{
        url= Url+'?username=';
      }
      final responseUser = await _baseApi.get(url+user, headerGet);
      if(responseUser['count']!=0){
        Map user =responseUser['results'][0];
        String passRandon=passwordRandon();
        String passOld=user['password'];
        var passwordEdit= Fuctions().toSha256(passRandon+ Fuctions().toMd5(passRandon));
        var parameters=  bodyPutpassword(user, passwordEdit);
        var resposeEditApi= await _baseApi.put(user['url'], headerPost, parameters);
        if(resposeEditApi['url']!=null){
          var sendEmail = await mainEmail(responseUser['results'][0]['email'].toString(), passRandon);
          if(sendEmail==true){
            return 'enviado';
          }else{
            var parametersold=  bodyPutpassword(user, passOld);
            await _baseApi.put(user['url'], headerPost, parametersold);
            return 'no enviado';
          }
        }
      }else{
        return 'Usuario/Correo incorrecto';
      }
    }else{
      return 'No Hay conexión a internet :(';
    }

  }

  mainEmail(String email, String clave) async {
    String username = 'canchascalvacalva@gmail.com';
    String password = 'Reserva1234';

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'FUTLBOLITO🛠')
      ..recipients.add(email)
      ..subject = 'Recuperación de Contraseña⚙'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h1>Estamos para ayudarte..!</h1>\n"
          "<p>Te notificamos para darte a conocer tu nueva\ncontraseña: <h3>${clave}</h3></p>\n"
          "<h5>Gracias por confiar en nosostros..! 😀💖❤</h5>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      return true;
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
      return false;
    }
  }

  passwordRandon() {
    var rng = new Random();
    String password='';
    for (var i = 0; i < 5; i++) {
      password=password+'${rng.nextInt(10)}';
    }
    return password;
  }

  bodyPutpassword(Map user, String password){
    return json.encode({
      "url": user['url'],
      "id": user['id'],
      "first_name": user['first_name'],
      "last_name": user['last_name'],
      "username": user['username'],
      "email": user['email'],
      "password": password,
      "is_staff": false
    });
  }



}