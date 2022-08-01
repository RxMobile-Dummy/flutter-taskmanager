import 'dart:collection';

import 'package:task_management/ui/home/pages/comment/data/model/add_comment_model.dart';
import 'package:task_management/ui/home/pages/comment/data/model/delete_comment_model.dart';
import 'package:task_management/ui/home/pages/comment/data/model/get_comment_model.dart';
import 'package:task_management/ui/home/pages/comment/data/model/update_comment_model.dart';
import 'package:task_management/ui/home/pages/comment/domain/usecases/add_comment_usecase.dart';
import 'package:task_management/ui/home/pages/comment/domain/usecases/delete_comment_usecase.dart';
import 'package:task_management/ui/home/pages/comment/domain/usecases/get_comment_usecase.dart';
import 'package:task_management/ui/home/pages/comment/domain/usecases/update_comment_usecase.dart';
import 'package:task_management/ui/home/pages/user_status/data/datasource/user_status_data_source.dart';
import 'package:task_management/ui/home/pages/user_status/data/model/get_user_status_model.dart';
import 'package:task_management/ui/home/pages/user_status/domain/usecases/get_user_status_usecase.dart';

import '../../../../../../core/api_call/baseClient.dart';


class UserStatusDataSourceImpl implements UserStatusDataSource {
  final ApiClient _apiClient;

  UserStatusDataSourceImpl(this._apiClient);

  @override
  Future<GetUserStatusModel> getUserStatusCall(GetUserStatusParams params) async {
    final response = await _apiClient.getUserStatus();
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