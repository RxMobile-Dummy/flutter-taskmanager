import 'dart:collection';

import 'package:task_management/ui/home/fab_menu_option/add_check_list/data/model/add_check_list_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/data/model/delete_check_list_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/data/model/get_check_list_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/data/model/update_check_list_model.dart';

import 'package:task_management/ui/home/fab_menu_option/add_check_list/domain/usecases/add_check_list_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/domain/usecases/delete_check_list_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/domain/usecases/get_check_list_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/domain/usecases/update_check_list_usecase.dart';

import '../../../../../../core/api_call/baseClient.dart';
import 'check_list_data_source.dart';

class AddCheckListDataSourceImpl implements AddCheckListDataSource {

  final ApiClient _apiClient;

  AddCheckListDataSourceImpl(this._apiClient);

  @override
  Future<AddCheckListModel> addCheckListCall(AddCheckListParams params) async {
    var map =  HashMap<String, dynamic>();
    map['title'] = params.title;
    map['options'] = params.options;
    map['color'] = params.color;
    final response = await _apiClient.addCheckList(map);
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
  Future<GetCheckListModel> getCheckListCall(GetCheckListParams params) async{
    final response = await _apiClient.getCheckList();
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
  Future<DeleteCheckListModel> deleteCheckListCall(DeleteCheckListParams params) async {
    var map =  HashMap<String, dynamic>();
    map['id'] = params.id1;
    final response = await _apiClient.deleteCheckList(map);
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
  Future<UpdateCheckListModel> updateCheckListCall(UpdateCheckListParams params) async{
    var map =  HashMap<String, dynamic>();
    map['id'] = params.id1;
    map['is_completed'] = params.is_completed;
    final response = await _apiClient.updateCheckList(map);
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