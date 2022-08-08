import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:task_management/core/failure/failure.dart';
import 'package:task_management/ui/home/pages/add_member/data/datasource/add_member_data_source.dart';
import 'package:task_management/ui/home/pages/add_member/data/model/add_member_model.dart';
import 'package:task_management/ui/home/pages/add_member/domain/repositories/add_member_repositories.dart';
import 'package:task_management/ui/home/pages/add_member/domain/usecases/add_member_usecase.dart';

import '../../../../../../core/Strings/strings.dart';
import '../../domain/usecases/invite_project_assign_usecase.dart';
import '../model/invite_project_assign_model.dart';

class AddMemberRepositoriesImpl extends AddMemberRepositories {
  AddMemberDataSource? addMemberDataSource;

  AddMemberRepositoriesImpl({
    this.addMemberDataSource,
  });





  @override
  Stream<Either<Failure, AddMemberModel>> addMemberCall(AddMemberParams params) async* {
    try {
      var response = await addMemberDataSource!.addMemberCall(params);
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
  Stream<Either<Failure, InviteProjectAssignModel>> inviteProjectAssignCall(InviteProjectAssignParams params) async* {
    try {
      var response = await addMemberDataSource!.inviteProjectAssignCall(params);
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