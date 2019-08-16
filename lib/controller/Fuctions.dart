import 'dart:convert';
import 'dart:io';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class Fuctions{

  String toTimeStamp(DateTime fecha){
    return (fecha.millisecondsSinceEpoch).toString();
  }

  String toSha256(String data) {
    var content = new Utf8Encoder().convert(data);
    var sha256 = crypto.sha256;
    var digest = sha256.convert(content);
    return hex.encode(digest.bytes);
  }

  String toMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }

  String toBase64(String data){
    return base64.encode(utf8.encode(data));
  }

  String base64ToString(String data){
    return utf8.decode(base64.decode(data));
  }

  verificarConecionInternet() async{
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  verificarCorreo(String email){
    RegExp emailRegExp = new RegExp(r'^\w+[\w-\.]*\@\w+((-\w+)|(\w*))\.[a-z]{2,3}$');
    if(!emailRegExp.hasMatch(email)){
      return false;
    }else{
      return true;
    }

  }

  verificarPassword(String password){
    RegExp contRegExp = new RegExp(r'^([1-zA-Z0-1@.\s]{1,255})$');
    if(!contRegExp.hasMatch(password)){
      return false;
    }else{
      return true;
    }
  }

  Future<String> insertIpPreferences(String ip) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('ip', ip);
  }

  Future<String> getIp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String ip = prefs.getString('ip') ?? null;
    return ip;
  }

  clearIp() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('ip');
    String sesion =prefs.getString('ip') ?? null;
    return sesion;
  }

  formatTimeString(TimeOfDay time){
    String Time='';
    if(time.hour<10){
      Time=Time+'0${time.hour}:';
    }else{
      Time=Time+'${time.hour}:';
    }
    if(time.minute<10){
      Time=Time+'0${time.minute}:';
    }else{
      Time=Time+'${time.minute}:';
    }
    Time=Time+'00';
    return Time;
  }
  formatTimeHourMinuteString(TimeOfDay time){
    String Time='';
    if(time.hour<10){
      Time=Time+'0${time.hour}:';
    }else{
      Time=Time+'${time.hour}:';
    }
    if(time.minute<10){
      Time=Time+'0${time.minute}';
    }else{
      Time=Time+'${time.minute}';
    }
    Time=Time+' h';
    return Time;
  }
  formatTimeOfDay(String time){
    var timeData=time.split(':');
    TimeOfDay Time=TimeOfDay(hour: int.parse(timeData[0]), minute: int.parse(timeData[1]));
    return Time;
  }
  formatDateString(DateTime date){
    return  DateFormat('yyyy-MM-dd').format(date);
  }

}


