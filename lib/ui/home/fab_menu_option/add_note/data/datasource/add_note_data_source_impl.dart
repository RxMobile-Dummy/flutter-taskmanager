import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/data/datasource/add_note_data_source.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/data/model/add_note_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/domain/usecases/add_note_usecase.dart';

import '../../../../../../core/api_call/baseClient.dart';

class AddNotesDataSourceImpl implements AddNoteDataSource {

  final ApiClient _apiClient;

  AddNotesDataSourceImpl(this._apiClient);


  @override
  Future<AddNotesModel> addNotesCall(AddNotesParams params) async {
   /* Dio dio = new Dio();
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Authorization'] = 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2NTgyMTkzNzMsImVtYWlsIjoibWFuc2hhLmNoYXdsYUByYWRpeHdlYi5jb20iLCJtb2JpbGVfbnVtYmVyIjoiKzkxNzAzMDgyMzU5MiJ9.uCZlfb2iBUstVI-cMkv1i8jpd9ldHKwPRmwGhHMQIb8';
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    var restClient = ApiClient(dio);*/
    var map = new HashMap<String, String>();
    map['project_id'] = params.project_id;
    map['task_id'] = params.task_id;
    map['title'] = params.title;
    map['description'] = params.description;
    final response = await _apiClient.addNote(map);
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