import 'package:dartz/dartz.dart';
import 'package:task_management/core/failure/failure.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/data/datasource/add_note_data_source.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/data/model/add_note_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/domain/repositories/add_note_repositories.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/domain/usecases/add_note_usecase.dart';
import 'package:task_management/ui/home/pages/Project/data/datasource/project_data_source.dart';
import 'package:task_management/ui/home/pages/Project/data/model/add_project_model.dart';
import 'package:task_management/ui/home/pages/Project/data/model/delete_project_model.dart';
import 'package:task_management/ui/home/pages/Project/data/model/get_all_project_model.dart';
import 'package:task_management/ui/home/pages/Project/data/model/update_project_model.dart';
import 'package:task_management/ui/home/pages/Project/domain/repositories/project_repositories.dart';
import 'package:task_management/ui/home/pages/Project/domain/usecases/delete_project_usecase.dart';
import 'package:task_management/ui/home/pages/Project/domain/usecases/get_all_projects_usecase.dart';
import 'package:task_management/ui/home/pages/Project/domain/usecases/update_project_usecase.dart';

class ProjectRepositoriesImpl extends ProjectRepositories {
  ProjectDataSource? projectDataSource;

  ProjectRepositoriesImpl({
    this.projectDataSource,
  });

  @override
  Stream<Either<Failure, AddProjectModel>> addProjectCall(params) async* {
    try {
      var response = await projectDataSource!.addProjectCall(params);
      if (response != null) {
        yield Right(response);
      }
    } catch (e, s) {
      yield Left(FailureMessage(e.toString()));
      print(e);
      print("Fail");
    }
  }

  @override
  Stream<Either<Failure, GetAllProjectsModel>> getAllPeojectsCall(GetAllPeojectsParams params) async* {
    try {
      var response = await projectDataSource!.getAllPeojectsCall(params);
      if (response != null) {
        yield Right(response);
      }
    } catch (e, s) {
      yield Left(FailureMessage(e.toString()));
      print(e);
      print("Fail");
    }
  }

  @override
  Stream<Either<Failure, UpdateProjectModel>> updateProjectCall(UpdateProjectParams params) async* {
    try {
      var response = await projectDataSource!.updateProjectCall(params);
      if (response != null) {
        yield Right(response);
      }
    } catch (e, s) {
      yield Left(FailureMessage(e.toString()));
      print(e);
      print("Fail");
    }
  }

  @override
  Stream<Either<Failure, DeleteProjectModel>> deleteProjectCall(DeleteProjectParams params) async* {
    try {
      var response = await projectDataSource!.deleteProjectCall(params);
      if (response != null) {
        yield Right(response);
      }
    } catch (e, s) {
      yield Left(FailureMessage(e.toString()));
      print(e);
      print("Fail");
    }
  }




}
