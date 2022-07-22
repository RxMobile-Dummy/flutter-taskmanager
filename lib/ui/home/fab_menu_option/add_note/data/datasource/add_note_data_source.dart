import 'package:task_management/ui/home/fab_menu_option/add_note/data/model/delete_note_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/data/model/get_note_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/domain/usecases/get_note_usecase.dart';

import '../../domain/usecases/add_note_usecase.dart';
import '../../domain/usecases/delete_note_usecase.dart';
import '../../domain/usecases/update_note_usecase.dart';
import '../model/add_note_model.dart';
import '../model/update_note_model.dart';

abstract class AddNoteDataSource {
  Future<AddNotesModel> addNotesCall(AddNotesParams params);
  Future<GetNoteModel> getNotesCall(GetNotesParams params);
  Future<UpdateNoteModel> updateNotesCall(UpdateNoteParams params);
  Future<DeleteNoteModel> deleteNotesCall(DeleteNoteParams params);
}
