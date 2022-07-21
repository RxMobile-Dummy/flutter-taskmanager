import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_management/features/login/data/model/forgot_password_model.dart';
import 'package:task_management/features/login/data/model/reset_passward_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/data/model/add_note_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/domain/repositories/add_note_repositories.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/add_task_model.dart';

import '../../../../../../core/failure/failure.dart';
import '../../../../../../core/usecase.dart';



class AddNoteUsecase extends UseCase<AddNotesModel, AddNotesParams> {
  final AddNoteRepositories? addNoteRepositories;

  AddNoteUsecase({this.addNoteRepositories});

  @override
  Stream<Either<Failure, AddNotesModel>> call(AddNotesParams params) {
    return addNoteRepositories!.addNoteCall(params);
  }




}

class AddNotesParams extends Equatable {
  String project_id;
  String task_id;
  String title;
  String description;

AddNotesParams({required this.description,required this.project_id,required this.title,required this.task_id});

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['project_id'] = this.project_id;
    data['task_id'] = this.task_id;
    data['title'] = this.title;
    data['description'] = this.description;

    return data;
  }
}