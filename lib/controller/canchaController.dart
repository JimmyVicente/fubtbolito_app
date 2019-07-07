import 'dart:convert';
import 'package:futbolito_app/pages/data/base_api.dart';
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

}