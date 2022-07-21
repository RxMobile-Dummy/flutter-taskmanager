import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_management/features/login/data/model/forgot_password_model.dart';
import 'package:task_management/features/login/data/model/reset_passward_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/add_task_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/invite_project_assign_model.dart';

import '../../../../../../core/failure/failure.dart';
import '../../../../../../core/usecase.dart';
import '../../../../../../features/login/domain/repositories/login_repositories.dart';
import '../repositories/add_task_repositories.dart';


class InviteProjectAssignUsecase extends UseCase<InviteProjectAssignModel, InviteProjectAssignParams> {
  final AddTaskRepositories? addTaskRepositories;

  InviteProjectAssignUsecase({this.addTaskRepositories});

  @override
  Stream<Either<Failure, InviteProjectAssignModel>> call(InviteProjectAssignParams params) {
    return addTaskRepositories!.inviteProjectAssignCall(params);
  }



}

class InviteProjectAssignParams extends Equatable {
  String project_id;
  String assignee_ids;

  InviteProjectAssignParams({
    required this.project_id,
    required this.assignee_ids,
  });

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['project_id'] = this.project_id;
    data['assignee_ids'] =  this.assignee_ids;

    return data;
  }
}