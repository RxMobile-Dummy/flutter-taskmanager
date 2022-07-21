import 'package:task_management/ui/home/pages/comment/data/model/add_comment_model.dart';
import 'package:task_management/ui/home/pages/comment/data/model/get_comment_model.dart';
import 'package:task_management/ui/home/pages/comment/data/model/update_comment_model.dart';

import '../../../../../../core/base/base_bloc.dart';
import '../../data/model/delete_comment_model.dart';

class AddCommentState extends BaseState {
  AddCommentModel? model;

  AddCommentState({this.model});
}

class UpdateCommentState extends BaseState {
  UpdateCommentModel? model;

  UpdateCommentState({this.model});
}

class DeleteCommentState extends BaseState {
  DeleteCommentModel? model;

  DeleteCommentState({this.model});
}

class GetCommentState extends BaseState {
  GetCommentModel? model;

  GetCommentState({this.model});
}
