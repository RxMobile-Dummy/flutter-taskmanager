
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/features/login/domain/usecases/forgot_password_uasecase.dart';
import 'package:task_management/features/login/domain/usecases/reset_passward_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/domain/usecases/add_task_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/domain/usecases/delete_task_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/domain/usecases/invite_project_assign_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/domain/usecases/update_task_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/presentation/bloc/add_task_event.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/presentation/bloc/add_task_state.dart';

import '../../../../../../core/Strings/strings.dart';
import '../../../../../../core/base/base_bloc.dart';
import '../../../../../../core/failure/failure.dart';


class AddTaskBloc extends Bloc<BaseEvent, BaseState> {

  AddTaskUsecase? addTaskUsecase;
  UpdateTaskUsecase? updateTaskUsecase;
  DeleteTaskUsecase? deleteTaskUsecase;
  InviteProjectAssignUsecase? inviteProjectAssignUsecase;


  AddTaskBloc(
      {required this.addTaskUsecase,required this.deleteTaskUsecase,required this.updateTaskUsecase,required this.inviteProjectAssignUsecase}) : super(StateLoading()) {
    on<BaseEvent>((event, emit) {
      if (event is EventRequest) {
      } else if (event is AddTaskEvent) {
        addTskCall(
          task_status: event.task_status,
          tag_id: event.tag_id,
          reviewer_id: event.reviewer_id,
          project_id: event.project_id,
          priority: event.priority,
          is_private: event.is_private,
          comment: event.comment,
          assignee_id: event.assignee_id,
          description: event.description,
          name: event.name,
          endDate: event.end_date,
          startDate: event.start_date,
        );
      }else if (event is UpdateTaskEvent) {
        updateTskCall(
          id: event.id,
          task_status: event.task_status,
          tag_id: event.tag_id,
          reviewer_id: event.reviewer_id,
          project_id: event.project_id,
          priority: event.priority,
          is_private: event.is_private,
          comment: event.comment,
          assignee_id: event.assignee_id,
          description: event.description,
          name: event.name,
          endDate: event.end_date,
          startDate: event.start_date,
        );
      }else if(event is DeleteTaskEvent){
        deleteTskCall(id: event.id);
      }else if(event is InviteProjectAssignEvent){
        inviteProjectAssignCall(
          assignee_ids: event.assignee_ids,
          project_id: event.project_id,
        );
      }else if (event is AddTaskSuccessEvent){
        emit(AddTaskState(model: event.model));
      }else if (event is DeleteTaskSuccessEvent){
        emit(DeleteTaskState(model: event.model));
      }else if (event is UpdateTaskSuccessEvent){
        emit(UpdateTaskState(model: event.model));
      }else if (event is InviteProjectAssignSuccessEvent){
        emit(InviteProjectAssignState(model: event.model));
      }
    });
  }


  addTskCall({
    String? name,
    String? startDate,
  String? endDate,
  String? description,
  String? assignee_id,
  String? comment,
  String? is_private,
  String? priority,
  String? project_id,
  String? reviewer_id,
  String? tag_id,
  String? task_status,}) {
    addTaskUsecase!
        .call(AddTaskParams(
    name: name ?? "",
      start_date: startDate ?? "",
      end_date: endDate ?? "",
      description: description ?? "",
      assignee_id: assignee_id ?? "",
      comment: comment ?? "",
      is_private: is_private ?? "",
      priority: priority ?? "",
      project_id: project_id ?? "",
      reviewer_id: reviewer_id ?? "",
      tag_id: tag_id ?? "",
      task_status: task_status ?? "",
    ))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(_mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(AddTaskSuccessEvent(model: onSuccess));
      });
    });
  }

  updateTskCall({
    String? id,
    String? name,
    String? startDate,
    String? endDate,
    String? description,
    String? assignee_id,
    String? comment,
    String? is_private,
    String? priority,
    String? project_id,
    String? reviewer_id,
    String? tag_id,
    String? task_status,}) {
    updateTaskUsecase!
        .call(UpdateTaskParams(
      id: id ?? "",
      name: name ?? "",
      start_date: startDate ?? "",
      end_date: endDate ?? "",
      description: description ?? "",
      assignee_id: assignee_id ?? "",
      comment: comment ?? "",
      is_private: is_private ?? "",
      priority: priority ?? "",
      project_id: project_id ?? "",
      reviewer_id: reviewer_id ?? "",
      tag_id: tag_id ?? "",
      task_status: task_status ?? "",
    ))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(_mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(UpdateTaskSuccessEvent(model: onSuccess));
      });
    });
  }

  deleteTskCall({String? id}) {
    deleteTaskUsecase!
        .call(DeleteTaskParams(id1: id ?? "" ))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(_mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(DeleteTaskSuccessEvent(model: onSuccess));
      });
    });
  }

  inviteProjectAssignCall({String? project_id,String? assignee_ids}) {
    inviteProjectAssignUsecase!
        .call(InviteProjectAssignParams(
      project_id: project_id ?? "",
      assignee_ids: assignee_ids ?? ""
    ))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(_mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(InviteProjectAssignSuccessEvent(model: onSuccess));
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
