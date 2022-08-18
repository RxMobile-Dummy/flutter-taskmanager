
import 'package:task_management/ui/home/pages/Project/data/model/add_project_model.dart';
import 'package:task_management/ui/home/pages/Project/data/model/delete_project_model.dart';
import 'package:task_management/ui/home/pages/Project/data/model/update_project_model.dart';

import '../../../../../../core/base/base_bloc.dart';
import '../../data/model/get_all_project_model.dart';

class AddProjectEvent extends BaseEvent {
  String color;
  String name;
  String description;
  int duration;
  bool is_private;
  bool archive;
  AddProjectEvent({
    required this.color,
    required this.name,
    required this.description,
    required this.duration,
    required this.is_private,
    required this.archive,
  });
}

class UpdateProjectEvent extends BaseEvent {
  int id;
  String color;
  String name;
  String description;
  String status_id;
  int duration;
  bool is_private;
  bool archive;
  UpdateProjectEvent({
    required this.id,
    required this.color,
    required this.name,
    required this.description,
    required this.duration,
    required this.is_private,
    required this.archive,
    required this.status_id
  });
}

class GetAllProjectsEvent extends BaseEvent {
  int id;
  GetAllProjectsEvent({
    required this.id
  });
}

class DeleteProjectEvent extends BaseEvent {
  int id;
  DeleteProjectEvent({
    required this.id
  });
}

class AddProjectSuccessEvent extends BaseEvent {
  AddProjectModel? model;

  AddProjectSuccessEvent({this.model});
}

class UpdateProjectSuccessEvent extends BaseEvent {
  UpdateProjectModel? model;

  UpdateProjectSuccessEvent({this.model});
}

class GetAllProjectsSuccessEvent extends BaseEvent {
  GetAllProjectsModel? model;

  GetAllProjectsSuccessEvent({this.model});
}

class DeleteProjectSuccessEvent extends BaseEvent {
  DeleteProjectModel? model;

  DeleteProjectSuccessEvent({this.model});
}