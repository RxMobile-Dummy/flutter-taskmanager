


import 'package:task_management/ui/home/pages/Project/data/model/add_project_model.dart';
import 'package:task_management/ui/home/pages/Project/data/model/delete_project_model.dart';
import 'package:task_management/ui/home/pages/Project/data/model/get_all_project_model.dart';
import 'package:task_management/ui/home/pages/Project/data/model/update_project_model.dart';

import '../../../../../../core/base/base_bloc.dart';



class AddProjectState extends BaseState {
  AddProjectModel? model;

  AddProjectState({this.model});
}

class UpdateProjectState extends BaseState {
  UpdateProjectModel? model;

  UpdateProjectState({this.model});
}

class GetAllProjectsState extends BaseState {
  GetAllProjectsModel? model;

  GetAllProjectsState({this.model});
}

class DeleteProjectState extends BaseState {
  DeleteProjectModel? model;

  DeleteProjectState({this.model});
}

