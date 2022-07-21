import 'package:dartz/dartz.dart';
import 'package:task_management/ui/home/pages/Project/data/model/add_project_model.dart';
import 'package:task_management/ui/home/pages/Project/data/model/delete_project_model.dart';
import 'package:task_management/ui/home/pages/Project/data/model/update_project_model.dart';
import 'package:task_management/ui/home/pages/Project/domain/usecases/add_project_usecase.dart';
import 'package:task_management/ui/home/pages/Project/data/model/get_all_project_model.dart';

import '../../../../../../core/failure/failure.dart';
import '../usecases/delete_project_usecase.dart';
import '../usecases/get_all_projects_usecase.dart';
import '../usecases/update_project_usecase.dart';

abstract class ProjectRepositories {
  Stream<Either<Failure, AddProjectModel>> addProjectCall(AddProjectParams params);
  Stream<Either<Failure, UpdateProjectModel>> updateProjectCall(UpdateProjectParams params);
  Stream<Either<Failure, DeleteProjectModel>> deleteProjectCall(DeleteProjectParams params);
  Stream<Either<Failure, GetAllProjectsModel>> getAllPeojectsCall(GetAllPeojectsParams params);
}