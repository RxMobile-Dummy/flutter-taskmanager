


import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_management/ui/home/pages/comment/data/model/add_comment_model.dart';
import 'package:task_management/ui/home/pages/comment/data/model/update_comment_model.dart';
import 'package:task_management/ui/home/pages/comment/domain/repositories/comment_repositories.dart';

import '../../../../../../core/failure/failure.dart';
import '../../../../../../core/usecase.dart';

class UpdateCommentUsecase extends UseCase<UpdateCommentModel, UpdateCommentParams> {
  final AddCommentRepositories? addCommentRepositories;

  UpdateCommentUsecase({this.addCommentRepositories});

  @override
  Stream<Either<Failure, UpdateCommentModel>> call(UpdateCommentParams params) {
    return addCommentRepositories!.updateCommentCall(params);
  }



}

class UpdateCommentParams extends Equatable {
  int id;
  String comment_user_id;
  String project_id;
  String task_id;
  String description;

  UpdateCommentParams({
    required this.id,
    required this.comment_user_id,
    required this.task_id,
    required this.description,
    required this.project_id,
  });

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['comment_user_id'] = this.comment_user_id;
    data['task_id'] = this.task_id;
    data['description'] = this.description;
    data['project_id'] = this.project_id;

    return data;
  }
}