

import 'package:task_management/features/login/data/model/forgot_password_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/data/model/add_note_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/add_task_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/delete_task_model.dart';

import '../../../../../../core/base/base_bloc.dart';



class AddNoteState extends BaseState {
  AddNotesModel? model;

  AddNoteState({this.model});
}

