import 'package:dartz/dartz.dart';
import 'package:task_management/core/failure/failure.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/data/datasource/add_note_data_source.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/data/model/add_note_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/domain/repositories/add_note_repositories.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/domain/usecases/add_note_usecase.dart';

class AddNotesRepositoriesImpl extends AddNoteRepositories {
  AddNoteDataSource? addNoteDataSource;

  AddNotesRepositoriesImpl({
    this.addNoteDataSource,
  });

  @override
  Stream<Either<Failure, AddNotesModel>> addNoteCall(AddNotesParams params) async*{
    try {
      var response = await addNoteDataSource!.addNotesCall(params);
      if (response != null) {
        yield Right(response);
      }
    } catch (e, s) {
      yield Left(FailureMessage(e.toString()));
      print(e);
      print("Fail");
    }
  }



}
