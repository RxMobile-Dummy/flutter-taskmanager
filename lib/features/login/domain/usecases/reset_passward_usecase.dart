import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_management/features/login/data/model/forgot_password_model.dart';
import 'package:task_management/features/login/data/model/reset_passward_model.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/usecase.dart';
import '../repositories/login_repositories.dart';

class ResetPasswardUsecase extends UseCase<ResetPasswardModel, ResetPasswardParams> {
  final LoginRepositories? loginRepositories;

  ResetPasswardUsecase({this.loginRepositories});

  @override
  Stream<Either<Failure, ResetPasswardModel>> call(ResetPasswardParams params) {
    return loginRepositories!.resetPasswordCall(params);
  }




}

class ResetPasswardParams extends Equatable {
  String password;

  ResetPasswardParams({
    required this.password,
  });

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['password'] = this.password;

    return data;
  }
}