
import 'package:dartz/dartz.dart';
import 'package:task_management/core/failure/failure.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/data/datasource/add_note_data_source.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/data/model/add_note_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/data/model/delete_note_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/data/model/get_note_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/data/model/update_note_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/domain/repositories/add_note_repositories.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/domain/usecases/add_note_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/domain/usecases/delete_note_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/domain/usecases/get_note_usecase.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/domain/usecases/update_note_usecase.dart';
import '../../../../../../core/failure/error_object.dart';

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
      Failure error = await ErrorObject.checkErrorState(e);
      yield Left(FailureMessage(error.message.toString()));
      print(e);
      print("Fail");
    }
  }


  @override
  Stream<Either<Failure, GetNoteModel>> getNoteCall(GetNotesParams params) async* {
    try {
      var response = await addNoteDataSource!.getNotesCall(params);
      if (response != null) {
        yield Right(response);
      }
    } catch (e, s) {
      Failure error = await ErrorObject.checkErrorState(e);
      yield Left(FailureMessage(error.message.toString()));
      print(e);
      print("Fail");
    }
  }

  @override
  Stream<Either<Failure, UpdateNoteModel>> updateNoteCall(UpdateNoteParams params)async* {
    try {
      var response = await addNoteDataSource!.updateNotesCall(params);
      if (response != null) {
        yield Right(response);
      }
    } catch (e, s) {
      Failure error = await ErrorObject.checkErrorState(e);
      yield Left(FailureMessage(error.message.toString()));
      print(e);
      print("Fail");
    }
  }

  @override
  Stream<Either<Failure, DeleteNoteModel>> deleteNoteCall(DeleteNoteParams params) async* {
    try {
      var response = await addNoteDataSource!.deleteNotesCall(params);
      if (response != null) {
        yield Right(response);
      }
    } catch (e, s) {
      Failure error = await ErrorObject.checkErrorState(e);
      yield Left(FailureMessage(error.message.toString()));
      print(e);
      print("Fail");
    }
  }



}
