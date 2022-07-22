import 'package:task_management/ui/home/pages/comment/data/model/add_comment_model.dart';
import 'package:task_management/ui/home/pages/comment/data/model/delete_comment_model.dart';
import 'package:task_management/ui/home/pages/comment/data/model/get_comment_model.dart';
import 'package:task_management/ui/home/pages/comment/data/model/update_comment_model.dart';

import '../../../../../../core/base/base_bloc.dart';

class AddCommentEvent extends BaseEvent {
  int comment_user_id;
  String description;
  List<String> files;


  AddCommentEvent({required this.description,required this.files,required this.comment_user_id});
}

class UpdateCommentEvent extends BaseEvent {
  int id;
  String comment_user_id;
  String task_id;
  String description;


  UpdateCommentEvent({
    required this.id,required this.description,required this.task_id,required this.comment_user_id});
}

class DeleteCommentEvent extends BaseEvent {
  int id;
  String comment_user_id;


  DeleteCommentEvent({
    required this.id,
    required this.comment_user_id,});
}

class GetCommentEvent extends BaseEvent {
  String comment_user_id;


  GetCommentEvent({
    required this.comment_user_id,});
}


class AddCommentSuccessEvent extends BaseEvent {
  AddCommentModel? model;

  AddCommentSuccessEvent({this.model,});
}

class UpdateCommentSuccessEvent extends BaseEvent {
  UpdateCommentModel? model;

  UpdateCommentSuccessEvent({this.model,});
}


class DeleteCommentSuccessEvent extends BaseEvent {
  DeleteCommentModel? model;

  DeleteCommentSuccessEvent({this.model,});
}

class GetCommentSuccessEvent extends BaseEvent {
  GetCommentModel? model;

  GetCommentSuccessEvent({this.model});
}

