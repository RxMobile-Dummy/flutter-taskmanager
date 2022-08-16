import 'package:task_management/ui/home/fab_menu_option/add_check_list/data/model/add_check_list_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/data/model/delete_check_list_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/data/model/get_check_list_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/data/model/update_check_list_model.dart';

import '../../../../../../core/base/base_bloc.dart';

class AddCheckListState extends BaseState {
  AddCheckListModel? model;

  AddCheckListState({this.model});
}

class GetCheckListState extends BaseState {
  GetCheckListModel? model;

  GetCheckListState({this.model});
}

class DeleteCheckListState extends BaseState {
  DeleteCheckListModel? model;

  DeleteCheckListState({this.model});
}

class UpdateCheckListState extends BaseState {
  UpdateCheckListModel? model;

  UpdateCheckListState({this.model});
}