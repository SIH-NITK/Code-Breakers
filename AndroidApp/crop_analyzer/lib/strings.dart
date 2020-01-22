const String domain = '192.168.43.194:8080';
const String urlPost = '/main/app_home';
const String urlImage = '/static/images/Clipped_NDVI/';

Uri getUri(String endpoint, [Map<String,String> queryParameters]){
  return Uri.http(domain, endpoint, queryParameters);
}