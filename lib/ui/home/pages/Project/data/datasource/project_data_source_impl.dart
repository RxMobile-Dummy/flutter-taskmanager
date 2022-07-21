import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/data/datasource/add_note_data_source.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/data/model/add_note_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/domain/usecases/add_note_usecase.dart';
import 'package:task_management/ui/home/pages/Project/data/datasource/project_data_source.dart';
import 'package:task_management/ui/home/pages/Project/data/model/add_project_model.dart';
import 'package:task_management/ui/home/pages/Project/data/model/delete_project_model.dart';
import 'package:task_management/ui/home/pages/Project/data/model/get_all_project_model.dart';
import 'package:task_management/ui/home/pages/Project/data/model/update_project_model.dart';
import 'package:task_management/ui/home/pages/Project/domain/usecases/add_project_usecase.dart';
import 'package:task_management/ui/home/pages/Project/domain/usecases/delete_project_usecase.dart';
import 'package:task_management/ui/home/pages/Project/domain/usecases/get_all_projects_usecase.dart';
import 'package:task_management/ui/home/pages/Project/domain/usecases/update_project_usecase.dart';
import 'package:task_management/ui/home/pages/comment/data/model/delete_comment_model.dart';

import '../../../../../../core/api_call/baseClient.dart';

class ProjectDataSourceImpl implements ProjectDataSource {

  late final ApiClient _apiClient;

  ProjectDataSourceImpl(this._apiClient);

  @override
  Future<AddProjectModel> addProjectCall(AddProjectParams params) async {
    /* Dio dio = new Dio();
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Authorization'] = 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2NTgyMTkzNzMsImVtYWlsIjoibWFuc2hhLmNoYXdsYUByYWRpeHdlYi5jb20iLCJtb2JpbGVfbnVtYmVyIjoiKzkxNzAzMDgyMzU5MiJ9.uCZlfb2iBUstVI-cMkv1i8jpd9ldHKwPRmwGhHMQIb8';
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    var restClient = ApiClient(dio);*/
    var map = new HashMap<String, dynamic>();
    map['color'] = params.color;
    map['name'] = params.name;
    map['description'] = params.description;
    map['duration'] = params.duration;
    map['is_private'] = params.is_private;
    map['archive'] = params.archive;
    final response = await _apiClient.addProject(map);
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
  Future<GetAllProjectsModel> getAllPeojectsCall(GetAllPeojectsParams params) async {
    /* Dio dio = new Dio();
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Authorization'] = 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2NTgyMTkzNzMsImVtYWlsIjoibWFuc2hhLmNoYXdsYUByYWRpeHdlYi5jb20iLCJtb2JpbGVfbnVtYmVyIjoiKzkxNzAzMDgyMzU5MiJ9.uCZlfb2iBUstVI-cMkv1i8jpd9ldHKwPRmwGhHMQIb8';
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    var restClient = ApiClient(dio);*/
    var map = new HashMap<String, dynamic>();
    map['id'] = params.id;
    final response = await _apiClient.getAllPerojects(map);
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
  Future<UpdateProjectModel> updateProjectCall(UpdateProjectParams params) async {
    /* Dio dio = new Dio();
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Authorization'] = 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2NTgyMTkzNzMsImVtYWlsIjoibWFuc2hhLmNoYXdsYUByYWRpeHdlYi5jb20iLCJtb2JpbGVfbnVtYmVyIjoiKzkxNzAzMDgyMzU5MiJ9.uCZlfb2iBUstVI-cMkv1i8jpd9ldHKwPRmwGhHMQIb8';
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    var restClient = ApiClient(dio);*/
    var map = new HashMap<String, dynamic>();
    map['id'] = params.id;
    map['color'] = params.color;
    map['name'] = params.name;
    map['description'] = params.description;
    map['duration'] = params.duration;
    map['is_private'] = params.is_private;
    map['archive'] = params.archive;
    map['status_id'] = params.status_id;
    final response = await _apiClient.updateProject(map);
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
  Future<DeleteProjectModel> deleteProjectCall(DeleteProjectParams params) async {
    /* Dio dio = new Dio();
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Authorization'] = 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2NTgyMTkzNzMsImVtYWlsIjoibWFuc2hhLmNoYXdsYUByYWRpeHdlYi5jb20iLCJtb2JpbGVfbnVtYmVyIjoiKzkxNzAzMDgyMzU5MiJ9.uCZlfb2iBUstVI-cMkv1i8jpd9ldHKwPRmwGhHMQIb8';
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    var restClient = ApiClient(dio);*/
    var map = new HashMap<String, dynamic>();
    map['id'] = params.id;
    final response = await _apiClient.deleteProject(map);
    var data;
    if(response != null ){
      data =response;
      return data;
    }else {
      print('failed');
    }
    return data;
  }



}