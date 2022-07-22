import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_management/features/login/data/model/forgot_password_model.dart';
import 'package:task_management/features/login/data/model/reset_passward_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/data/model/add_note_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/data/model/delete_note_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/data/model/get_note_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/data/model/update_note_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/domain/repositories/add_note_repositories.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/add_task_model.dart';

import '../../../../../../core/failure/failure.dart';
import '../../../../../../core/usecase.dart';



class DeleteNoteUsecase extends UseCase<DeleteNoteModel,DeleteNoteParams> {
  final AddNoteRepositories? addNoteRepositories;

  DeleteNoteUsecase({this.addNoteRepositories});

  @override
  Stream<Either<Failure, DeleteNoteModel>> call(DeleteNoteParams params) {
    return addNoteRepositories!.deleteNoteCall(params);
  }

}

class DeleteNoteParams extends Equatable {
  int id;

  DeleteNoteParams({required this.id,});
  @override
  List<Object> get props => [id];

}