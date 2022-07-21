
import 'package:dartz/dartz.dart';

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
      yield Left(FailureMessage(e.toString()));
      print(e);
      print("Fail");
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
      yield Left(FailureMessage(e.toString()));
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
      yield Left(FailureMessage(e.toString()));
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
      yield Left(FailureMessage(e.toString()));
      print(e);
      print("Fail");
    }
  }



}
