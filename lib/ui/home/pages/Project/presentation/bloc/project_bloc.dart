



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/ui/home/pages/Project/data/model/add_project_model.dart';
import 'package:task_management/ui/home/pages/Project/data/model/delete_project_model.dart';
import 'package:task_management/ui/home/pages/Project/data/model/get_all_project_model.dart';
import 'package:task_management/ui/home/pages/Project/data/model/update_project_model.dart';
import 'package:task_management/ui/home/pages/Project/domain/usecases/add_project_usecase.dart';
import 'package:task_management/ui/home/pages/Project/domain/usecases/delete_project_usecase.dart';
import 'package:task_management/ui/home/pages/Project/domain/usecases/get_all_projects_usecase.dart';
import 'package:task_management/ui/home/pages/Project/domain/usecases/update_project_usecase.dart';
import 'package:task_management/ui/home/pages/Project/presentation/bloc/project_event.dart';
import 'package:task_management/ui/home/pages/Project/presentation/bloc/project_state.dart';
import '../../../../../../core/base/base_bloc.dart';
import '../../../../../../core/failure/error_object.dart';

class ProjectBloc extends Bloc<BaseEvent, BaseState> {

  AddProjectUsecase? addProjectUsecase;
  GetAllPeojectsUsecase? getAllPeojectsUsecase;
  UpdateProjectUsecase? updateProjectUsecase;
  DeleteProjectUsecase? deleteProjectUsecase;


  ProjectBloc(
      {required this.addProjectUsecase,required this.getAllPeojectsUsecase,required this.updateProjectUsecase,required this.deleteProjectUsecase}) : super(StateLoading()) {
    on<BaseEvent>((event, emit) {
      if (event is EventRequest) {
      } else if (event is AddProjectEvent) {
        addProjectCall(
          duration: event.duration,
          archive: event.archive,
          color: event.color,
          is_private: event.is_private,
          name: event.name,
          description: event.description,
        );
      } else if (event is UpdateProjectEvent) {
        updateProjectCall(
          id: event.id,
          status_id: event.status_id,
          duration: event.duration,
          archive: event.archive,
          color: event.color,
          is_private: event.is_private,
          name: event.name,
          description: event.description,
        );
      } else if (event is GetAllProjectsEvent) {
        getAllProjectsCall(event.id);
      }else if (event is DeleteProjectEvent) {
        deleteProjectCall(event.id);
      }else if (event is AddProjectSuccessEvent){
        AddProjectModel? model = event.model;
        if(model?.success != true){
          emit(StateErrorGeneral(model?.error ?? ""));
        }else{
          emit(AddProjectState(model: model));
        }
      }else if (event is GetAllProjectsSuccessEvent){
        GetAllProjectsModel? model = event.model;
        if(model?.success != true){
          emit(StateErrorGeneral(model?.error ?? ""));
        }else{
          emit(GetAllProjectsState(model: model));
        }
      }else if (event is UpdateProjectSuccessEvent){
        UpdateProjectModel? model = event.model;
        if(model?.success != true){
          emit(StateErrorGeneral(model?.error ?? ""));
        }else{
          emit(UpdateProjectState(model: model));
        }
      }else if (event is DeleteProjectSuccessEvent){
        DeleteProjectModel? model = event.model;
        if(model?.success != true){
          emit(StateErrorGeneral(model?.error ?? ""));
        }else{
          emit(DeleteProjectState(model: model));
        }
      }else if (event is EventErrorGeneral) {
        emit(StateErrorGeneral(event.message));
      }
    });
  }


  addProjectCall({
    String? color,
    String? name,
    String? description,
    int? duration,
    bool? is_private,
    bool? archive,
  }) {
    addProjectUsecase!
        .call(AddProjectParams(
      description: description ?? "",
      name: name ?? "",
      is_private: is_private ?? true,
      color: color ?? "",
      archive: archive ?? true,
      duration: duration ?? 0,))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(ErrorObject.mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(AddProjectSuccessEvent(model: onSuccess));
      });
    });
  }

  updateProjectCall({
    int? id,
    String? color,
    String? name,
    String? description,
    String? status_id,
    int? duration,
    bool? is_private,
    bool? archive,
  }) {
    updateProjectUsecase!
        .call(UpdateProjectParams(
      id: id ?? 0,
      status_id: status_id ?? "",
      description: description ?? "",
      name: name ?? "",
      is_private: is_private ?? true,
      color: color ?? "",
      archive: archive ?? true,
      duration: duration ?? 0,))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(ErrorObject.mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(UpdateProjectSuccessEvent(model: onSuccess));
      });
    });
  }

  getAllProjectsCall(
    int id
  ) {
    getAllPeojectsUsecase!
        .call(GetAllPeojectsParams(
      id: id))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(ErrorObject.mapFailureToMessage(onError)?? ""));
      }, (onSuccess) {
        add(GetAllProjectsSuccessEvent(model: onSuccess));
      });
    });
  }

  deleteProjectCall(
      int id
      ) {
    deleteProjectUsecase!
        .call(DeleteProjectParams(
        id: id))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(ErrorObject.mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(DeleteProjectSuccessEvent(model: onSuccess));
      });
    });
  }


}
