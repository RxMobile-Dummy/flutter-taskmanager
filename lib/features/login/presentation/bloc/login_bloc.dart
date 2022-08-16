import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/features/login/domain/usecases/forgot_password_uasecase.dart';
import 'package:task_management/features/login/domain/usecases/get_user_role_usecase.dart';
import 'package:task_management/features/login/domain/usecases/reset_passward_usecase.dart';
import 'package:task_management/features/login/domain/usecases/sign_up_usecase.dart';

import '../../../../core/Strings/strings.dart';
import '../../../../core/base/base_bloc.dart';
import '../../../../core/failure/failure.dart';
import '../../../../custom/progress_bar.dart';
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
    on<BaseEvent>((event, emit) {
      if (event is EventRequest) {
    } else if (event is PasswordDoesNotMatch) {
      //yield PasswordDoesNotMatchState(Strings.kPasswordDoesNotMatch);
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
   // yield StateOnSuccess(event.response ?? "");
    } else if (event is EventLoading) {
    //yield StateLoading();
    } else if (event is EventErrorGeneral) {
        emit(StateErrorGeneral(event.message));
    }else if (event is LoginSuccessEvent){
        emit(LoginState(model: event.model));
      }else if (event is ForgotPasswardSuccessEvent){
        emit(ForgotPasswordStatus(model: event.model));
      }else if (event is ResetPasswardSuccessEvent){
        emit(ResetPasswordStatus(model: event.model));
      }else if (event is SignUpSuccessEvent){
        emit(SignUpState(model: event.model));
      }else if (event is GetUserRoleSuccessEvent){
        emit(GetUserRoleState(model: event.model));
      }
    });
  }


/*  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is EventRequest) {
 *//*     if (event.request == GET_LOGOUT_EMAIL) {
        getLastUserLoggedOutEmail();
      } else if (event.request is String) {
        sendFormEmail();
      }*//*
    } else if (event is PasswordDoesNotMatch) {
      //yield PasswordDoesNotMatchState(Strings.kPasswordDoesNotMatch);
    } else if (event is LoginEvent) {
      loginCall(event.email ?? "", event.password ?? "");
    } else if (event is ForgotPassEvent) {
      //forgotPassword(event.email);
    } else if (event is ChangePasswordEvent) {
      //changeUserPassword(event.newPassword);
    } else if (event is EventOnSuccess) {
      yield StateOnSuccess(event.response ?? "");
    } else if (event is EventLoading) {
      yield StateLoading();
    } else if (event is EventErrorGeneral) {
      yield StateErrorGeneral(event.errorMessage);
    }
  }*/

  loginCall(String email, String password) {
    loginCase!
        .call(LoginParams(email: email, password: password))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(_mapFailureToMessage(onError) ?? ""));
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
        add(EventErrorGeneral(_mapFailureToMessage(onError) ?? ""));
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
        add(EventErrorGeneral(_mapFailureToMessage(onError) ?? ""));
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
        add(EventErrorGeneral(_mapFailureToMessage(onError) ?? ""));
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
        add(EventErrorGeneral(_mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(ResetPasswardSuccessEvent(model: onSuccess));
      });
    });
  }

  String? _mapFailureToMessage(Failure failure) {
    if (failure.runtimeType == ServerFailure) {
      return Strings.kServerFailureMessage;
    } else if (failure.runtimeType == CacheFailure) {
      return Strings.kCacheFailureMessage;
    } else if (failure.runtimeType == FailureMessage) {
      if (failure is FailureMessage) {
        return failure.message;
      }
    }
  }

}
