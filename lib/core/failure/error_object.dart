import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/core/failure/failure.dart';

import '../../custom/progress_bar.dart';
import '../../features/login/presentation/bloc/login_bloc.dart';
import '../../features/login/presentation/pages/login.dart';
import '../../main.dart';
import '../Strings/strings.dart';
import 'package:task_management/injection_container.dart' as Sl;

class ErrorObject {


 static String? mapFailureToMessage(Failure failure) {
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

  static logout() async {
    ProgressDialog.hideLoadingDialog(navigatorKey.currentContext!);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    prefs.setString("isOnBoardingCompleted", "true");
    print(prefs);
    Future.delayed(Duration.zero, () {
      Navigator.pushAndRemoveUntil(
        navigatorKey.currentContext!,MaterialPageRoute(builder: (context) =>BlocProvider<LoginBloc>(
        create: (context) => Sl.Sl<LoginBloc>(),
        child: Login(),
      )),
            (route) => false,
      );
    });
  }

 static Future<Failure> checkErrorState(e) async {
    if (e is DioError) {
      if (e.error is SocketException) {
        return FailureMessage(Strings.kNoInternetConnection);
      } else if (e.response!.statusCode == 400) {
        return FailureMessage(e.response!.data.toString());
      } else if (e.response!.statusCode == 500) {
        return FailureMessage(Strings.kInternalServerError);
      } else {
        return FailureMessage(e.response!.data["error"].toString());
      }
    } else {
      if (e.errors!=null && e.errors[0].error.error is SocketException) {
        return InternetFailure(Strings.kNoInternetConnection);
      } else {
        return FailureMessage(e.response.data["error"].toString());
      }
    }
  }
}