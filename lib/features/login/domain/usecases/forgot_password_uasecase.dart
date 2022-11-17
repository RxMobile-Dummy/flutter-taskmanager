import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_management/features/login/data/model/forgot_password_model.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/usecase.dart';
import '../repositories/login_repositories.dart';

class ForgotPasswardUsecase extends UseCase<ForgotPasswordModel, ForgotPasswardParams> {
  final LoginRepositories? loginRepositories;

  ForgotPasswardUsecase({this.loginRepositories});

  @override
  Stream<Either<Failure, ForgotPasswordModel>> call(ForgotPasswardParams params) {
    return loginRepositories!.forgotPasswordCall(params);
  }




}

class ForgotPasswardParams extends Equatable {
  String email;

  ForgotPasswardParams({
    required this.email,
  });

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['email'] = this.email;

    return data;
  }
}