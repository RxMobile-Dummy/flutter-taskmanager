import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/add_task_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/delete_task_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/invite_project_assign_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/update_task.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/domain/usecases/add_task_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/domain/usecases/invite_project_assign_usecase.dart';

import '../../domain/usecases/delete_task_usecase.dart';
import '../../domain/usecases/get_task_usecase.dart';
import '../../domain/usecases/update_task_usecase.dart';
import '../model/get_task_model.dart';

abstract class AddTaskDataSource {
  Future<AddTaskModel> addTaskCall(AddTaskParams params);
  Future<DeleteTaskModel> deleteTaskCall(DeleteTaskParams params);
  Future<AddTaskModel> updateTaskCall(UpdateTaskParams params);
  Future<GetTaskModel> getTaskCall(GetTaskParams params);
  Future<InviteProjectAssignModel> inviteProjectAssignCall(InviteProjectAssignParams params);
}
