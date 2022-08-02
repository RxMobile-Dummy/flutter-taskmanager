import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/ui/home/pages/Profile/domain/usecases/update_profile_usecase.dart';
import 'package:task_management/ui/home/pages/Profile/presentation/bloc/profile_event.dart';
import 'package:task_management/ui/home/pages/Profile/presentation/bloc/profile_state.dart';
import 'package:task_management/ui/home/pages/user_status/domain/usecases/get_user_status_usecase.dart';
import 'package:task_management/ui/home/pages/user_status/presentation/bloc/user_status_event.dart';
import 'package:task_management/ui/home/pages/user_status/presentation/bloc/user_status_state.dart';

import '../../../../../../core/Strings/strings.dart';
import '../../../../../../core/base/base_bloc.dart';
import '../../../../../../core/failure/failure.dart';

class UpdateProfileBloc extends Bloc<BaseEvent, BaseState> {

  UpdateProfileUsecase? updateProfileUsecase;


  UpdateProfileBloc(
      {required this.updateProfileUsecase}) : super(StateLoading()) {
    on<BaseEvent>((event, emit) {
      if (event is EventRequest) {
      } else if (event is UpdateProfileEvent) {
        updateProfileCall(
          status_id: event.status_id,
          profile_pic: event.profile_pic,
          mobile_number: event.mobile_number,
          last_name: event.last_name,
          first_name: event.first_name,
          role: event.role,
          email: event.email,
        );
      } else if (event is UpdateProfileSuccessEvent){
        emit(UpdateProfileState(model: event.model));
      }else if (event is EventErrorGeneral) {
        emit(StateErrorGeneral(event.message));
      }
    });
  }


  updateProfileCall({
    String? first_name,
    String? last_name,
    List<String>? profile_pic,
    String? mobile_number,
    String? email,
    int? role,
    int? status_id,
}) {
    updateProfileUsecase!
        .call(UpdateProfileParams(
      email: email ?? "",
      role: role ?? 0,
      first_name: first_name ?? "",
      last_name: last_name ?? "",
      mobile_number: mobile_number ?? "",
      profile_pic: profile_pic ?? [],
      status_id: status_id ?? 0,
    ))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(_mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(UpdateProfileSuccessEvent(model: onSuccess));
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
