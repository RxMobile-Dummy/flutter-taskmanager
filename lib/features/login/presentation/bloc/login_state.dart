

import 'package:task_management/features/login/data/model/forgot_password_model.dart';
import 'package:task_management/features/login/data/model/get_user_role_model.dart';
import 'package:task_management/features/login/data/model/sign_up_model.dart';

import '../../../../core/base/base_bloc.dart';
import '../../data/model/login_model.dart';
import '../../data/model/reset_passward_model.dart';

class LoginState extends BaseState {
  LoginModel? model;

  LoginState({this.model});
}

class SignUpState extends BaseState {
  SignUpModel? model;

  SignUpState({this.model});
}

class GetUserRoleState extends BaseState {
  GetUserRoleModel? model;

  GetUserRoleState({this.model});
}

class ForgotPasswordStatus extends BaseState {
  ForgotPasswordModel? model;

  ForgotPasswordStatus({this.model});
}

class ResetPasswordStatus extends BaseState {
  ResetPasswardModel? model;

  ResetPasswordStatus({this.model});
}


class GetRecentUserEmailId extends BaseState {
  String? recentUserEmailId;

  GetRecentUserEmailId({this.recentUserEmailId});
}

class ChangePasswordState extends BaseState {
  String? message;

  ChangePasswordState({this.message});
}

class PasswordDoesNotMatchState extends BaseState{

  String? msg;
  PasswordDoesNotMatchState(this.msg);
}