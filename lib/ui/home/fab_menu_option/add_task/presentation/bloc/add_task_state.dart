

import 'package:task_management/features/login/data/model/forgot_password_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/add_task_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/delete_task_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/update_task.dart';

import '../../../../../../core/base/base_bloc.dart';
import '../../data/model/invite_project_assign_model.dart';



class AddTaskState extends BaseState {
  AddTaskModel? model;

  AddTaskState({this.model});
}


class DeleteTaskState extends BaseState {
  DeleteTaskModel? model;

  DeleteTaskState({this.model});
}

class UpdateTaskState extends BaseState {
  UpdateTaskModel? model;

  UpdateTaskState({this.model});
}

class InviteProjectAssignState extends BaseState {
  InviteProjectAssignModel? model;

  InviteProjectAssignState({this.model});
}


