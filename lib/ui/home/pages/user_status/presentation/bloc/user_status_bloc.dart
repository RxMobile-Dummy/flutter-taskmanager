import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/ui/home/pages/user_status/data/model/get_user_status_model.dart';
import 'package:task_management/ui/home/pages/user_status/domain/usecases/get_user_status_usecase.dart';
import 'package:task_management/ui/home/pages/user_status/presentation/bloc/user_status_event.dart';
import 'package:task_management/ui/home/pages/user_status/presentation/bloc/user_status_state.dart';

import '../../../../../../core/base/base_bloc.dart';
import '../../../../../../core/failure/error_object.dart';

class UserStatusBloc extends Bloc<BaseEvent, BaseState> {

GetUserStatusUsecase? getUserStatusUsecase;


  UserStatusBloc(
      {required this.getUserStatusUsecase}) : super(StateLoading()) {
    on<BaseEvent>((event, emit) {
      if (event is EventRequest) {
      } else if (event is GetUserStatusEvent) {
        getUserStatusCall();
      } else if (event is GetUserStatusSuccessEvent){
        GetUserStatusModel? model = event.model;
        if(model?.success != true){
          emit(StateErrorGeneral(model?.error ?? ""));
        }else{
          emit(GetUserStatusState(model: model));
        }
      }else if (event is EventErrorGeneral) {
        emit(StateErrorGeneral(event.message));
      }
    });
  }


  getUserStatusCall() {
    getUserStatusUsecase!
        .call(GetUserStatusParams( ))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(ErrorObject.mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(GetUserStatusSuccessEvent(model: onSuccess));
      });
    });
  }





}
