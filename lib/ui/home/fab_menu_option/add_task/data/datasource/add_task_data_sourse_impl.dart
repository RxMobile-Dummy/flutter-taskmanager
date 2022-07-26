import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/datasource/add_task_data_sourse.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/add_task_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/delete_task_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/get_task_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/invite_project_assign_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/update_task.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/domain/usecases/add_task_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/domain/usecases/delete_task_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/domain/usecases/get_task_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/domain/usecases/invite_project_assign_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/domain/usecases/update_task_usecase.dart';

import '../../../../../../core/api_call/baseClient.dart';
import 'package:dio/adapter.dart';

class AddTaskDataSourceImpl implements AddTaskDataSource {
  final ApiClient _apiClient;

  AddTaskDataSourceImpl(this._apiClient);

  @override
  Future<AddTaskModel> addTaskCall(AddTaskParams params) async {
   /* Dio dio = new Dio();
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Authorization'] = 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2NTgyMjM1ODYsImVtYWlsIjoicm9taXNoLnBhdG9yaXlhQHJhZGl4d2ViLmNvbSIsIm1vYmlsZV9udW1iZXIiOiIrOTE2MzU2Nzc4ODk5In0._Nz-z-Rm1U4mvebf3RS01sw6Nu6Kacz99NyoYLeBDhc';
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    var restClient = ApiClient(dio);*/
    var map = new HashMap<String, String>();
    map['project_id'] = params.project_id;
    map['name'] = params.name;
    map['comment'] = params.comment;
    map['task_status'] = params.task_status;
    map['description'] = params.description;
    map['is_private'] = params.is_private;
    map['priority'] = params.priority;
    map['assignee_id'] = params.assignee_id;
    map['reviewer_id'] = params.reviewer_id;
    map['tag_id'] = params.tag_id;
    map['start_date'] = params.start_date;
    map['end_date'] = params.end_date;
    final response = await _apiClient.addTask(map);
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
  Future<DeleteTaskModel> deleteTaskCall(DeleteTaskParams params) async {
    // Dio dio = new Dio();
    // dio.options.headers['Accept'] = 'application/json';
    // dio.options.headers['Authorization'] = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2NTgyMjM1ODYsImVtYWlsIjoicm9taXNoLnBhdG9yaXlhQHJhZGl4d2ViLmNvbSIsIm1vYmlsZV9udW1iZXIiOiIrOTE2MzU2Nzc4ODk5In0._Nz-z-Rm1U4mvebf3RS01sw6Nu6Kacz99NyoYLeBDhc';
    // dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    // var restClient = ApiClient(dio);
    var map = new HashMap<String, dynamic>();
    map['id'] = params.id1;
    final response = await _apiClient.deleteTask(map);
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
  Future<AddTaskModel> updateTaskCall(UpdateTaskParams params) async {
    /*Dio dio = new Dio();
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Authorization'] = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2NTgyMjM1ODYsImVtYWlsIjoicm9taXNoLnBhdG9yaXlhQHJhZGl4d2ViLmNvbSIsIm1vYmlsZV9udW1iZXIiOiIrOTE2MzU2Nzc4ODk5In0._Nz-z-Rm1U4mvebf3RS01sw6Nu6Kacz99NyoYLeBDhc';
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    var restClient = ApiClient(dio);*/
    var map =  HashMap<String, dynamic>();
    map['id']= params.id;
    map['project_id'] = params.project_id;
    map['name'] = params.name;
    map['comment'] = params.comment;
    map['task_status'] = params.task_status;
    map['description'] = params.description;
    map['is_private'] = params.is_private;
    map['priority'] = params.priority;
    map['assignee_id'] = params.assignee_id;
    map['reviewer_id'] = params.reviewer_id;
    map['tag_id'] = params.tag_id;
    map['start_date'] = params.start_date;
    map['end_date'] = params.end_date;
    final response = await _apiClient.updateTask(map);
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
  Future<InviteProjectAssignModel> inviteProjectAssignCall(InviteProjectAssignParams params) async {
    // Dio dio = new Dio();
    // dio.options.headers['Accept'] = 'application/json';
    // dio.options.headers['Authorization'] = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2NTgyMjM1ODYsImVtYWlsIjoicm9taXNoLnBhdG9yaXlhQHJhZGl4d2ViLmNvbSIsIm1vYmlsZV9udW1iZXIiOiIrOTE2MzU2Nzc4ODk5In0._Nz-z-Rm1U4mvebf3RS01sw6Nu6Kacz99NyoYLeBDhc';
    // dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    // var restClient = ApiClient(dio);
    var map = new HashMap<String, String>();
    map['project_id'] = params.project_id;
    map['assignee_ids'] = params.assignee_ids;
    final response = await _apiClient.inviteProjectAssign(map);
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
  Future<GetTaskModel> getTaskCall(GetTaskParams params) async {
    // Dio dio = new Dio();
    // dio.options.headers['Accept'] = 'application/json';
    // dio.options.headers['Authorization'] = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2NTgyMjM1ODYsImVtYWlsIjoicm9taXNoLnBhdG9yaXlhQHJhZGl4d2ViLmNvbSIsIm1vYmlsZV9udW1iZXIiOiIrOTE2MzU2Nzc4ODk5In0._Nz-z-Rm1U4mvebf3RS01sw6Nu6Kacz99NyoYLeBDhc';
    // dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    // var restClient = ApiClient(dio);
    var map = HashMap<String, dynamic>();
    map['date'] = params.date;
    final response = await _apiClient.getTask(map);
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