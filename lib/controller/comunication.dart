import 'dart:io';

class Comunication{
  static String ip= '192.168.0.15:8000';
  static String ip_conexion= "http://"+ip+ "/api";

  static final Map<String, String> headersPost = {
    "content-type": "application/json",
    "accept": "application/json",
    HttpHeaders.authorizationHeader: "Basic amx2aWNlbnRlOjE1MjM="
  };

  static final Map<String, String> headersGet = {
    "Content-Type": "application/json",
    "Vary": "Accept",
  };

}