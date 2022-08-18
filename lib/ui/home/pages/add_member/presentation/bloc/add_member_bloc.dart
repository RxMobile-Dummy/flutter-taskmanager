import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/ui/home/pages/add_member/data/model/add_member_model.dart';
import 'package:task_management/ui/home/pages/add_member/domain/usecases/add_member_usecase.dart';
import 'package:task_management/ui/home/pages/add_member/presentation/bloc/add_member_event.dart';
import 'package:task_management/ui/home/pages/add_member/presentation/bloc/add_member_state.dart';

import '../../../../../../core/Strings/strings.dart';
import '../../../../../../core/base/base_bloc.dart';
import '../../../../../../core/failure/error_object.dart';
import '../../../../../../core/failure/failure.dart';
import '../../data/model/invite_project_assign_model.dart';
import '../../domain/usecases/invite_project_assign_usecase.dart';

class AddMemberBloc extends Bloc<BaseEvent, BaseState> {
  GetMemberUsecase? getMemberUsecase;
  InviteProjectAssignUsecase? inviteProjectAssignUsecase;


  AddMemberBloc(
      {required this.getMemberUsecase,required this.inviteProjectAssignUsecase})
      : super(StateLoading()) {
    on<BaseEvent>((event, emit) {
      if (event is EventRequest) {
      } else if (event is InviteProjectAssignEvent) {
        inviteProjectAssignCall(
          assignee_ids: event.assignee_ids,
          project_id: event.project_id,
        );
      } else if (event is AddMemberEvent) {
        getMemberCall();
      } else if (event is AddMemberSuccessEvent) {
        AddMemberModel? model = event.model;
        if(model?.success != true){
          emit(StateErrorGeneral(model?.error ?? ""));
        }else {
          emit(AddMemberState(model: model));
        }
      } else if (event is InviteProjectAssignSuccessEvent) {
        InviteProjectAssignModel? model = event.model;
        if(model?.status != true){
          emit(StateErrorGeneral(model?.error ?? ""));
        }else{
          emit(InviteProjectAssignState(model: model));
        }
      }else if (event is EventErrorGeneral) {
        emit(StateErrorGeneral(event.message));
      }
    });
  }


  inviteProjectAssignCall({String? project_id, String? assignee_ids}) {
    inviteProjectAssignUsecase!
        .call(InviteProjectAssignParams(
        project_id: project_id ?? "", assignee_ids: assignee_ids ?? ""))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(ErrorObject.mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(InviteProjectAssignSuccessEvent(model: onSuccess));
      });
    });
  }
  getMemberCall() {
    getMemberUsecase!
        .call(AddMemberParams( ))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(ErrorObject.mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(AddMemberSuccessEvent(model: onSuccess));
      });
    });
  }

}