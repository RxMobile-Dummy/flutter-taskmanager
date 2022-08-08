
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:task_management/ui/home/pages/comment/data/datasource/comment_data_source.dart';
import 'package:task_management/ui/home/pages/comment/data/model/add_comment_model.dart';
import 'package:task_management/ui/home/pages/comment/data/model/delete_comment_model.dart';
import 'package:task_management/ui/home/pages/comment/data/model/get_comment_model.dart';
import 'package:task_management/ui/home/pages/comment/data/model/update_comment_model.dart';
import 'package:task_management/ui/home/pages/comment/domain/repositories/comment_repositories.dart';
import 'package:task_management/ui/home/pages/comment/domain/usecases/add_comment_usecase.dart';
import 'package:task_management/ui/home/pages/comment/domain/usecases/delete_comment_usecase.dart';
import 'package:task_management/ui/home/pages/comment/domain/usecases/get_comment_usecase.dart';
import 'package:task_management/ui/home/pages/comment/domain/usecases/update_comment_usecase.dart';

import '../../../../../../core/Strings/strings.dart';
import '../../../../../../core/failure/failure.dart';



class AddCommentRepositoriesImpl extends AddCommentRepositories {
  AddCommentDataSource? addCommentDataSource;

  AddCommentRepositoriesImpl({
    this.addCommentDataSource,
  });

  @override
  Stream<Either<Failure, AddCommentModel>> addCommentCall(AddCommentParams params) async* {
    try {
      var response = await addCommentDataSource!.addCommentCall(params);
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
  Stream<Either<Failure, UpdateCommentModel>> updateCommentCall(UpdateCommentParams params) async* {
    try {
      var response = await addCommentDataSource!.updateCommentCall(params);
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
  Stream<Either<Failure, DeleteCommentModel>> deleteCommentCall(DeleteCommentParams params) async*{
    try {
      var response = await addCommentDataSource!.deleteCommentCall(params);
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
  Stream<Either<Failure, GetCommentModel>> getCommentCall(GetCommentParams params) async* {
    try {
      var response = await addCommentDataSource!.getCommentCall(params);
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
