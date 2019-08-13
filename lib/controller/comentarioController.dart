import 'dart:convert';
import 'package:futbolito_app/controller/Fuctions.dart';
import 'package:futbolito_app/controller/base_api.dart';
import 'package:futbolito_app/controller/comunication.dart';
import 'package:futbolito_app/model/user.dart';
import 'package:http/http.dart' as http;

class comentarioController {

  BaseApi _baseApi = new BaseApi();

  static final Url= Comunication.IP_CONEXION+'/suscripcion/';
  final headersPost = Comunication.headersPost;
  static final headerGet= Comunication.headersGet;



  Future<dynamic> getComentario(int id) async {
    var coneccionInternet = await Fuctions().verificarConecionInternet();
    if(coneccionInternet){
      String url=Url+'?complejo='+id.toString();
      final response = await _baseApi.get(url, headerGet);
      if (response['count']!=0) {
        return response['results'];
      } else {
        return null;
      }
    }else{
     return null;
    }
  }

  Future<dynamic> postComentario(int complejo, String comentario, int punt, ) async {
    var parameters= json.encode({
      "usuario": User.id,
      "complejo": complejo,
      "comentario": comentario,
      "puntuacion_usuario": punt,
      "suscripcion": false
    });
    final coneccionInternet = await Fuctions().verificarConecionInternet();
    if(coneccionInternet){
      final response= await _baseApi.post(Url, headersPost, parameters);
      return response;
    }else{
      return 'No Hay conexión a internet :(';
    }
  }

}