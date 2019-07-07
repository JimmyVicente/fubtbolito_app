import 'dart:convert';
import 'dart:io';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart' as crypto;

class Extensions{

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

  conecionInternet() async{
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

}


