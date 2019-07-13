import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futbolito_app/controller/base_api.dart';
import 'package:futbolito_app/controller/comunication.dart';

class canchaController {

  BaseApi _baseApi = new BaseApi();

  static final url= Comunication.IP_CONEXION+'/canchas/?complejo=';

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

  Future<List> getCanchas(String idComplejo) async {
    final res = await _baseApi.get(url+idComplejo);
    final response = res['results'];
    if (res['count'] != 0) {
      return response;
    } else {
      return null;
    }
  }

  Future<DateTime> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      locale: Locale('es'),
      firstDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
      lastDate: DateTime(DateTime.now().year+3),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.fallback(),
          child: child,
        );
      },
    );
    return picked;
  }

}