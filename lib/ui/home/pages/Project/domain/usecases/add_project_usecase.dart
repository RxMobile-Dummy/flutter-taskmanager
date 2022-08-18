import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_management/ui/home/pages/Project/data/model/add_project_model.dart';

import '../../../../../../core/failure/failure.dart';
import '../../../../../../core/usecase.dart';
import '../repositories/project_repositories.dart';



class AddProjectUsecase extends UseCase<AddProjectModel, AddProjectParams> {
  final ProjectRepositories? projectRepositories;

  AddProjectUsecase({this.projectRepositories});

  @override
  Stream<Either<Failure, AddProjectModel>> call(AddProjectParams params) {
    return projectRepositories!.addProjectCall(params);
  }






}

class AddProjectParams extends Equatable {
  String color;
  String name;
  String description;
  int duration;
  bool is_private;
  bool archive;

  AddProjectParams({required this.color,required this.name,required this.description,
    required this.duration,required this.is_private,required this.archive});

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['color'] = this.color;
    data['name'] = this.name;
    data['description'] = this.description;
    data['duration'] = this.duration;
    data['is_private'] = this.is_private;
    data['archive'] = this.archive;

    return data;
  }
}