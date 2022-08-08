import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:task_management/features/login/data/model/forgot_password_model.dart';
import 'package:task_management/features/login/data/model/get_user_role_model.dart';
import 'package:task_management/features/login/data/model/login_model.dart';
import 'package:task_management/features/login/data/model/reset_passward_model.dart';
import 'package:task_management/features/login/data/model/sign_up_model.dart';
import 'package:task_management/features/login/domain/usecases/forgot_password_uasecase.dart';
import 'package:task_management/features/login/domain/usecases/get_user_role_usecase.dart';
import 'package:task_management/features/login/domain/usecases/reset_passward_usecase.dart';
import 'package:task_management/features/login/domain/usecases/sign_up_usecase.dart';

import '../../../../core/Strings/strings.dart';
import '../../../../core/failure/failure.dart';
import '../../domain/repositories/login_repositories.dart';
import '../../domain/usecases/login.dart';
import '../datasource/login_data_sourse.dart';

class LoginRepositoriesImpl extends LoginRepositories {
  LocalDataSource? localDataSource;

  LoginRepositoriesImpl({
    this.localDataSource,
  });

  @override
  Stream<Either<Failure, LoginModel>> loginCall(LoginParams params) async* {
    try {
      var response = await localDataSource!.loginCall(params);
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
  Stream<Either<Failure, ForgotPasswordModel>> forgotPasswordCall(ForgotPasswardParams params) async* {
    try {
      var response = await localDataSource!.forgotPasswordCall(params);
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
  Stream<Either<Failure, ResetPasswardModel>> resetPasswordCall(ResetPasswardParams params) async*{
    try {
      var response = await localDataSource!.resetPasswordCall(params);
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
  Stream<Either<Failure, SignUpModel>> signUpCall(SignUpParams params) async*{
    try {
      var response = await localDataSource!.signUpCall(params);
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
  Stream<Either<Failure, GetUserRoleModel>> getUserRoleCall(GetUserRoleParams params) async*{
    try {
      var response = await localDataSource!.getUserRoleCall(params);
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
