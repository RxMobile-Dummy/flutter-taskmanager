import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:task_management/core/failure/failure.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/data/datasource/check_list_data_source.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/data/model/add_check_list_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/data/model/delete_check_list_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/data/model/get_check_list_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/data/model/update_check_list_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/domain/repositories/check_list_repositories.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/domain/usecases/add_check_list_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/domain/usecases/delete_check_list_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/domain/usecases/get_check_list_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/domain/usecases/update_check_list_usecase.dart';

import '../../../../../../core/Strings/strings.dart';

class AddCheckListRepositoriesImpl extends AddCheckListRepositories {
  AddCheckListDataSource? addCheckListDataSource;

  AddCheckListRepositoriesImpl({
    this.addCheckListDataSource,
  });



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
  Stream<Either<Failure, AddCheckListModel>> addCheckListCall(AddCheckListParams params) async* {
    try {
      var response = await addCheckListDataSource!.addCheckListCall(params);
      if (response != null) {
        yield Right(response);
      }
    } catch (e, s) {
      Failure error = await checkErrorState(e);
      //yield Left(error);
      yield Left(FailureMessage(error.message.toString()));
      print(e);
      print("Fail");
    }
  }

  @override
  Stream<Either<Failure, GetCheckListModel>> getCheckListCall(GetCheckListParams params) async* {
    try {
      var response = await addCheckListDataSource!.getCheckListCall(params);
      if (response != null) {
        yield Right(response);
      }
    } catch (e, s) {
      Failure error = await checkErrorState(e);
      //yield Left(error);
      yield Left(FailureMessage(error.message.toString()));
      print(e);
      print("Fail");
    }
  }

  @override
  Stream<Either<Failure, DeleteCheckListModel>> deleteCheckListCall(DeleteCheckListParams params) async*{
    try {
      var response = await addCheckListDataSource!.deleteCheckListCall(params);
      if (response != null) {
        yield Right(response);
      }
    } catch (e, s) {
      Failure error = await checkErrorState(e);
      //yield Left(error);
      yield Left(FailureMessage(error.message.toString()));
      print(e);
      print("Fail");
    }
  }

  @override
  Stream<Either<Failure, UpdateCheckListModel>> updateCheckListCall(UpdateCheckListParams params) async* {
    try {
      var response = await addCheckListDataSource!.updateCheckListCall(params);
      if (response != null) {
        yield Right(response);
      }
    } catch (e, s) {
      Failure error = await checkErrorState(e);
      //yield Left(error);
      yield Left(FailureMessage(error.message.toString()));
      print(e);
      print("Fail");
    }
  }


}