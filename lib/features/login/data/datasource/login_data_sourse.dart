import 'package:task_management/features/login/data/model/forgot_password_model.dart';
import 'package:task_management/features/login/data/model/get_user_role_model.dart';
import 'package:task_management/features/login/data/model/reset_passward_model.dart';
import 'package:task_management/features/login/data/model/sign_up_model.dart';
import 'package:task_management/features/login/domain/usecases/forgot_password_uasecase.dart';
import 'package:task_management/features/login/domain/usecases/reset_passward_usecase.dart';

import '../../domain/usecases/get_user_role_usecase.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import '../model/login_model.dart';

abstract class LocalDataSource {
  Future<LoginModel> loginCall(LoginParams params);
  Future<SignUpModel> signUpCall(SignUpParams params);
  Future<GetUserRoleModel> getUserRoleCall(GetUserRoleParams params);
  Future<ForgotPasswordModel> forgotPasswordCall(ForgotPasswardParams params);
  Future<ResetPasswardModel> resetPasswordCall(ResetPasswardParams params);
}
