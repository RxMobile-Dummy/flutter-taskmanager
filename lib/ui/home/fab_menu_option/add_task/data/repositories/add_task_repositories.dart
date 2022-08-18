
import 'package:dartz/dartz.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/datasource/add_task_data_sourse.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/add_task_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/delete_task_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/get_task_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/domain/usecases/add_task_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/domain/usecases/delete_task_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/domain/usecases/get_task_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/domain/usecases/update_task_usecase.dart';
import '../../../../../../core/failure/error_object.dart';
import '../../../../../../core/failure/failure.dart';
import '../../domain/repositories/add_task_repositories.dart';


class AddTaskRepositoriesImpl extends AddTaskRepositories {
  AddTaskDataSource? addTaskDataSource;

  AddTaskRepositoriesImpl({
    this.addTaskDataSource,
  });


  @override
  Stream<Either<Failure, AddTaskModel>> addTaskCall(AddTaskParams params) async* {
    try {
      var response = await addTaskDataSource!.addTaskCall(params);
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
  Stream<Either<Failure, DeleteTaskModel>> deleteTaskCall(DeleteTaskParams params) async* {
    try {
      var response = await addTaskDataSource!.deleteTaskCall(params);
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
  Stream<Either<Failure, AddTaskModel>> updateTaskCall(UpdateTaskParams params) async* {
    try {
      var response = await addTaskDataSource!.updateTaskCall(params);
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
  Stream<Either<Failure, GetTaskModel>> getTaskCall(GetTaskParams params) async* {
    try {
      var response = await addTaskDataSource!.getTaskCall(params);
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
