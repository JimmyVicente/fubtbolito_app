import 'dart:convert';
import 'dart:io';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart' as crypto;

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

}


