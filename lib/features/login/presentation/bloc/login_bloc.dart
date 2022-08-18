import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/core/failure/error_object.dart';
import 'package:task_management/features/login/data/model/forgot_password_model.dart';
import 'package:task_management/features/login/data/model/get_user_role_model.dart';
import 'package:task_management/features/login/data/model/reset_passward_model.dart';
import 'package:task_management/features/login/domain/usecases/forgot_password_uasecase.dart';
import 'package:task_management/features/login/domain/usecases/get_user_role_usecase.dart';
import 'package:task_management/features/login/domain/usecases/reset_passward_usecase.dart';
import 'package:task_management/features/login/domain/usecases/sign_up_usecase.dart';
import '../../../../core/base/base_bloc.dart';
import '../../data/model/login_model.dart';
import '../../data/model/sign_up_model.dart';
import '../../domain/usecases/login.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<BaseEvent, BaseState> {
  static const String GET_LOGOUT_EMAIL = "getLogoutEmail";

  LoginCase? loginCase;
  SignUpUsecase? signUpUsecase;
  ForgotPasswardUsecase? forgotPasswardUsecase;
  ResetPasswardUsecase? resetPasswardUsecase;
  GetUserRoleUsecase? getUserRoleUsecase;


  LoginBloc(
      {required this.getUserRoleUsecase,required this.loginCase,this.forgotPasswardUsecase,this.resetPasswardUsecase,this.signUpUsecase}) : super(StateLoading()) {
    on<BaseEvent>((event, emit) async {
      if (event is EventRequest) {
    } else if (event is PasswordDoesNotMatch) {

    } else if (event is LoginEvent) {
    loginCall(event.email ?? "", event.password ?? "");
    }  else if (event is GetUserRoleEvent) {
        getUserRoleCall();
      }else if (event is SignUpEvent) {
        signUpCall(
          role: event.role,
          password: event.password,
          mobile: event.mobile,
          lastName: event.lastName,
          firstName: event.firstName,
          email: event.email
        );
      }else if (event is ForgotPassEvent) {
    forgotPassword(event.email ?? "");
    } else if (event is ResetPasswordEvent) {
    resetPassward(event.newPassword,event.otp);
    } else if (event is EventOnSuccess) {

    } else if (event is EventLoading) {

    } else if (event is EventErrorGeneral) {
        emit(StateErrorGeneral(event.message));
    }else if (event is LoginSuccessEvent){
        LoginModel? model = event.model;

        if(model?.success != true){
          emit(StateErrorGeneral(model?.error??""));
        }else{
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('access', model!.data?.authenticationToken?.access ?? "");
          prefs.setString('refresh', model.data?.authenticationToken?.refresh ?? "");
          prefs.setString('id', model.data?.id!.toString() ?? "");
          String? token = prefs.getString("access");
          print(token);
          String user = jsonEncode(model.data?.toJson());
          prefs.setString('userData', user);
          emit(LoginState(model: model));
        }
      }else if (event is ForgotPasswardSuccessEvent){
        ForgotPasswordModel? model = event.model;
        if(model?.success != true){
          emit(StateErrorGeneral(model?.error??""));
        }else{
          emit(ForgotPasswordStatus(model: model));
        }
      }else if (event is ResetPasswardSuccessEvent){
        ResetPasswardModel? model = event.model;
        if(model?.success != true){
          emit(StateErrorGeneral(model?.error??""));
        }else{
          emit(ResetPasswordStatus(model: model));
        }
      }else if (event is SignUpSuccessEvent){
        SignUpModel? model = event.model;
        if(model?.success != true){
          emit(StateErrorGeneral(model?.error??""));
        }else{
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('access', model?.data!.authenticationToken!.access ?? "");
          prefs.setString('refresh', model?.data!.authenticationToken!.refresh ?? "");
          prefs.setString('id', model?.data?.id!.toString() ?? "");
          String user = jsonEncode(model?.data?.toJson());
          prefs.setString('userData', user);
          emit(SignUpState(model: model));
        }
      }else if (event is GetUserRoleSuccessEvent){
        GetUserRoleModel? model = event.model;
        if(model?.success != true){
          emit(StateErrorGeneral(model?.error??""));
        }else{
          emit(GetUserRoleState(model: model));
        }
      }
    });
  }



  loginCall(String email, String password) {
    loginCase!
        .call(LoginParams(email: email, password: password))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(ErrorObject.mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
       add(LoginSuccessEvent(model: onSuccess));
      });
    });
  }

  getUserRoleCall() {
    getUserRoleUsecase!
        .call(GetUserRoleParams())
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(ErrorObject.mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(GetUserRoleSuccessEvent(model: onSuccess));
      });
    });
  }

  signUpCall(
      {
    String? email,
    String? password,
    String? mobile,
    String? firstName,
    String? lastName,
    String? role,
  }) {
    signUpUsecase!
        .call(SignUpParams(
      email: email ?? "",
      firstName: firstName ?? "",
      lastName: lastName ?? "",
      mobile: mobile ?? "",
      password: password ?? "",
      role_id: role ?? "",
    ))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(ErrorObject.mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(SignUpSuccessEvent(model: onSuccess));
      });
    });
  }

  forgotPassword(String email) {
    forgotPasswardUsecase
        ?.call(ForgotPasswardParams(email: email))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(ErrorObject.mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(ForgotPasswardSuccessEvent(model: onSuccess));
      });
    });
  }

  resetPassward(String password,String otp) {
    resetPasswardUsecase
        ?.call(ResetPasswardParams(password: password,otp: otp))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(ErrorObject.mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(ResetPasswardSuccessEvent(model: onSuccess));
      });
    });
  }



}
