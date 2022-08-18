
import 'package:dartz/dartz.dart';
import 'package:task_management/core/failure/failure.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/data/datasource/check_list_data_source.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/data/model/add_check_list_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/data/model/delete_check_list_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/data/model/get_check_list_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/data/model/update_check_list_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/domain/repositories/check_list_repositories.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/domain/usecases/add_check_list_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/domain/usecases/delete_check_list_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/domain/usecases/get_check_list_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_check_list/domain/usecases/update_check_list_usecase.dart';
import '../../../../../../core/failure/error_object.dart';

class AddCheckListRepositoriesImpl extends AddCheckListRepositories {
  AddCheckListDataSource? addCheckListDataSource;

  AddCheckListRepositoriesImpl({
    this.addCheckListDataSource,
  });




  @override
  Stream<Either<Failure, AddCheckListModel>> addCheckListCall(AddCheckListParams params) async* {
    try {
      var response = await addCheckListDataSource!.addCheckListCall(params);
      if (response != null) {
        yield Right(response);
      }
    } catch (e, s) {
      Failure error = await ErrorObject.checkErrorState(e);
      yield Left(FailureMessage(error.message.toString()));
      print(e);
      print("Fail");
    }
  }

  @override
  Stream<Either<Failure, GetCheckListModel>> getCheckListCall(GetCheckListParams params) async* {
    try {
      var response = await addCheckListDataSource!.getCheckListCall(params);
      if (response != null) {
        yield Right(response);
      }
    } catch (e, s) {
      Failure error = await ErrorObject.checkErrorState(e);
      yield Left(FailureMessage(error.message.toString()));
      print(e);
      print("Fail");
    }
  }

  @override
  Stream<Either<Failure, DeleteCheckListModel>> deleteCheckListCall(DeleteCheckListParams params) async*{
    try {
      var response = await addCheckListDataSource!.deleteCheckListCall(params);
      if (response != null) {
        yield Right(response);
      }
    } catch (e, s) {
      Failure error = await ErrorObject.checkErrorState(e);
      yield Left(FailureMessage(error.message.toString()));
      print(e);
      print("Fail");
    }
  }

  @override
  Stream<Either<Failure, UpdateCheckListModel>> updateCheckListCall(UpdateCheckListParams params) async* {
    try {
      var response = await addCheckListDataSource!.updateCheckListCall(params);
      if (response != null) {
        yield Right(response);
      }
    } catch (e, s) {
      Failure error = await ErrorObject.checkErrorState(e);
      yield Left(FailureMessage(error.message.toString()));
      print(e);
      print("Fail");
    }
  }


}