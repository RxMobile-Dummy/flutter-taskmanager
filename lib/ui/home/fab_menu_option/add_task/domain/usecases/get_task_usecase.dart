import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/get_task_model.dart';

import '../../../../../../core/failure/failure.dart';
import '../../../../../../core/usecase.dart';
import '../repositories/add_task_repositories.dart';



class GetTaskUsecase extends UseCase<GetTaskModel,GetTaskParams> {
  final AddTaskRepositories? addTaskRepositories;

  GetTaskUsecase({this.addTaskRepositories});

  @override
  Stream<Either<Failure, GetTaskModel>> call(GetTaskParams params) {
    return addTaskRepositories!.getTaskCall(params);
  }

}

class GetTaskParams extends Equatable {
  String date;
  bool? isCompleted;

  GetTaskParams({required this.date,this.isCompleted});

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['date'] = this.date;
    data['isCompleted'] = this.isCompleted;
    return data;
  }

}