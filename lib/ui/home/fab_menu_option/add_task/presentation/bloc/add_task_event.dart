
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/delete_task_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/get_task_model.dart';
import '../../../../../../core/base/base_bloc.dart';
import '../../data/model/add_task_model.dart';

class AddTaskEvent extends BaseEvent {
  String project_id;
  String name;
  String comment;
  String task_status;
  String description;
  String is_private;
  String priority;
  String assignee_id;
  String reviewer_id;
  String tag_id;
  String start_date;
  String end_date;

  AddTaskEvent({
    required this.task_status,
    required this.tag_id,
    required this.reviewer_id,
    required this.priority,
    required this.is_private,
    required this.comment,
    required this.assignee_id,
    required this.start_date,
    required this.description,
    required this.end_date,
    required this.name,
    required this.project_id,
});
}

class UpdateTaskEvent extends BaseEvent {
  int id;
  String project_id;
  String name;
  String comment;
  String task_status;
  String description;
  String is_private;
  String priority;
  String assignee_id;
  String reviewer_id;
  String tag_id;
  String start_date;
  String end_date;
  bool isCompleted;

  UpdateTaskEvent({
    required this.id,
    required this.task_status,
    required this.tag_id,
    required this.reviewer_id,
    required this.priority,
    required this.is_private,
    required this.comment,
    required this.assignee_id,
    required this.start_date,
    required this.description,
    required this.end_date,
    required this.name,
    required this.project_id,
    required this.isCompleted,
  });
}

class DeleteTaskEvent extends BaseEvent {
  int id;
DeleteTaskEvent({required this.id});
}

class GetTaskEvent extends BaseEvent {
  String date;
  bool? isCompleted;
  GetTaskEvent({required this.date,this.isCompleted});
}


class AddTaskSuccessEvent extends BaseEvent {
  AddTaskModel? model;

  AddTaskSuccessEvent({this.model});
}

class DeleteTaskSuccessEvent extends BaseEvent {
  DeleteTaskModel? model;

  DeleteTaskSuccessEvent({this.model});
}

class GetTaskSuccessEvent extends BaseEvent {
  GetTaskModel? model;

  GetTaskSuccessEvent({this.model});
}

class UpdateTaskSuccessEvent extends BaseEvent {
  AddTaskModel? model;

  UpdateTaskSuccessEvent({this.model});
}

