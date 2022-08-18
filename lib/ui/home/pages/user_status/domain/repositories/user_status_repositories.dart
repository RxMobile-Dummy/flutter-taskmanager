import 'package:dartz/dartz.dart';
import 'package:task_management/ui/home/pages/user_status/data/model/get_user_status_model.dart';
import 'package:task_management/ui/home/pages/user_status/domain/usecases/get_user_status_usecase.dart';

import '../../../../../../core/failure/failure.dart';



abstract class UserStatusRepositories {
  Stream<Either<Failure, GetUserStatusModel>> getUserStatusCall(GetUserStatusParams params);
}