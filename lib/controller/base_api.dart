import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BaseApi {
  static BaseApi _instance = new BaseApi.internal();

  BaseApi.internal();

  factory BaseApi() => _instance;


  Future<dynamic> get(String url, Map headers) {
    return http.get(url, headers: headers).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        return false;
      }
      String source = Utf8Decoder().convert(response.bodyBytes);
      return json.decode(source);
    });
  }

  Future<dynamic> post(String url, Map headers, String body) {
    return http
        .post(url, body: body, headers: headers)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("ERROR> $res code $statusCode");
      }
      String source = Utf8Decoder().convert(response.bodyBytes);
      return json.decode(source);
    });
  }

  Future<dynamic> put(String url, Map headers, body) {
    return http
        .put(url, body: body, headers: headers)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("ERROR> $res code $statusCode");
      }
      String source = Utf8Decoder().convert(response.bodyBytes);
      return json.decode(source);
    });
  }

}
