import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/ui/home/pages/Profile/data/model/update_profile_model.dart';
import 'package:task_management/ui/home/pages/Profile/domain/usecases/update_profile_usecase.dart';
import 'package:task_management/ui/home/pages/Profile/presentation/bloc/profile_event.dart';
import 'package:task_management/ui/home/pages/Profile/presentation/bloc/profile_state.dart';
import '../../../../../../core/base/base_bloc.dart';
import '../../../../../../core/failure/error_object.dart';

class UpdateProfileBloc extends Bloc<BaseEvent, BaseState> {

  UpdateProfileUsecase? updateProfileUsecase;


  UpdateProfileBloc(
      {required this.updateProfileUsecase}) : super(StateLoading()) {
    on<BaseEvent>((event, emit) async {
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
      } else if(event is UpdatedUserDataGetEvent){
        emit(StateLoading());
        SharedPreferences prefs = await SharedPreferences.getInstance();
        Map<String, dynamic> userMap  = jsonDecode(prefs.getString('userData') ?? "");
        emit(UpdatedProfileDataState(userData: userMap));
      }else if (event is UpdateProfileSuccessEvent){
        UpdateUserProfileModel? model = event.model;
        if(model?.success != true){
          emit(StateErrorGeneral(model?.error ?? ""));
        }else{
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String user = jsonEncode(model?.data?.toJson());
          prefs.setString('userData', user);
          emit(UpdateProfileState(model: model));
        }
      }else if(event is UpdatedUserDataGetSuccessEvent){
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // Map<String, dynamic> userMap  = jsonDecode(prefs.getString('userData') ?? "");
        // emit(Uninitialized());
        // emit(UpdatedProfileDataState(userData: userMap));
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
        add(EventErrorGeneral(ErrorObject.mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(UpdateProfileSuccessEvent(model: onSuccess));
      });
    });
  }




}
