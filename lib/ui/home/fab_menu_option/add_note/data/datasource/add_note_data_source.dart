import '../../domain/usecases/add_note_usecase.dart';
import '../model/add_note_model.dart';

abstract class AddNoteDataSource {
  Future<AddNotesModel> addNotesCall(AddNotesParams params);
}
