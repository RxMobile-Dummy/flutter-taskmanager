


import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_management/ui/home/pages/comment/data/model/add_comment_model.dart';
import 'package:task_management/ui/home/pages/comment/domain/repositories/comment_repositories.dart';

import '../../../../../../core/failure/failure.dart';
import '../../../../../../core/usecase.dart';

class AddCommentUsecase extends UseCase<AddCommentModel, AddCommentParams> {
  final AddCommentRepositories? addCommentRepositories;

  AddCommentUsecase({this.addCommentRepositories});

  @override
  Stream<Either<Failure, AddCommentModel>> call(AddCommentParams params) {
    return addCommentRepositories!.addCommentCall(params);
  }



}

class AddCommentParams extends Equatable {
  String comment_user_id;
  String project_id;
  String task_id;
  String description;

  AddCommentParams({
    required this.comment_user_id,
    required this.task_id,
    required this.description,
    required this.project_id,
  });

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['comment_user_id'] = this.comment_user_id;
    data['task_id'] = this.task_id;
    data['description'] = this.description;
    data['project_id'] = this.project_id;

    return data;
  }
}