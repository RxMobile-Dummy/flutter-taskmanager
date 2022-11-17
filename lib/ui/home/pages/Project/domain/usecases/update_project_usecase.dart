import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_management/features/login/data/model/forgot_password_model.dart';
import 'package:task_management/features/login/data/model/reset_passward_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/data/model/add_note_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/domain/repositories/add_note_repositories.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/add_task_model.dart';
import 'package:task_management/ui/home/pages/Project/data/model/add_project_model.dart';
import 'package:task_management/ui/home/pages/Project/data/model/update_project_model.dart';

import '../../../../../../core/failure/failure.dart';
import '../../../../../../core/usecase.dart';
import '../repositories/project_repositories.dart';



class UpdateProjectUsecase extends UseCase<UpdateProjectModel, UpdateProjectParams> {
  final ProjectRepositories? projectRepositories;

  UpdateProjectUsecase({this.projectRepositories});

  @override
  Stream<Either<Failure, UpdateProjectModel>> call(UpdateProjectParams params) {
    return projectRepositories!.updateProjectCall(params);
  }






}

class UpdateProjectParams extends Equatable {
  int id;
  String color;
  String name;
  String description;
  String status_id;
  int duration;
  bool is_private;
  bool archive;

  UpdateProjectParams({required this.color,required this.name,required this.description,
    required this.duration,required this.is_private,required this.archive,required this.id,required this.status_id});

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();


    data['id'] = this.id;
    data['status_id'] = this.status_id;
    data['color'] = this.color;
    data['name'] = this.name;
    data['description'] = this.description;
    data['duration'] = this.duration;
    data['is_private'] = this.is_private;
    data['archive'] = this.archive;

    return data;
  }
}