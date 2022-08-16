import 'package:dartz/dartz.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/data/model/add_check_list_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/data/model/delete_check_list_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/data/model/get_check_list_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/data/model/update_check_list_model.dart';

import '../../../../../../core/failure/failure.dart';
import '../usecases/add_check_list_usecase.dart';
import '../usecases/delete_check_list_usecase.dart';
import '../usecases/get_check_list_usecase.dart';
import '../usecases/update_check_list_usecase.dart';

abstract class AddCheckListRepositories {
  Stream<Either<Failure, AddCheckListModel>> addCheckListCall(AddCheckListParams params);
  Stream<Either<Failure, GetCheckListModel>> getCheckListCall(GetCheckListParams params);
  Stream<Either<Failure, DeleteCheckListModel>> deleteCheckListCall(DeleteCheckListParams params);
  Stream<Either<Failure, UpdateCheckListModel>> updateCheckListCall(UpdateCheckListParams params);
}