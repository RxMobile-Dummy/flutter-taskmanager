import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:task_management/features/login/data/model/forgot_password_model.dart';
import 'package:task_management/features/login/data/model/login_model.dart';
import 'package:task_management/features/login/data/model/reset_passward_model.dart';
import 'package:task_management/features/login/domain/usecases/forgot_password_uasecase.dart';
import 'package:task_management/features/login/domain/usecases/reset_passward_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/datasource/add_task_data_sourse.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/add_task_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/delete_task_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/get_task_model.dart';
import 'package:task_management/ui/home/pages/add_member/data/model/invite_project_assign_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/update_task.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/domain/usecases/add_task_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/domain/usecases/delete_task_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/domain/usecases/get_task_usecase.dart';
import 'package:task_management/ui/home/pages/add_member/domain/usecases/invite_project_assign_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/domain/usecases/update_task_usecase.dart';

import '../../../../../../core/Strings/strings.dart';
import '../../../../../../core/failure/failure.dart';
import '../../domain/repositories/add_task_repositories.dart';


class AddTaskRepositoriesImpl extends AddTaskRepositories {
  AddTaskDataSource? addTaskDataSource;

  AddTaskRepositoriesImpl({
    this.addTaskDataSource,
  });


  @override
  Stream<Either<Failure, AddTaskModel>> addTaskCall(AddTaskParams params) async* {
    try {
      var response = await addTaskDataSource!.addTaskCall(params);
      if (response != null) {
        yield Right(response);
      }
    } catch (e, s) {
      Failure error = await checkErrorState(e);
      //yield Left(error);
      yield Left(FailureMessage(error.toString()));
      print(e);
      print("Fail");
    }
  }


  Future<Failure> checkErrorState(e) async {
    if (e is DioError) {
      if (e.error is SocketException) {
        return InternetFailure(Strings.kNoInternetConnection);
      } else if (e.response!.statusCode == 400) {
        return FailureMessage(e.response!.data.toString());
      } else if (e.response!.statusCode == 500) {
        return FailureMessage(Strings.kInternalServerError);
      } else {
        return FailureMessage(e.response!.data["error"].toString());
      }
    } else {
      if (e.errors!=null && e.errors[0].error.error is SocketException) {
        return InternetFailure(Strings.kNoInternetConnection);
      } else {
        return FailureMessage(e.response.data["error"].toString());
      }
    }
  }
  @override
  Stream<Either<Failure, DeleteTaskModel>> deleteTaskCall(DeleteTaskParams params) async* {
    try {
      var response = await addTaskDataSource!.deleteTaskCall(params);
      if (response != null) {
        yield Right(response);
      }
    } catch (e, s) {
      Failure error = await checkErrorState(e);
      //yield Left(error);
      yield Left(FailureMessage(error.toString()));
      print(e);
      print("Fail");
    }
  }

  @override
  Stream<Either<Failure, AddTaskModel>> updateTaskCall(UpdateTaskParams params) async* {
    try {
      var response = await addTaskDataSource!.updateTaskCall(params);
      if (response != null) {
        yield Right(response);
      }
    } catch (e, s) {
      Failure error = await checkErrorState(e);
      //yield Left(error);
      yield Left(FailureMessage(error.toString()));
      print(e);
      print("Fail");
    }
  }

  @override
  Stream<Either<Failure, GetTaskModel>> getTaskCall(GetTaskParams params) async* {
    try {
      var response = await addTaskDataSource!.getTaskCall(params);
      if (response != null) {
        yield Right(response);
      }
    } catch (e, s) {
      Failure error = await checkErrorState(e);
      //yield Left(error);
      yield Left(FailureMessage(error.toString()));
      print(e);
      print("Fail");
    }
  }

}
