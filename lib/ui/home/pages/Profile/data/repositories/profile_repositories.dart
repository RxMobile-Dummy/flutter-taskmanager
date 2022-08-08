import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:task_management/core/failure/failure.dart';
import 'package:task_management/ui/home/pages/Profile/data/datasource/profile_data_source.dart';
import 'package:task_management/ui/home/pages/Profile/data/model/update_profile_model.dart';
import 'package:task_management/ui/home/pages/Profile/domain/repositories/profile_repositories.dart';
import 'package:task_management/ui/home/pages/Profile/domain/usecases/update_profile_usecase.dart';

import '../../../../../../core/Strings/strings.dart';

class UpdateUserProfileRepositoriesImpl extends UpdateProfileRepositories {
  ProfileDataSource? profileDataSource;

  UpdateUserProfileRepositoriesImpl({
    this.profileDataSource,
  });

  @override
  Stream<Either<Failure, UpdateUserProfileModel>> updateProfileCall(UpdateProfileParams params) async*{
    try {
      var response = await profileDataSource!.updateUserProfileCall(params);
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


}