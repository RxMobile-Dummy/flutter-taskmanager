import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:task_management/features/login/data/model/get_user_role_model.dart';
import 'package:task_management/features/login/data/model/login_model.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/usecase.dart';
import '../repositories/login_repositories.dart';

class GetUserRoleUsecase extends UseCase<GetUserRoleModel, GetUserRoleParams> {
  final LoginRepositories? loginRepositories;

  GetUserRoleUsecase({this.loginRepositories});

  @override
  Stream<Either<Failure, GetUserRoleModel>> call(GetUserRoleParams params) {
    return loginRepositories!.getUserRoleCall(params);
  }

}

class GetUserRoleParams extends Equatable {

  GetUserRoleParams();

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}
