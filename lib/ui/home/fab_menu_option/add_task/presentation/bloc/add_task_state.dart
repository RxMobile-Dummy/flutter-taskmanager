
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/add_task_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/delete_task_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/get_task_model.dart';

import '../../../../../../core/base/base_bloc.dart';



class AddTaskState extends BaseState {
  AddTaskModel? model;

  AddTaskState({this.model});
}

class GetTaskState extends BaseState {
  GetTaskModel? model;

  GetTaskState({this.model});
}


class DeleteTaskState extends BaseState {
  DeleteTaskModel? model;

  DeleteTaskState({this.model});
}

class UpdateTaskState extends BaseState {
  AddTaskModel? model;

  UpdateTaskState({this.model});
}


