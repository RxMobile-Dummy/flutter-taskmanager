import 'package:task_management/ui/home/pages/add_member/data/model/add_member_model.dart';

import '../../../../../../core/base/base_bloc.dart';
import '../../data/model/invite_project_assign_model.dart';

class AddMemberEvent extends BaseEvent {
  AddMemberEvent();
}

class AddMemberSuccessEvent extends BaseEvent {
  AddMemberModel? model;

  AddMemberSuccessEvent({this.model});
}

class InviteProjectAssignEvent extends BaseEvent {
  String project_id;
  String assignee_ids;
  InviteProjectAssignEvent({required this.project_id,required this.assignee_ids});
}

class InviteProjectAssignSuccessEvent extends BaseEvent {
  InviteProjectAssignModel? model;

  InviteProjectAssignSuccessEvent({this.model});
}