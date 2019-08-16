import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/time.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:futbolito_app/controller/base_api.dart';
import 'package:futbolito_app/controller/comunication.dart';
import 'package:futbolito_app/controller/Fuctions.dart';
import 'package:futbolito_app/model/user.dart';
import 'package:futbolito_app/ui/globales/Alerts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class reservaController {

  BaseApi _baseApi = new BaseApi();

  static String Url= Comunication.ip_conexion+'/reservas/';
  final headersPost = Comunication.headersPost;
  final headerGet = Comunication.headersGet;


  Future<dynamic> getReservaUser() async {
    var coneccionInternet = await Fuctions().verificarConecionInternet();
    if(coneccionInternet){
      final resReservas = await _baseApi.get(Url+'?usuario=${User.id}&estado=1', headerGet);
      List reservas=[];
      if (resReservas['count']!=0) {
        for(int i =0; i<resReservas['results'].length; i++){
          var urlCancha=Comunication.ip_conexion+"/canchas/${resReservas['results'][i]['cancha']}/";
          final resCancha = await _baseApi.get(urlCancha, headerGet);
          final resComplejo = await _baseApi.get(resCancha['complejo'], headerGet);
          reservas.add({
            "usuario":resReservas['results'][i]['usuario'],
            "cancha":resCancha,
            "complejo":resComplejo,
            "fecha_reserva":resReservas['results'][i]['fecha_reserva'],
            "hora_inicio":resReservas['results'][i]['hora_inicio'],
            "hora_fin":resReservas['results'][i]['hora_fin'],
            "valor_unitario":resReservas['results'][i]['valor_unitario'],
            "valor_total":resReservas['results'][i]['valor_total'],
            "fecha_creacion":resReservas['results'][i]['fecha_creacion'],
            "estado_reserva":resReservas['results'][i]['estado_reserva'],
          });
        }
        return reservas;
      } else {
        String data= '[{"usuario":"-2"}]';
        return json.decode(data);
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

  Future<dynamic> getReservaIdCancha(int idCancha) async {
    List reservas = await getReserva();
    List resCancha=[];
    if(reservas!=null){
      for(int i=0; i<reservas.length; i++){
        if(reservas[i]['estado_reserva']==true){
          if(reservas[i]['cancha']==idCancha){
            resCancha.add(reservas[i]);
          }
        }
      }
      return resCancha;
    }else{
      return null;
    }
  }

  Future<bool> validarReserva(int idCancha, DateTime date, TimeOfDay startTime, TimeOfDay endTime) async {
    //horas
    String DateStr= Fuctions().formatDateString(date);
    String startTimeStr= Fuctions().formatTimeString(startTime);
    String endTimeStr=Fuctions().formatTimeString(endTime);
    bool returnValidate=true;
    final resCancha = await _baseApi.get(Url+"?cancha=${idCancha}&fecha=${DateStr}", headerGet);
    if(resCancha['count']!=0){
      for(int i=0; i<resCancha['results'].length; i++){
        TimeOfDay hora_fin= Fuctions().formatTimeOfDay(resCancha['results'][i]['hora_fin']);
        if(resCancha['results'][i]['hora_inicio']== startTimeStr&& resCancha['results'][i]['hora_fin']==endTimeStr){
          AlertWidget().showToastError("Horario no disponible para esta cancha");
          returnValidate= false;
        }else if(startTime.hour<=hora_fin.hour){
          if(startTime.hour>=hora_fin.hour && startTime.minute>=hora_fin.minute){
            returnValidate= true;
          }else{
            AlertWidget().showToastError("Horario no disponible para esta cancha");
            returnValidate= false;
          }
        }else{
          returnValidate= true;
        }
      }
    }else{
      returnValidate= true;
    }

    return returnValidate;



//
//
//    if(resCancha.length!=0){
//      for(int i=0; i<resCancha.length; i++){
//        TimeOfDay hora_inicio= Fuctions().formatTimeOfDay(resCancha[i]['hora_inicio']);
//        if(resCancha[i]['fecha_reserva']==DateStr && resCancha[i]['hora_inicio']== startTimeStr&& resCancha[i]['hora_fin']==endTimeStr){
//          AlertWidget().showToastError("Horario no disponible para esta cancha");
//        }else if(resCancha[i]['fecha_reserva']==DateStr &&hora_inicio.hour==startTime.hour){
//          AlertWidget().showToastError("Horario no disponible para esta cancha");
//        }else{
//          return true;
//        }
//      }
//    }else{
//      return true;
//    }

  }




  Future<dynamic> postReserva(int idCancha, DateTime date,TimeOfDay startTime, TimeOfDay endTime, double valorU, double valorT) async {
    var parameters= json.encode({
      "usuario": User.id,
      "cancha": idCancha,
      "fecha_reserva": Fuctions().formatDateString(date),
      "hora_inicio":  Fuctions().formatTimeString(startTime),
      "hora_fin":  Fuctions().formatTimeString(endTime),
      "valor_unitario": valorU,
      "valor_total": valorT,
      "estado_reserva": true
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
