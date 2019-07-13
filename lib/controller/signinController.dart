import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:futbolito_app/model/user.dart';
import 'package:futbolito_app/controller/base_api.dart';
import 'package:futbolito_app/controller/comunication.dart';
import 'package:futbolito_app/controller/Fuctions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class signinController {

  BaseApi _baseApi = new BaseApi();

  static String Url= Comunication.IP_CONEXION+'/users/';

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

  Future<dynamic> verificarInicio(String user, String password) async{
    final coneccionInternet = await Fuctions().verificarConecionInternet();
    if(coneccionInternet){
      String url='';
      if(Fuctions().verificarCorreo(user)){
        url= Url+'?email=';
      }else{
        url= Url+'?username=';
      }
      final response = await _baseApi.get(url+user);
      if(response['count']!=0){
        String passwordResponse =response['results'][0]['password'];
        String passwordImput= Fuctions().toSha256(password+ Fuctions().toMd5(password));
        if(passwordResponse==passwordImput){
          insertLoginPreferences(response['results'][0]);
          User.user = response['results'][0];
          if(loadSesion!=null){
            return 'logeado';
          }else{
            return 'Algo salio mal';
          }
        }else{
          return 'Contraseña incorrecta';
        }
      }else{
        return 'Usuario incorrecto';
      }
    }else{
      return 'No Hay conexión a internet :(';
    }

  }




  //---metodo para insertar a persistencia de datos de sesion
  insertLoginPreferences(Object data) async {
    var sesion= json.encode(data);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('sesion', sesion);
  }

  //---metodo para verficar si ha iniciado sesion
  Future<dynamic> loadSesion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String sesion = prefs.getString('sesion') ?? null;
    var data=null;
    if(sesion!=null){
      data = json.decode(sesion);
    }
    return data;
  }

  //--metodo para verficar eliminar sesion
   Future<dynamic> clearSesion() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('sesion');
    String sesion =prefs.getString('sesion') ?? null;
    return sesion;
  }

  //Metodo para salir o iniciar sesion persistence
  Future<void> verificarLogeado(BuildContext context) async{
    var UserPercistence = await loadSesion();
    if(UserPercistence!=null){
      Navigator.of(context).pushReplacementNamed('/home');
    }else{
      Navigator.of(context).pushReplacementNamed('/signin');
    }
  }

}
