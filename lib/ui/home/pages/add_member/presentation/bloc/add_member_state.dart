import 'package:task_management/ui/home/pages/add_member/data/model/add_member_model.dart';

import '../../../../../../core/base/base_bloc.dart';
import '../../data/model/invite_project_assign_model.dart';

class AddMemberState extends BaseState {
  AddMemberModel? model;

  AddMemberState({this.model});
}

class InviteProjectAssignState extends BaseState {
  InviteProjectAssignModel? model;

  InviteProjectAssignState({this.model});
}