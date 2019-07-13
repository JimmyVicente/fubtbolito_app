import 'dart:convert';
import 'package:futbolito_app/controller/base_api.dart';
import 'package:futbolito_app/controller/comunication.dart';
import 'package:futbolito_app/controller/Fuctions.dart';

class reservaController {

  BaseApi _baseApi = new BaseApi();

  static String Url= Comunication.IP_CONEXION+'/reservas/';

  static final Map<String, String> headers = {
    "content-type": "application/json",
    "accept": "application/json",
  };


  Future<dynamic> getReservas() async {
    var coneccionInternet = await Fuctions().verificarConecionInternet();
    if(coneccionInternet){
      final response = await _baseApi.get(Url);
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



}
