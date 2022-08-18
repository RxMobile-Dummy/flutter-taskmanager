


import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_management/ui/home/pages/comment/data/model/delete_comment_model.dart';
import 'package:task_management/ui/home/pages/comment/domain/repositories/comment_repositories.dart';

import '../../../../../../core/failure/failure.dart';
import '../../../../../../core/usecase.dart';

class DeleteCommentUsecase extends UseCase<DeleteCommentModel, DeleteCommentParams> {
  final AddCommentRepositories? addCommentRepositories;

  DeleteCommentUsecase({this.addCommentRepositories});

  @override
  Stream<Either<Failure, DeleteCommentModel>> call(DeleteCommentParams params) {
    return addCommentRepositories!.deleteCommentCall(params);
  }



}

class DeleteCommentParams extends Equatable {
  int id;
  String comment_user_id;

  DeleteCommentParams({
    required this.id,
    required this.comment_user_id,
  });

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['comment_user_id'] = this.comment_user_id;

    return data;
  }
}