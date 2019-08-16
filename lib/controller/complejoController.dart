import 'dart:convert';
import 'package:futbolito_app/controller/Fuctions.dart';
import 'package:futbolito_app/controller/base_api.dart';
import 'package:futbolito_app/controller/comunication.dart';
import 'package:futbolito_app/model/user.dart';

class complejoController {

  BaseApi _baseApi = new BaseApi();

  static final url= Comunication.ip_conexion+'/complejos';
  static final headerGet= Comunication.headersGet;

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

  Future<dynamic> getCompeljos() async {
    var coneccionInternet = await Fuctions().verificarConecionInternet();
    List complejos=[];
    if(coneccionInternet){
      final response = await _baseApi.get(url, headerGet);
      if (response['count']!=0) {
        for(int i=0; i<response['results'].length; i++){
          String Url= Comunication.ip_conexion+
              '/suscripcion/?usuario=${User.id.toString()}&complejo_id=${response['results'][i]['id']}';
          final resUserComen = await _baseApi.get(Url, headerGet);
          if(resUserComen['count']==1){
            complejos.add({
              "nombre_complejo":response['results'][i]['nombre_complejo'],
              "direccion_complejo":response['results'][i]['direccion_complejo'],
              "telefono_complejo":response['results'][i]['telefono_complejo'],
              "puntuacion_complejo":response['results'][i]['puntuacion_complejo'],
              "id":response['results'][i]['id'],
              "foto_complejo":response['results'][i]['foto_complejo'],
              "coordenadas_complejo":response['results'][i]['coordenadas_complejo'],
              "suscripcion":resUserComen['results'][0]['suscripcion']
            });
          }else{
            complejos.add({
              "nombre_complejo":response['results'][i]['nombre_complejo'],
              "direccion_complejo":response['results'][i]['direccion_complejo'],
              "telefono_complejo":response['results'][i]['telefono_complejo'],
              "puntuacion_complejo":response['results'][i]['puntuacion_complejo'],
              "id":response['results'][i]['id'],
              "foto_complejo":response['results'][i]['foto_complejo'],
              "coordenadas_complejo":response['results'][i]['coordenadas_complejo'],
              "suscripcion":false
            });
          }
        }
        return complejos;
      } else {
        return null;
      }
    }else{
      String data= '[{"nombre_complejo":"-1"}]';
      return json.decode(data);
    }
  }

}