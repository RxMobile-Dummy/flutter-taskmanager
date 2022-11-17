import 'dart:io';
import 'package:bloc/bloc.dart';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

part 'base_event.dart';
part 'base_state.dart';

class BaseBloc extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    debugPrint('BaseBloc Error $bloc $error');
    if (error is PlatformException) {
      bloc.addError(EventErrorGeneral(error.message ?? ""));
    } else if (error is IOException) {
      bloc.addError(EventInternetError());
    } else if (error is DioError && error.error is SocketException) {
      bloc.addError(EventInternetError());
    }
  }
}
