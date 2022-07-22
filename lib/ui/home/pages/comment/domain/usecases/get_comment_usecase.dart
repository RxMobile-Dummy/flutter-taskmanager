

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_management/ui/home/pages/comment/data/model/get_comment_model.dart';

import '../../../../../../core/failure/failure.dart';
import '../../../../../../core/usecase.dart';
import '../repositories/comment_repositories.dart';

class GetCommentUsecase extends UseCase<GetCommentModel, GetCommentParams> {
  final AddCommentRepositories? addCommentRepositories;

  GetCommentUsecase({this.addCommentRepositories});

  @override
  Stream<Either<Failure, GetCommentModel>> call(GetCommentParams params) {
    return addCommentRepositories!.getCommentCall(params);
  }



}

class GetCommentParams extends Equatable {
  String comment_user_id;

  GetCommentParams({
    required this.comment_user_id,
  });

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['comment_user_id'] = this.comment_user_id;

    return data;
  }
}