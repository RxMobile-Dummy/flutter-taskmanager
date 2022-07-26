import 'package:dartz/dartz.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/add_task_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/delete_task_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/invite_project_assign_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/update_task.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/domain/usecases/add_task_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/domain/usecases/delete_task_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/domain/usecases/invite_project_assign_usecase.dart';

import '../../../../../../core/failure/failure.dart';
import '../usecases/update_task_usecase.dart';

abstract class AddTaskRepositories {
  Stream<Either<Failure, AddTaskModel>> addTaskCall(AddTaskParams params);
  Stream<Either<Failure, DeleteTaskModel>> deleteTaskCall(DeleteTaskParams params);
  Stream<Either<Failure, UpdateTaskModel>> updateTaskCall(UpdateTaskParams params);
  Stream<Either<Failure, InviteProjectAssignModel>> inviteProjectAssignCall(InviteProjectAssignParams params);
}
