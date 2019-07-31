import 'dart:io';
import 'package:flutter/material.dart';

class Comunication{
  static String IP= '10.20.5.237';
  static String IP_CONEXION= "http://"+IP+ "/api";

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