import 'package:dartz/dartz.dart';
import 'package:task_management/ui/home/pages/comment/data/model/add_comment_model.dart';
import 'package:task_management/ui/home/pages/comment/data/model/delete_comment_model.dart';
import 'package:task_management/ui/home/pages/comment/data/model/get_comment_model.dart';
import 'package:task_management/ui/home/pages/comment/data/model/update_comment_model.dart';
import 'package:task_management/ui/home/pages/comment/domain/usecases/add_comment_usecase.dart';
import 'package:task_management/ui/home/pages/comment/domain/usecases/get_comment_usecase.dart';
import 'package:task_management/ui/home/pages/comment/domain/usecases/update_comment_usecase.dart';

import '../../../../../../core/failure/failure.dart';
import '../usecases/delete_comment_usecase.dart';

abstract class AddCommentRepositories {
  Stream<Either<Failure, AddCommentModel>> addCommentCall(AddCommentParams params);
  Stream<Either<Failure, UpdateCommentModel>> updateCommentCall(UpdateCommentParams params);
  Stream<Either<Failure, DeleteCommentModel>> deleteCommentCall(DeleteCommentParams params);
  Stream<Either<Failure, GetCommentModel>> getCommentCall(GetCommentParams params);
}
