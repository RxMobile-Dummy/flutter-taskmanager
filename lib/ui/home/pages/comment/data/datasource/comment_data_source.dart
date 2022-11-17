import 'package:task_management/ui/home/pages/comment/data/model/add_comment_model.dart';
import 'package:task_management/ui/home/pages/comment/data/model/delete_comment_model.dart';
import 'package:task_management/ui/home/pages/comment/data/model/get_comment_model.dart';
import 'package:task_management/ui/home/pages/comment/data/model/update_comment_model.dart';
import 'package:task_management/ui/home/pages/comment/domain/usecases/add_comment_usecase.dart';
import 'package:task_management/ui/home/pages/comment/domain/usecases/get_comment_usecase.dart';
import 'package:task_management/ui/home/pages/comment/domain/usecases/update_comment_usecase.dart';

import '../../domain/usecases/delete_comment_usecase.dart';

abstract class AddCommentDataSource {
  Future<AddCommentModel> addCommentCall(AddCommentParams params);
  Future<UpdateCommentModel> updateCommentCall(UpdateCommentParams params);
  Future<DeleteCommentModel> deleteCommentCall(DeleteCommentParams params);
  Future<GetCommentModel> getCommentCall(GetCommentParams params);
}
