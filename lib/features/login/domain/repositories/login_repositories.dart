import 'package:dartz/dartz.dart';
import 'package:task_management/features/login/data/model/forgot_password_model.dart';
import 'package:task_management/features/login/data/model/get_user_role_model.dart';
import 'package:task_management/features/login/data/model/login_model.dart';
import 'package:task_management/features/login/data/model/sign_up_model.dart';
import 'package:task_management/features/login/domain/usecases/forgot_password_uasecase.dart';
import 'package:task_management/features/login/domain/usecases/reset_passward_usecase.dart';

import '../../../../core/failure/failure.dart';
import '../../data/model/reset_passward_model.dart';
import '../usecases/get_user_role_usecase.dart';
import '../usecases/login.dart';
import '../usecases/sign_up_usecase.dart';

abstract class LoginRepositories {
  Stream<Either<Failure, LoginModel>> loginCall(LoginParams params);
  Stream<Either<Failure, SignUpModel>> signUpCall(SignUpParams params);
  Stream<Either<Failure, GetUserRoleModel>> getUserRoleCall(GetUserRoleParams params);
  Stream<Either<Failure, ForgotPasswordModel>> forgotPasswordCall(ForgotPasswardParams params);
  Stream<Either<Failure, ResetPasswardModel>> resetPasswordCall(ResetPasswardParams params);
}
