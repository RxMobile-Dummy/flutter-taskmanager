

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_management/ui/home/pages/user_status/data/model/get_user_status_model.dart';
import 'package:task_management/ui/home/pages/user_status/domain/repositories/user_status_repositories.dart';

import '../../../../../../core/failure/failure.dart';
import '../../../../../../core/usecase.dart';

class GetUserStatusUsecase extends UseCase<GetUserStatusModel, GetUserStatusParams> {
  final UserStatusRepositories? userStatusRepositories;

  GetUserStatusUsecase({this.userStatusRepositories});

  @override
  Stream<Either<Failure, GetUserStatusModel>> call(GetUserStatusParams params) {
    return userStatusRepositories!.getUserStatusCall(params);
  }



}

class GetUserStatusParams extends Equatable {

  GetUserStatusParams();

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();


    return data;
  }
}