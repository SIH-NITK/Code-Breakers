import 'dart:io';

import 'package:dio/dio.dart';

class Singleton {
  static Singleton _instance = new Singleton._();
  Dio dio;

  Singleton._() {
    dio = new Dio();
    dio.options = new BaseOptions(
      responseType: ResponseType.json,
      connectTimeout: 5000,
      receiveTimeout: 100000,
      headers: {
        HttpHeaders.userAgentHeader: "dio",
        HttpHeaders.contentTypeHeader: "application/json"
      },
    );
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions requestOptions) {
        print("Network request");
        print(requestOptions.uri);
        print(requestOptions.data.toString());
        print(requestOptions.headers);
      },  
      onResponse: (Response response) {
        print("Network response received");
        print(response.data.toString());
      },
      onError: (DioError error) {
        print("Network response error");
        print("Type : " + error.type.toString());
        print("URL : " + error.request.uri.toString());
        print("Method : " + error.request.method);
        print(error.response?.statusCode);
      }
    ));
  }

  static Singleton get instance => _instance; 
}
