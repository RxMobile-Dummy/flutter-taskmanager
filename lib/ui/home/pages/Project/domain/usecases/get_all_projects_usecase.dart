import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_management/features/login/data/model/forgot_password_model.dart';
import 'package:task_management/features/login/data/model/reset_passward_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/data/model/add_note_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/domain/repositories/add_note_repositories.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/add_task_model.dart';
import 'package:task_management/ui/home/pages/Project/data/model/add_project_model.dart';
import 'package:task_management/ui/home/pages/Project/data/model/get_all_project_model.dart';

import '../../../../../../core/failure/failure.dart';
import '../../../../../../core/usecase.dart';
import '../repositories/project_repositories.dart';



class GetAllPeojectsUsecase extends UseCase<GetAllProjectsModel, GetAllPeojectsParams> {
  final ProjectRepositories? projectRepositories;

  GetAllPeojectsUsecase({this.projectRepositories});

  @override
  Stream<Either<Failure, GetAllProjectsModel>> call(GetAllPeojectsParams params) {
    return projectRepositories!.getAllPeojectsCall(params);
  }






}

class GetAllPeojectsParams extends Equatable {
  int id;

  GetAllPeojectsParams({required this.id});

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;

    return data;
  }
}