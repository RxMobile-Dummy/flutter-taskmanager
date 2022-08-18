import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/delete_task_model.dart';

import '../../../../../../core/failure/failure.dart';
import '../../../../../../core/usecase.dart';
import '../repositories/add_task_repositories.dart';


class DeleteTaskUsecase extends UseCase<DeleteTaskModel, DeleteTaskParams> {
  final AddTaskRepositories? addTaskRepositories;

  DeleteTaskUsecase({this.addTaskRepositories});

  @override
  Stream<Either<Failure, DeleteTaskModel>> call(DeleteTaskParams params) {
    return addTaskRepositories!.deleteTaskCall(params);
  }


}

class DeleteTaskParams extends Equatable {
  int id1;

 DeleteTaskParams({required this.id1});

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id1;
    return data;
  }
}