import 'package:dartz/dartz.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/data/model/add_note_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/data/model/delete_note_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/data/model/get_note_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/data/model/update_note_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/domain/usecases/get_note_usecase.dart';
import 'package:task_management/ui/home/pages/Project/domain/usecases/add_project_usecase.dart';

import '../../../../../../core/failure/failure.dart';
import '../usecases/add_note_usecase.dart';
import '../usecases/delete_note_usecase.dart';
import '../usecases/update_note_usecase.dart';

abstract class AddNoteRepositories {
  Stream<Either<Failure, AddNotesModel>> addNoteCall(AddNotesParams params);
  Stream<Either<Failure, GetNoteModel>> getNoteCall(GetNotesParams params);
  Stream<Either<Failure, UpdateNoteModel>> updateNoteCall(UpdateNoteParams params);
  Stream<Either<Failure, DeleteNoteModel>> deleteNoteCall(DeleteNoteParams params);
}