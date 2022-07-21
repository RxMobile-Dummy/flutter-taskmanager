

import 'package:task_management/features/login/data/model/forgot_password_model.dart';
import 'package:task_management/features/login/data/model/login_model.dart';
import 'package:task_management/features/login/data/model/reset_passward_model.dart';
import 'package:task_management/features/login/data/model/sign_up_model.dart';

import '../../../../core/base/base_bloc.dart';

class LoginEvent extends BaseEvent {
  String? email, password;

  LoginEvent({this.password, this.email});
}

class SignUpEvent extends BaseEvent {
  String? email, password,firstName,lastName,mobile,role;

  SignUpEvent({this.password, this.email,this.mobile,this.lastName,this.firstName,this.role});
}
class LoginSuccessEvent extends BaseEvent {
  LoginModel? model;

  LoginSuccessEvent({this.model});
}

class SignUpSuccessEvent extends BaseEvent {
  SignUpModel? model;

  SignUpSuccessEvent({this.model});
}

class ForgotPasswardSuccessEvent extends BaseEvent {
  ForgotPasswordModel? model;

  ForgotPasswardSuccessEvent({this.model});
}

class ResetPasswardSuccessEvent extends BaseEvent {
  ResetPasswardModel? model;

  ResetPasswardSuccessEvent({this.model});
}
class ForgotPassEvent extends BaseEvent {
  String? email;

  ForgotPassEvent({this.email});
}

class ResetPasswordEvent extends BaseEvent {
  String? newPassword;

  ResetPasswordEvent({this.newPassword});
}

class PasswordDoesNotMatch extends BaseEvent {}

class goToIvent extends BaseEvent{}
