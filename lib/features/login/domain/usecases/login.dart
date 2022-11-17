import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:task_management/features/login/data/model/login_model.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/usecase.dart';
import '../repositories/login_repositories.dart';

class LoginCase extends UseCase<LoginModel, LoginParams> {
  final LoginRepositories? loginRepositories;

  LoginCase({this.loginRepositories});

  @override
  Stream<Either<Failure, LoginModel>> call(LoginParams params) {
    return loginRepositories!.loginCall(params);
  }

 /* @override
  Stream<Either<Failure, LoginModel>> call(LoginParams params) {

  }*/
}

class LoginParams extends Equatable {
  String email;
  String password;

  LoginParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['email'] = this.email;
    data['password'] = this.password;

    return data;
  }
}
