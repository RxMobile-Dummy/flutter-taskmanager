import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/domain/usecases/add_check_list_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/domain/usecases/delete_check_list_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/domain/usecases/get_check_list_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/domain/usecases/update_check_list_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/presentation/bloc/check_list_event.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/presentation/bloc/check_list_state.dart';
import 'package:task_management/ui/home/pages/Profile/domain/usecases/update_profile_usecase.dart';

import '../../../../../../core/Strings/strings.dart';
import '../../../../../../core/base/base_bloc.dart';
import '../../../../../../core/failure/failure.dart';

class AddCheckListBloc extends Bloc<BaseEvent, BaseState> {
  AddCheckListUsecase? addCheckListUsecase;
  GetCheckListUsecase? getCheckListUsecase;
  DeleteCheckListUsecase? deleteCheckListUsecase;
  UpdateCheckListUsecase? updateCheckListUsecase;

  AddCheckListBloc(
      {required this.updateCheckListUsecase,required this.addCheckListUsecase,required this.getCheckListUsecase,required this.deleteCheckListUsecase}) : super(StateLoading()) {
    on<BaseEvent>((event, emit) async {
      if (event is EventRequest) {
      } else if (event is AddCheckListEvent) {
        addCheckListCall(
          title: event.title,
          options: event.options,
          color: event.color,
        );
      }else if (event is UpdateCheckListEvent) {
        updateCheckListCall(
          id: event.id,
          is_completed: event.is_completed,
        );
      }else if (event is GetCheckListEvent) {
        getCheckListCall();
      }else if (event is DeleteCheckListEvent) {
        deleteCheckListCall(event.id);
      }else if (event is AddCheckListSuccessEvent){
        emit(AddCheckListState(model: event.model));
      }else if (event is GetCheckListSuccessEvent){
        emit(GetCheckListState(model: event.model));
      }else if (event is DeleteCheckListSuccessEvent){
        emit(DeleteCheckListState(model: event.model));
      }else if (event is UpdateCheckListSuccessEvent){
        emit(UpdateCheckListState(model: event.model));
      }else if (event is EventErrorGeneral) {
        emit(StateErrorGeneral(event.message));
      }
    });
  }


  addCheckListCall({
    String? title,
    List<String>? options,
    String? color,
  }) {
    addCheckListUsecase!
        .call(AddCheckListParams(
      title: title ?? "",
      options: options ?? [],
      color: color ?? ""
    ))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(_mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(AddCheckListSuccessEvent(model: onSuccess));
      });
    });
  }

  updateCheckListCall({
    int? id,
    String? is_completed,
  }) {
    updateCheckListUsecase!.call(UpdateCheckListParams(
      id1: id ?? 0,
      is_completed: is_completed ?? ""
    ))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(_mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(UpdateCheckListSuccessEvent(model: onSuccess));
      });
    });
  }

 getCheckListCall() {
    getCheckListUsecase!
        .call(GetCheckListParams())
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(_mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(GetCheckListSuccessEvent(model: onSuccess));
      });
    });
  }

  deleteCheckListCall(String? id,) {
    deleteCheckListUsecase!
        .call(DeleteCheckListParams(id1: id))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(_mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(DeleteCheckListSuccessEvent(model: onSuccess));
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