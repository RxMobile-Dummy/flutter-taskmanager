

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/domain/usecases/add_note_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/domain/usecases/delete_note_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/domain/usecases/get_note_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/domain/usecases/update_note_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/presentation/bloc/add_note_event.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/presentation/bloc/add_note_state.dart';

import '../../../../../../core/Strings/strings.dart';
import '../../../../../../core/base/base_bloc.dart';
import '../../../../../../core/failure/failure.dart';

class AddNoteBloc extends Bloc<BaseEvent, BaseState> {

 AddNoteUsecase? addNoteUsecase;
 GetNoteUsecase? getNoteUsecase;
 UpdateNoteUsecase? updateNoteUsecase;
 DeleteNoteUsecase? deleteNoteUsecase;


 AddNoteBloc(
      {required this.addNoteUsecase,required this.getNoteUsecase,required this.updateNoteUsecase,required this.deleteNoteUsecase}) : super(StateLoading()) {
    on<BaseEvent>((event, emit) {
      if (event is EventRequest) {
      } else if (event is AddNoteEvent) {
        addNoteCall(
          task_id: event.task_id,
          title: event.title,
          project_id: event.project_id,
          description: event.description,
        );
      }else if (event is UpdateNoteEvent) {
        updateNoteCall(
         title: event.title,
          description: event.description,
          id: event.id,
        );
      }else if (event is DeleteNoteEvent) {
        deleteNoteCall(
          id: event.id,
        );
      }
      else if (event is GetNoteEvent) {
        getNoteCall();
      }else if (event is AddNoteSuccessEvent){
        emit(AddNoteState(model: event.model));
      }else if (event is GetNoteSuccessEvent){
        emit(GetNoteState(model: event.model));
      }else if (event is UpdateNoteSuccessEvent){
        emit(UpdateNoteState(model: event.model));
      }else if (event is DeleteNoteSuccessEvent){
        emit(DeleteNoteState(model: event.model));
      }
    });
  }


  addNoteCall({
    String? description,
    String? project_id,
    String? title,
    String? task_id,
  }) {
    addNoteUsecase!
        .call(AddNotesParams(
      description: description ?? "",
      project_id: project_id ?? "",
      title: title ?? "",
      task_id: task_id ?? "",
    ))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(_mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(AddNoteSuccessEvent(model: onSuccess));
      });
    });
  }

 updateNoteCall({
   int? id,
   String? description,
   String? title,
 }) {
   updateNoteUsecase!
       .call(UpdateNoteParams(
     id: id ?? 0,
     description: description ?? "",
     title: title ?? ""
   ))
       .listen((data) {
     data.fold((onError) {
       add(EventErrorGeneral(_mapFailureToMessage(onError) ?? ""));
     }, (onSuccess) {
       add(UpdateNoteSuccessEvent(model: onSuccess));
     });
   });
 }

 deleteNoteCall({
   int? id,
 }) {
   deleteNoteUsecase!
       .call(DeleteNoteParams(
       id: id ?? 0,
   ))
       .listen((data) {
     data.fold((onError) {
       add(EventErrorGeneral(_mapFailureToMessage(onError) ?? ""));
     }, (onSuccess) {
       add(DeleteNoteSuccessEvent(model: onSuccess));
     });
   });
 }

 getNoteCall() {
   getNoteUsecase!
       .call(GetNotesParams())
       .listen((data) {
     data.fold((onError) {
       add(EventErrorGeneral(_mapFailureToMessage(onError) ?? ""));
     }, (onSuccess) {
       add(GetNoteSuccessEvent(model: onSuccess));
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
