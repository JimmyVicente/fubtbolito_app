import 'dart:convert';
import 'package:futbolito_app/controller/Fuctions.dart';
import 'package:futbolito_app/controller/base_api.dart';
import 'package:futbolito_app/controller/comunication.dart';
import 'package:futbolito_app/model/user.dart';
import 'package:http/http.dart' as http;

class comentarioController {

  BaseApi _baseApi = new BaseApi();

  static final Url= Comunication.ip_conexion+'/suscripcion/';
  final headersPost = Comunication.headersPost;
  static final headerGet= Comunication.headersGet;
  static List comentarios=[];
  static Map coemntarioHecho;

  Future<dynamic> getUserComentario(int id) async {
    comentarios=[];
    coemntarioHecho=null;
    final resUserComen = await _baseApi.get(Url+'?usuario=${User.id.toString()}&complejo_id=${id.toString()}', headerGet);
    if(resUserComen['count']==1){
      final resusuario = await _baseApi.get(Comunication.ip_conexion+'/users/${User.id.toString()}/', headerGet);
      coemntarioHecho=formatResponse(resUserComen['results'][0], resusuario);
      comentarios.add(coemntarioHecho);
      return coemntarioHecho;
    }else{
      return null;
    }
  }
  Future<dynamic> getComentario(int id) async {
    var coneccionInternet = await Fuctions().verificarConecionInternet();
    if(coneccionInternet){
      String url=Url+'?complejo='+id.toString();
      final resComentario = await _baseApi.get(url, headerGet);
      if (resComentario['count']!=0) {
        for(int i=0; i<resComentario['results'].length; i++){
          String user= resComentario['results'][i]['usuario'].toString();
          final resusuario = await _baseApi.get(Comunication.ip_conexion+'/users/${user}/', headerGet);
          if(coemntarioHecho!=null&&resComentario['results'][i]['id']==coemntarioHecho['id']){}else{
            comentarios.add(formatResponse(resComentario['results'][i], resusuario));
          }
        }
        return comentarios;
      } else {
        return null;
      }
    }else{
     return null;
    }
  }



  Future<dynamic> saveUpdateComentario(int complejo, String comentario, int punt, bool sub, Map resUserComHecho) async {
    var parameters= json.encode({
      "usuario": User.id,
      "complejo": complejo,
      "comentario": comentario,
      "puntuacion_usuario": punt,
      "suscripcion": sub
    });
    final coneccionInternet = await Fuctions().verificarConecionInternet();
    if(coneccionInternet){
      var response;
      bool tipoApi=false;
      if(resUserComHecho==null){
        response= await _baseApi.post(Url, headersPost, parameters);
      }else{
        response= await _baseApi.put(Url+resUserComHecho['id'].toString()+'/', headersPost, parameters);
        tipoApi=true;
      }
      final resusuario = await _baseApi.get(Comunication.ip_conexion+'/users/${User.id.toString()}/', headerGet);
      if(tipoApi){
        return {
          "id": response['id'],
          "actualizar": "si",
          "usuario": resusuario,
          "complejo": response['complejo'],
          "comentario": response['comentario'],
          "puntuacion_usuario": response['puntuacion_usuario'],
          "fecha_creacion": response['fecha_creacion'],
          "suscripcion": response['suscripcion'],
        };
      }else{
        return formatResponse(response, resusuario);
      }

    }else{
      return 'No Hay conexión a internet :(';
    }
  }

  formatResponse(Map response, Map resusuario){
    return {
      "id": response['id'],
      "usuario": resusuario,
      "complejo": response['complejo'],
      "comentario": response['comentario'],
      "puntuacion_usuario": response['puntuacion_usuario'],
      "fecha_creacion": response['fecha_creacion'],
      "suscripcion": response['suscripcion'],
    };
  }


}