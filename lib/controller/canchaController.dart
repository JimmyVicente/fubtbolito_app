import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:futbolito_app/controller/base_api.dart';
import 'package:futbolito_app/controller/comunication.dart';

class canchaController {

  BaseApi _baseApi = new BaseApi();

  static final url= Comunication.IP_CONEXION+'/canchas/?complejo=';
  static final headerGet= Comunication.headersGet;


  Future<List> getCanchas(String idComplejo) async {
    final res = await _baseApi.get(url+idComplejo, headerGet);
    final response = res['results'];
    if (res['count'] != 0) {
      return response;
    } else {
      return null;
    }
  }

  Future<DateTime> selectDate(BuildContext context, DateTime selectedDate) async {
    final DateTime date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
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
    return date;
  }

  Future<TimeOfDay> selectTime(BuildContext context, TimeOfDay selectedTime) async {
    final TimeOfDay Time = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.fallback(),
          child: child,
        );
      },
    );
    return Time;
  }



}