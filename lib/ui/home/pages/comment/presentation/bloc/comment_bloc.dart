



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/ui/home/pages/Project/domain/usecases/add_project_usecase.dart';
import 'package:task_management/ui/home/pages/Project/presentation/bloc/project_event.dart';
import 'package:task_management/ui/home/pages/Project/presentation/bloc/project_state.dart';
import 'package:task_management/ui/home/pages/comment/domain/usecases/add_comment_usecase.dart';
import 'package:task_management/ui/home/pages/comment/domain/usecases/delete_comment_usecase.dart';
import 'package:task_management/ui/home/pages/comment/domain/usecases/get_comment_usecase.dart';
import 'package:task_management/ui/home/pages/comment/domain/usecases/update_comment_usecase.dart';
import 'package:task_management/ui/home/pages/comment/presentation/bloc/comment_state.dart';

import '../../../../../../core/Strings/strings.dart';
import '../../../../../../core/base/base_bloc.dart';
import '../../../../../../core/failure/failure.dart';
import 'comment_event.dart';

class CommentBloc extends Bloc<BaseEvent, BaseState> {

  AddCommentUsecase? addCommentUsecase;
  UpdateCommentUsecase? updateCommentUsecase;
  DeleteCommentUsecase? deleteCommentUsecase;
  GetCommentUsecase? getCommentUsecase;


  CommentBloc(
      {required this.addCommentUsecase,required this.updateCommentUsecase,required this.deleteCommentUsecase,required this.getCommentUsecase}) : super(StateLoading()) {
    on<BaseEvent>((event, emit) {
      if (event is EventRequest) {
      } else if (event is AddCommentEvent) {
        addCommentCall(
          comment_user_id: event.comment_user_id,
          task_id: event.task_id,
          description: event.description,
          project_id: event.project_id,
        );
      } else if (event is UpdateCommentEvent) {
        updateCommentCall(
          id: event.id,
          comment_user_id: event.comment_user_id,
          task_id: event.task_id,
          description: event.description,
          project_id: event.project_id,
        );
      } else if (event is DeleteCommentEvent) {
        deleteCommentCall(
          id: event.id,
          comment_user_id: event.comment_user_id,
          task_id: event.task_id,
          project_id: event.project_id,
        );
      } else if (event is GetCommentEvent) {
        getCommentCall(
          id: event.id,
          comment_user_id: event.comment_user_id,
          task_id: event.task_id,
          project_id: event.project_id,
        );
      }else if (event is AddCommentSuccessEvent){
        emit(AddCommentState(model: event.model));
      }  else if (event is UpdateCommentSuccessEvent){
        emit(UpdateCommentState(model: event.model));
      }else if (event is DeleteCommentSuccessEvent){
        emit(DeleteCommentState(model: event.model));
      }else if (event is GetCommentSuccessEvent){
        emit(GetCommentState(model: event.model));
      }
    });
  }


  addCommentCall({
    String? comment_user_id,
    String? project_id,
    String? task_id,
    String? description,
  }) {
    addCommentUsecase!
        .call(AddCommentParams(
      project_id: project_id ?? "",
      description: description ?? "",
      task_id: task_id ?? "",
      comment_user_id: comment_user_id ?? "",
    ))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(_mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(AddCommentSuccessEvent(model: onSuccess));
      });
    });
  }

  updateCommentCall({
    int? id,
    String? comment_user_id,
    String? project_id,
    String? task_id,
    String? description,
  }) {
    updateCommentUsecase!
        .call(UpdateCommentParams(
      id: id ?? 0,
      project_id: project_id ?? "",
      description: description ?? "",
      task_id: task_id ?? "",
      comment_user_id: comment_user_id ?? "",
    ))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(_mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(UpdateCommentSuccessEvent(model: onSuccess));
      });
    });
  }

  deleteCommentCall({
    int? id,
    String? comment_user_id,
    String? project_id,
    String? task_id,
  }) {
    deleteCommentUsecase!
        .call(DeleteCommentParams(
      id: id ?? 0,
      project_id: project_id ?? "",
      task_id: task_id ?? "",
      comment_user_id: comment_user_id ?? "",
    ))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(_mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(DeleteCommentSuccessEvent(model: onSuccess));
      });
    });
  }

  getCommentCall({
    int? id,
    String? comment_user_id,
    String? project_id,
    String? task_id,
  }) {
    getCommentUsecase!
        .call(GetCommentParams(
      id: id ?? 0,
      project_id: project_id ?? "",
      task_id: task_id ?? "",
      comment_user_id: comment_user_id ?? "",
    ))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(_mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(GetCommentSuccessEvent(model: onSuccess));
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
