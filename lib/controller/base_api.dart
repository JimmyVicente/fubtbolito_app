import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BaseApi {
  static BaseApi _instance = new BaseApi.internal();

  BaseApi.internal();

  factory BaseApi() => _instance;

  final JsonDecoder _decoder = new JsonDecoder();

  Future<dynamic> get(String url) {
    return http.get(url).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("ERROR> $res code $statusCode");
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> post(String url, {Map headers, body, encoding}) {
    return http
        .post(url, body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("ERROR> $res code $statusCode");
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> put(String url, {Map headers, body, encoding}) {
    return http
        .put(url, body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("ERROR> $res code $statusCode");
      }
      return _decoder.convert(res);
    });
  }

}
