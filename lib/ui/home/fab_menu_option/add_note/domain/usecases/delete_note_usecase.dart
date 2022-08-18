import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/data/model/delete_note_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/domain/repositories/add_note_repositories.dart';
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