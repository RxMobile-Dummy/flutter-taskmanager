

import 'package:task_management/ui/home/pages/Project/data/model/delete_project_model.dart';
import 'package:task_management/ui/home/pages/Project/data/model/update_project_model.dart';
import 'package:task_management/ui/home/pages/Project/domain/usecases/add_project_usecase.dart';
import 'package:task_management/ui/home/pages/Project/data/model/get_all_project_model.dart';
import 'package:task_management/ui/home/pages/comment/data/model/delete_comment_model.dart';

import '../../domain/usecases/delete_project_usecase.dart';
import '../../domain/usecases/get_all_projects_usecase.dart';
import '../../domain/usecases/update_project_usecase.dart';
import '../model/add_project_model.dart';

abstract class ProjectDataSource {
  Future<AddProjectModel> addProjectCall(AddProjectParams params);
  Future<UpdateProjectModel> updateProjectCall(UpdateProjectParams params);
  Future<DeleteProjectModel> deleteProjectCall(DeleteProjectParams params);
  Future<GetAllProjectsModel> getAllPeojectsCall(GetAllPeojectsParams params);
}
