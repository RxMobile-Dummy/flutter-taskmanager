import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:task_management/features/login/data/model/login_model.dart';
import 'package:task_management/features/login/data/model/sign_up_model.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/usecase.dart';
import '../repositories/login_repositories.dart';

class SignUpUsecase extends UseCase<SignUpModel, SignUpParams> {
  final LoginRepositories? loginRepositories;

  SignUpUsecase({this.loginRepositories});

  @override
  Stream<Either<Failure, SignUpModel>> call(SignUpParams params) {
    return loginRepositories!.signUpCall(params);
  }

/* @override
  Stream<Either<Failure, LoginModel>> call(LoginParams params) {

  }*/
}

class SignUpParams extends Equatable {
  String firstName;
  String lastName;
  String email;
  String password;
  String mobile;
  String role_id;

  SignUpParams({
    required this.email,
    required this.password,
    required this.mobile,
    required this.lastName,
    required this.firstName,
    required this.role_id,
  });

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['email'] = this.email;
    data['password'] = this.password;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['mobile'] = this.mobile;
    data['role_id'] = this.role_id;

    return data;
  }
}
