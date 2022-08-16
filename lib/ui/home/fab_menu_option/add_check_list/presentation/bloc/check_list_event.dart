import 'package:task_management/ui/home/fab_menu_option/add_check_list/data/model/add_check_list_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/data/model/delete_check_list_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/data/model/get_check_list_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/data/model/update_check_list_model.dart';

import '../../../../../../core/base/base_bloc.dart';

class AddCheckListEvent extends BaseEvent {
  String title;
  List<String> options;
  String? color;
  AddCheckListEvent({required this.options,required this.title,required this.color});
}

class GetCheckListEvent extends BaseEvent {

  GetCheckListEvent();
}

class DeleteCheckListEvent extends BaseEvent {
String id;
DeleteCheckListEvent({required this.id});
}

class UpdateCheckListEvent extends BaseEvent {
  int id;
  String is_completed;
  UpdateCheckListEvent({required this.id, required this.is_completed});
}


class AddCheckListSuccessEvent extends BaseEvent {
  AddCheckListModel? model;

  AddCheckListSuccessEvent({this.model});
}

class GetCheckListSuccessEvent extends BaseEvent {
  GetCheckListModel? model;

  GetCheckListSuccessEvent({this.model});
}

class DeleteCheckListSuccessEvent extends BaseEvent {
  DeleteCheckListModel? model;

  DeleteCheckListSuccessEvent({this.model});
}

class UpdateCheckListSuccessEvent extends BaseEvent {
  UpdateCheckListModel? model;

  UpdateCheckListSuccessEvent({this.model});
}