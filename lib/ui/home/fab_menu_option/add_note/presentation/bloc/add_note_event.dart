import 'package:task_management/ui/home/fab_menu_option/add_note/data/model/add_note_model.dart';

import '../../../../../../core/base/base_bloc.dart';

class AddNoteEvent extends BaseEvent {
  String project_id;
  String task_id;
  String title;
  String description;
  AddNoteEvent({required this.project_id,required this.task_id,required this.title,required this.description,});
}

class AddNoteSuccessEvent extends BaseEvent {
  AddNotesModel? model;

  AddNoteSuccessEvent({this.model});
}