import 'dart:convert';
import 'package:flutter/src/material/time.dart';
import 'package:futbolito_app/controller/base_api.dart';
import 'package:futbolito_app/controller/comunication.dart';
import 'package:futbolito_app/controller/Fuctions.dart';
import 'package:http/http.dart' as http;

class reservaController {

  BaseApi _baseApi = new BaseApi();

  static String Url= Comunication.IP_CONEXION+'/reservas/';
  final headersPost = Comunication.headersPost;
  final headerGet = Comunication.headersGet;


  Future<dynamic> getReservaUser() async {
    var coneccionInternet = await Fuctions().verificarConecionInternet();
    if(coneccionInternet){
      final response = await _baseApi.get(Url, headerGet);
      if (response['count']!=0) {
        return response['results'];
      } else {
        return null;
      }
    }else{
      String data= '[{"usuario":"-1"}]';
      return json.decode(data);
    }
  }

  Future<dynamic> getReserva() async {
    var coneccionInternet = await Fuctions().verificarConecionInternet();
    if(coneccionInternet){
      final response = await _baseApi.get(Url, headerGet);
      if (response['count']!=0) {
        return response['results'];
      } else {
        return null;
      }
    }else{
      String data= '[{"usuario":"-1"}]';
      return json.decode(data);
    }
  }

  Future<String> validarReserva(List dataCancha, int idCancha, String date, String startTime, String endTime) async {
    List reservas = await getReserva();

    List reservasComplejo=[];

    for(int i=0; i<reservas.length; i++){
      if(reservas[i]['estado_reserva']==true){
        for(int j=0; j<dataCancha.length; j++){
          print(reservas[1]['cancha'].toString() +'=='+ dataCancha[j]['id'].toString());
          if(reservas[i]['cancha']==dataCancha[j]['id']){
            reservasComplejo.add(reservas[i]);
            print(dataCancha[j]['id']);
          }
        }
      }
    }

    print(reservasComplejo);

    for(int i=0; i<reservasComplejo.length; i++){
      if(reservasComplejo[i]['cancha']==idCancha && reservasComplejo[i]['fecha_reserva'].toString()==date && reservasComplejo[i]['hora_inicio']== startTime&& reservasComplejo[i]['hora_fin']==endTime){
        return 'La cancha está ocupada';
      }else{
        return 'guardado';
      }
    }


//    else if(reservasComplejo[i]['cancha'] == idCancha && reservasComplejo[i]['fecha_reserva']==date && ((startTime.hour > reservasComplejo[i]['hora_inicio'] && startTime.hour < reservasComplejo[i]['hora_fin']) || (endTime.hour >reservasComplejo[i]['hora_fin'] && endTime.hour < reservasComplejo[i]['hora_fin']) || (startTime == reservasComplejo[i]['hora_inicio']|| endTime == reservasComplejo[i]['hora_fin']) || (startTime.hour < reservasComplejo[i]['hora_inicio'] && endTime.hour > reservasComplejo[i]['hora_fin']))){
//    return 'La cancha está ocupada';
//    }

  }


  Future<String> postReserva(int idUser,int idCancha, String Date,String startTime, String endTime, double valorU, double valorT) async {
    var parameters= json.encode({
      "usuario": idUser,
      "cancha": idCancha,
      "fecha_reserva": Date,
      "hora_inicio": startTime,
      "hora_fin": endTime,
      "valor_unitario": valorU,
      "valor_total": valorT,
      "estado_reserva": true
    });
    final coneccionInternet = await Fuctions().verificarConecionInternet();
    if(coneccionInternet){
      http.Response response = await http.post(Url, body: parameters, headers: headersPost);
      return response.body;
    }else{
      return 'No Hay conexión a internet :(';
    }
  }



}
