
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/core/api_call/baseClient.dart';
import 'package:task_management/features/login/data/model/refresh_token_model.dart';


Future<RefreshTokenModel> refreshTokenCall() async {
   Dio dio = new Dio();
   SharedPreferences prefs = await SharedPreferences.getInstance();
   var authToken = prefs.getString('refresh');
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Authorization'] = 'Bearer $authToken';
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    var restClient = ApiClient(dio);
  final response = await restClient.refreshToken();
  var data;
  if(response != null ){
    data = response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("access");
    prefs.setString("access", data.access);
    return data;
  }else {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    print('failed');
  }
  return data;
}
