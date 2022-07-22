import 'package:task_management/ui/home/fab_menu_option/add_note/data/model/add_note_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/data/model/delete_note_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/data/model/get_note_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/data/model/update_note_model.dart';

import '../../../../../../core/base/base_bloc.dart';

class AddNoteEvent extends BaseEvent {
  String project_id;
  String task_id;
  String title;
  String description;
  AddNoteEvent({required this.project_id,required this.task_id,required this.title,required this.description,});
}

class UpdateNoteEvent extends BaseEvent {
  int id;
  String title;
  String description;
  UpdateNoteEvent({required this.id,required this.title,required this.description,});
}

class DeleteNoteEvent extends BaseEvent {
  int id;
  DeleteNoteEvent({required this.id,});
}

class GetNoteEvent extends BaseEvent {
  GetNoteEvent();
}

class AddNoteSuccessEvent extends BaseEvent {
  AddNotesModel? model;

  AddNoteSuccessEvent({this.model});
}

class GetNoteSuccessEvent extends BaseEvent {
  GetNoteModel? model;

  GetNoteSuccessEvent({this.model});
}

class UpdateNoteSuccessEvent extends BaseEvent {
  UpdateNoteModel? model;

  UpdateNoteSuccessEvent({this.model});
}

class DeleteNoteSuccessEvent extends BaseEvent {
  DeleteNoteModel? model;

  DeleteNoteSuccessEvent({this.model});
}