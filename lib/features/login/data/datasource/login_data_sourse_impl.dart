import 'dart:collection';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:task_management/features/login/data/model/forgot_password_model.dart';
import 'package:task_management/features/login/data/model/get_user_role_model.dart';
import 'package:task_management/features/login/data/model/login_model.dart';
import 'package:task_management/features/login/data/model/reset_passward_model.dart';
import 'package:task_management/features/login/data/model/sign_up_model.dart';
import 'package:task_management/features/login/domain/usecases/forgot_password_uasecase.dart';
import 'package:task_management/features/login/domain/usecases/get_user_role_usecase.dart';
import 'package:task_management/features/login/domain/usecases/reset_passward_usecase.dart';
import 'package:task_management/features/login/domain/usecases/sign_up_usecase.dart';
import '../../../../core/api_call/baseClient.dart';
import '../../domain/usecases/login.dart';
import 'login_data_sourse.dart';

class LocalDataSourceImpl implements LocalDataSource {
  final ApiClient _apiClient;

  LocalDataSourceImpl(this._apiClient);
   //ApiClient? _apiClient;

  @override
  Future<LoginModel> loginCall(LoginParams params) async {
   /* Dio dio = new Dio();
    dio.options.headers['Accept'] = 'application/json';
   // dio.options.headers['Authorization'] = 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2NTgyMTkzNzMsImVtYWlsIjoibWFuc2hhLmNoYXdsYUByYWRpeHdlYi5jb20iLCJtb2JpbGVfbnVtYmVyIjoiKzkxNzAzMDgyMzU5MiJ9.uCZlfb2iBUstVI-cMkv1i8jpd9ldHKwPRmwGhHMQIb8';
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    var restClient = ApiClient(dio);*/
    var map = new HashMap<String, String>();
    map['email'] = params.email;
    map['password'] = params.password;
    final response = await _apiClient.login(map);
    var data ;
    if(response != null ){
      data = response;
     // print(data['token']);
      return data;
      print('Login successfully');
    }else {
      print('failed');
    }
    return data;
  }

  @override
  Future<ForgotPasswordModel> forgotPasswordCall(ForgotPasswardParams params) async {
    var map = new HashMap<String, String>();
    map['email'] = params.email;
    final response = await _apiClient.forgotPassward(map);
    var data;
    if(response != null ){
      data =response;
      return data;
    }else {
      print('failed');
    }
    return data;
  }

  @override
  Future<ResetPasswardModel> resetPasswordCall(ResetPasswardParams params) async {
   /* Dio dio = new Dio();
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Authorization'] = 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2NTc4ODMwOTgsImVtYWlsIjoibWFuc2hhLmNoYXdsYUByYWRpeHdlYi5jb20iLCJtb2JpbGVfbnVtYmVyIjoiKzkxNzAzMDgyMzU5MiJ9.cRHAAuz7ys0mp_ThHzN0_iFC1b-Jbz0B0t6HoylI35o';
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    var restClient = ApiClient(dio);*/
    var map = new HashMap<String, String>();
    map['password'] = params.password;
    map['email'] = params.email;
    final response = await _apiClient.resetPassward(map);
    var data;
    if(response != null ){
      data =response;
      return data;
    }else {
      print('failed');
    }
    return data;
  }

  @override
  Future<SignUpModel> signUpCall(SignUpParams params) async {
    /* Dio dio = new Dio();
    dio.options.headers['Accept'] = 'application/json';
   // dio.options.headers['Authorization'] = 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2NTgyMTkzNzMsImVtYWlsIjoibWFuc2hhLmNoYXdsYUByYWRpeHdlYi5jb20iLCJtb2JpbGVfbnVtYmVyIjoiKzkxNzAzMDgyMzU5MiJ9.uCZlfb2iBUstVI-cMkv1i8jpd9ldHKwPRmwGhHMQIb8';
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    var restClient = ApiClient(dio);*/
    var map = new HashMap<String, String>();
    map['first_name'] = params.firstName;
    map['last_name'] = params.lastName;
    map['email'] = params.email;
    map['mobile_number'] = params.mobile;
    map['password'] = params.password;
    map['role'] = params.role;
    final response = await _apiClient.signUp(map);
    var data ;
    if(response != null ){
      data = response;
      // print(data['token']);
      return data;
      print('Login successfully');
    }else {
      print('failed');
    }
    return data;
  }

  @override
  Future<GetUserRoleModel> getUserRoleCall(GetUserRoleParams params) async {
    /* Dio dio = new Dio();
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Authorization'] = 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2NTc4ODMwOTgsImVtYWlsIjoibWFuc2hhLmNoYXdsYUByYWRpeHdlYi5jb20iLCJtb2JpbGVfbnVtYmVyIjoiKzkxNzAzMDgyMzU5MiJ9.cRHAAuz7ys0mp_ThHzN0_iFC1b-Jbz0B0t6HoylI35o';
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    var restClient = ApiClient(dio);*/
    final response = await _apiClient.getUserRole();
    var data ;
    if(response != null ){
      data =response;
      return data;
    }else {
      print('failed');
    }
    return data;
  }
  



}
