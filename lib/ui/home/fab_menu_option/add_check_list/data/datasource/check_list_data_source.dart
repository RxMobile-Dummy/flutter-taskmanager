import 'package:task_management/ui/home/fab_menu_option/add_check_list/data/model/add_check_list_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/data/model/delete_check_list_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/data/model/get_check_list_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/data/model/update_check_list_model.dart';

import '../../domain/usecases/add_check_list_usecase.dart';
import '../../domain/usecases/delete_check_list_usecase.dart';
import '../../domain/usecases/get_check_list_usecase.dart';
import '../../domain/usecases/update_check_list_usecase.dart';

abstract class AddCheckListDataSource {
  Future<AddCheckListModel> addCheckListCall(AddCheckListParams params);
  Future<GetCheckListModel> getCheckListCall(GetCheckListParams params);
  Future<DeleteCheckListModel> deleteCheckListCall(DeleteCheckListParams params);
  Future<UpdateCheckListModel> updateCheckListCall(UpdateCheckListParams params);
}