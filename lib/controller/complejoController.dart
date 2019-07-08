import 'dart:convert';
import 'package:futbolito_app/controller/Fuctions.dart';
import 'package:futbolito_app/controller/base_api.dart';
import 'package:futbolito_app/controller/comunication.dart';

class complejoController extends Fuctions{

  BaseApi _baseApi = new BaseApi();

  static final url= Comunication.IP_CONEXION+'/complejos';

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

  Future<dynamic> getCompeljos() async {
    var coneccionInternet = await verificarConecionInternet();
    if(coneccionInternet){
      final response = await _baseApi.get(url);
      if (response['count']!=0) {
        return response['results'];
      } else {
        return null;
      }
    }else{
      String data= '[{"nombre_complejo":"-1"}]';
      return json.decode(data);
    }
  }

}