import 'dart:collection';
import 'package:task_management/ui/home/fab_menu_option/add_note/data/datasource/add_note_data_source.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/data/model/add_note_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/data/model/delete_note_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/data/model/get_note_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/data/model/update_note_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/domain/usecases/add_note_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/domain/usecases/delete_note_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/domain/usecases/get_note_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/domain/usecases/update_note_usecase.dart';
import '../../../../../../core/api_call/baseClient.dart';

class AddNotesDataSourceImpl implements AddNoteDataSource {

  final ApiClient _apiClient;

  AddNotesDataSourceImpl(this._apiClient);


  @override
  Future<AddNotesModel> addNotesCall(AddNotesParams params) async {
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

  @override
  Future<GetNoteModel> getNotesCall(GetNotesParams params) async {
    final response = await _apiClient.getNote();
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
  Future<UpdateNoteModel> updateNotesCall(UpdateNoteParams params) async{
    var map = new HashMap<String, dynamic>();
    map['id'] = params.id;
    map['title'] = params.title;
    map['description'] = params.description;
    final response = await _apiClient.updateNote(map);
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
  Future<DeleteNoteModel> deleteNotesCall(DeleteNoteParams params) async {
    var map = new HashMap<String, dynamic>();
    map['id'] = params.id;
    final response = await _apiClient.deleteNote(map);
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