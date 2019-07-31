import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:convert' show utf8;

class BaseApi {
  static BaseApi _instance = new BaseApi.internal();

  BaseApi.internal();

  factory BaseApi() => _instance;

  final JsonDecoder _decoder = new JsonDecoder();

  Future<dynamic> get(String url, Map headers) {
    return http.get(url).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        print('error');
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> post(String url, Map headers, body) {
    return http
        .post(url, body: body, headers: headers)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("ERROR> $res code $statusCode");
      }
      return _decoder.convert(res);
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
      return _decoder.convert(res);
    });
  }

}
