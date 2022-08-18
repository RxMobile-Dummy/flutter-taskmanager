import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/add_task_model.dart';

import '../../../../../../core/failure/failure.dart';
import '../../../../../../core/usecase.dart';
import '../repositories/add_task_repositories.dart';


class AddTaskUsecase extends UseCase<AddTaskModel, AddTaskParams> {
  final AddTaskRepositories? addTaskRepositories;

  AddTaskUsecase({this.addTaskRepositories});

  @override
  Stream<Either<Failure, AddTaskModel>> call(AddTaskParams params) {
    return addTaskRepositories!.addTaskCall(params);
  }



}

class AddTaskParams extends Equatable {
  String project_id;
  String name;
  String comment;
  String task_status;
  String description;
  String is_private;
  String priority;
  String assignee_id;
  String reviewer_id;
  String tag_id;
  String start_date;
  String end_date;

  AddTaskParams({
    required this.name,
    required this.end_date,
    required this.description,
    required this.start_date,
    required this.assignee_id,
    required this.comment,
    required this.is_private,
    required this.priority,
    required this.project_id,
    required this.reviewer_id,
    required this.tag_id,
    required this.task_status,
  });

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['project_id'] = this.project_id;
    data['name'] = this.name;
    data['comment'] = this.comment;
    data['task_status'] = this.task_status;
    data['description'] = this.description;
    data['is_private'] = this.is_private;
    data['priority'] = this.priority;
    data['assignee_id'] = this.assignee_id;
    data['reviewer_id'] = this.reviewer_id;
    data['tag_id'] = this.tag_id;
    data['start_date'] = this.start_date;
    data['end_date'] = this.end_date;

    return data;
  }
}