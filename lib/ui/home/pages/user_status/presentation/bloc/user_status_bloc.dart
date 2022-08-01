import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/ui/home/pages/user_status/domain/usecases/get_user_status_usecase.dart';
import 'package:task_management/ui/home/pages/user_status/presentation/bloc/user_status_event.dart';
import 'package:task_management/ui/home/pages/user_status/presentation/bloc/user_status_state.dart';

import '../../../../../../core/Strings/strings.dart';
import '../../../../../../core/base/base_bloc.dart';
import '../../../../../../core/failure/failure.dart';

class UserStatusBloc extends Bloc<BaseEvent, BaseState> {

GetUserStatusUsecase? getUserStatusUsecase;


  UserStatusBloc(
      {required this.getUserStatusUsecase}) : super(StateLoading()) {
    on<BaseEvent>((event, emit) {
      if (event is EventRequest) {
      } else if (event is GetUserStatusEvent) {
        getUserStatusCall();
      } else if (event is GetUserStatusSuccessEvent){
        emit(GetUserStatusState(model: event.model));
      }
    });
  }


  getUserStatusCall() {
    getUserStatusUsecase!
        .call(GetUserStatusParams( ))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(_mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(GetUserStatusSuccessEvent(model: onSuccess));
      });
    });
  }



  String? _mapFailureToMessage(Failure failure) {
    if (failure.runtimeType == ServerFailure) {
      return Strings.k_SERVER_FAILURE_MESSAGE;
    } else if (failure.runtimeType == CacheFailure) {
      return Strings.k_CACHE_FAILURE_MESSAGE;
    } else if (failure.runtimeType == FailureMessage) {
      if (failure is FailureMessage) {
        return failure.message;
      }
    }
  }

}
