import 'dart:collection';

import 'package:task_management/ui/home/pages/comment/data/model/add_comment_model.dart';
import 'package:task_management/ui/home/pages/comment/data/model/delete_comment_model.dart';
import 'package:task_management/ui/home/pages/comment/data/model/get_comment_model.dart';
import 'package:task_management/ui/home/pages/comment/data/model/update_comment_model.dart';
import 'package:task_management/ui/home/pages/comment/domain/usecases/add_comment_usecase.dart';
import 'package:task_management/ui/home/pages/comment/domain/usecases/delete_comment_usecase.dart';
import 'package:task_management/ui/home/pages/comment/domain/usecases/get_comment_usecase.dart';
import 'package:task_management/ui/home/pages/comment/domain/usecases/update_comment_usecase.dart';

import '../../../../../../core/api_call/baseClient.dart';
import 'package:dio/dio.dart';


import 'comment_data_source.dart';
import 'package:path/path.dart' as pathManager;

class AddCommentDataSourceImpl implements AddCommentDataSource {
  final ApiClient _apiClient;

  AddCommentDataSourceImpl(this._apiClient);

  @override
  Future<AddCommentModel> addCommentCall(AddCommentParams params) async {
    // Dio dio = new Dio();
    // dio.options.headers['Accept'] = 'application/json';
    // dio.options.headers['Authorization'] = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2NTgyMjM1ODYsImVtYWlsIjoicm9taXNoLnBhdG9yaXlhQHJhZGl4d2ViLmNvbSIsIm1vYmlsZV9udW1iZXIiOiIrOTE2MzU2Nzc4ODk5In0._Nz-z-Rm1U4mvebf3RS01sw6Nu6Kacz99NyoYLeBDhc';
    // dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    // var restClient = ApiClient(dio);
   /* List multipartArray = [];
    for (var i = 0; i < params.files!.length; i++){
      multipartArray.add(MultipartFile.fromFileSync(params.files![i], filename:
      pathManager.basename(params.files![i])));
    }*/
    List<MultipartFile> multipartImageList = [];
    for (var file in params.files!) {
      MultipartFile multipartFile =
      await MultipartFile.fromFile(file, filename: pathManager.basename(file));
      multipartImageList.add(multipartFile);
    }
    var map = new HashMap<String, dynamic>();
    map['comment_user_id'] = params.comment_user_id;
    map['description'] = params.description;
    map['files'] =  multipartImageList;
    FormData formData = new FormData.fromMap(map);
    final response = await _apiClient.addComment(formData);
    var data ;
    if(response != null ){
      data =response;
      return data;
    }else {
      print('failed');
    }
    return data;
  }

  @override
  Future<UpdateCommentModel> updateCommentCall(UpdateCommentParams params) async {
    // Dio dio = new Dio();
    // dio.options.headers['Accept'] = 'application/json';
    // dio.options.headers['Authorization'] = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2NTgyMjM1ODYsImVtYWlsIjoicm9taXNoLnBhdG9yaXlhQHJhZGl4d2ViLmNvbSIsIm1vYmlsZV9udW1iZXIiOiIrOTE2MzU2Nzc4ODk5In0._Nz-z-Rm1U4mvebf3RS01sw6Nu6Kacz99NyoYLeBDhc';
    // dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    // var restClient = ApiClient(dio);
    List<MultipartFile> multipartImageList = [];

    if(params.files!.isNotEmpty) {
      if(!params.files![0].contains("static")) {
        MultipartFile multipartFile =
        await MultipartFile.fromFile(params.files![0], filename: pathManager.basename(params.files![0]));
        multipartImageList.add(multipartFile);
      }
    }
   /* for (var file in params.files!) {
      MultipartFile multipartFile =
      await MultipartFile.fromFile(file, filename: pathManager.basename(file.toString()));
      multipartImageList.add(multipartFile);
    }*/
    var map = new HashMap<String, dynamic>();
    map['id'] = params.id;
    map['comment_user_id'] = params.comment_user_id;
    map['task_id'] = params.task_id;
    map['description'] = params.description;
    map['files'] =  params.files!.isNotEmpty ? multipartImageList : params.files;
    FormData formData = new FormData.fromMap(map);
    final response = await _apiClient.updateComment(formData);
    var data ;
    if(response != null ){
      data =response;
      return data;
    }else {
      print('failed');
    }
    return data;
  }

  @override
  Future<DeleteCommentModel> deleteCommentCall(DeleteCommentParams params)async {
    // Dio dio = new Dio();
    // dio.options.headers['Accept'] = 'application/json';
    // dio.options.headers['Authorization'] = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2NTgyMjM1ODYsImVtYWlsIjoicm9taXNoLnBhdG9yaXlhQHJhZGl4d2ViLmNvbSIsIm1vYmlsZV9udW1iZXIiOiIrOTE2MzU2Nzc4ODk5In0._Nz-z-Rm1U4mvebf3RS01sw6Nu6Kacz99NyoYLeBDhc';
    // dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    // var restClient = ApiClient(dio);
    var map = new HashMap<String, dynamic>();
    map['id'] = params.id;
    map['comment_user_id'] = params.comment_user_id;
    final response = await _apiClient.deleteComment(map);
    var data ;
    if(response != null ){
      data =response;
      return data;
    }else {
      print('failed');
    }
    return data;
  }

  @override
  Future<GetCommentModel> getCommentCall(GetCommentParams params) async {
    // Dio dio = new Dio();
    // dio.options.headers['Accept'] = 'application/json';
    // dio.options.headers['Authorization'] = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2NTgyMjM1ODYsImVtYWlsIjoicm9taXNoLnBhdG9yaXlhQHJhZGl4d2ViLmNvbSIsIm1vYmlsZV9udW1iZXIiOiIrOTE2MzU2Nzc4ODk5In0._Nz-z-Rm1U4mvebf3RS01sw6Nu6Kacz99NyoYLeBDhc';
    // dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    // var restClient = ApiClient(dio);
    var map = new HashMap<String, dynamic>();
    map['comment_user_id'] = params.comment_user_id;
    final response = await _apiClient.getComment(map);
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