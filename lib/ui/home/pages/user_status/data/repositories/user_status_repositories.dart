
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
import 'package:task_management/ui/home/pages/user_status/data/datasource/user_status_data_source.dart';
import 'package:task_management/ui/home/pages/user_status/data/model/get_user_status_model.dart';
import 'package:task_management/ui/home/pages/user_status/domain/repositories/user_status_repositories.dart';
import 'package:task_management/ui/home/pages/user_status/domain/usecases/get_user_status_usecase.dart';

import '../../../../../../core/failure/failure.dart';



class UserStatusRepositoriesImpl extends UserStatusRepositories {
  UserStatusDataSource? userStatusDataSource;

  UserStatusRepositoriesImpl({
    this.userStatusDataSource,
  });

  @override
  Stream<Either<Failure, GetUserStatusModel>> getUserStatusCall(GetUserStatusParams params) async* {
    try {
      var response = await userStatusDataSource!.getUserStatusCall(params);
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
