import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/get_task_model.dart';

import '../../widget/task_list.dart';
import 'fab_menu_option/add_task/presentation/bloc/add_task_bloc.dart';
import 'package:task_management/injection_container.dart' as Sl;

class TodayPage extends StatefulWidget {
  bool isFilterApply;
  bool isCompleted;

  TodayPage({required this.isCompleted, required this.isFilterApply});

  @override
  _TodayPageState createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  @override
  Widget build(BuildContext context) {
    return TaskList(
        isFilterApply: widget.isFilterApply,
        isCompleted: widget.isCompleted);
  }
}
