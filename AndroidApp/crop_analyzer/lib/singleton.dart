import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';

class Singleton {
  static Singleton _instance = new Singleton._();
  static PersistCookieJar cookieJar;
  Dio dio;

  Singleton._() {
    dio = new Dio();
    dio.options = new BaseOptions(
      responseType: ResponseType.json,
      connectTimeout: 5000,
      receiveTimeout: 100000,
      headers: {
        HttpHeaders.userAgentHeader: "dio",
      },
    );
    if(cookieJar != null) {
      dio.interceptors.add(CookieManager(cookieJar));
    }
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions requestOptions) {
        print("Network request");
        print(requestOptions.uri);
        print(requestOptions.data.toString());
        print(cookieJar?.loadForRequest(requestOptions.uri));
        requestOptions.headers[HttpHeaders.cookieHeader] = cookieJar?.loadForRequest(requestOptions.uri);
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

  static Future<String> getDirectory() async {
    Directory tempDir = await getTemporaryDirectory();
    return tempDir.path;
  }

  static Singleton get instance => _instance;
  static Future initialize() async {
    String tempPath = await getDirectory();
    cookieJar = PersistCookieJar(dir: tempPath);
    print('initialized cookie jar');
  } 
}
