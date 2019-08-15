import 'dart:io';

class Comunication{
  static String ip= '10.20.57.153:8000';
  static String ip_conexion= "http://"+ip+ "/api";

  static final Map<String, String> headersPost = {
    "content-type": "application/json",
    "accept": "application/json",
    HttpHeaders.authorizationHeader: "Basic QWxiZXJ0OmFsYmVydDEyMw=="
  };

  static final Map<String, String> headersGet = {
    "Content-Type": "application/json",
    "Vary": "Accept",
  };

}