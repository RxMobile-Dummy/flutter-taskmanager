import 'dart:collection';

import 'package:task_management/ui/home/pages/add_member/data/model/add_member_model.dart';

import 'package:task_management/ui/home/pages/add_member/domain/usecases/add_member_usecase.dart';

import '../../../../../../core/api_call/baseClient.dart';
import '../../domain/usecases/invite_project_assign_usecase.dart';
import '../model/invite_project_assign_model.dart';
import 'add_member_data_source.dart';

class AddMemberDataSourceImpl implements AddMemberDataSource {
  final ApiClient _apiClient;

  AddMemberDataSourceImpl(this._apiClient);

  @override
  Future<AddMemberModel> addMemberCall(AddMemberParams params) async {
    final response = await _apiClient.getAllUser();
    var data;
    if (response != null) {
      data = response;
      return data;
    } else {
      print('failed');
    }
    return data;
  }

  @override
  Future<InviteProjectAssignModel> inviteProjectAssignCall(
      InviteProjectAssignParams params) async {
    var map = new HashMap<String, String>();
    map['project_id'] = params.project_id;
    map['assignee_ids'] = params.assignee_ids;
    final response = await _apiClient.inviteProjectAssign(map);
    var data;
    if (response != null) {
      data = response;
      return data;
    } else {
      print('failed');
    }
    return data;
  }

}