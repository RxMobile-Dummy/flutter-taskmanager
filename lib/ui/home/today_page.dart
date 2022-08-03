import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/get_task_model.dart';
import 'package:task_management/utils/colors.dart';

import '../../custom/progress_bar.dart';
import '../../widget/task_list.dart';
import 'fab_menu_option/add_task/presentation/bloc/add_task_bloc.dart';
import 'package:task_management/injection_container.dart' as Sl;

import 'fab_menu_option/add_task/presentation/bloc/add_task_event.dart';

class TodayPage extends StatefulWidget {
  bool isFilterApply;
  bool isCompleted;

  TodayPage({required this.isCompleted, required this.isFilterApply});

  @override
  _TodayPageState createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  var random;
  var refreshKey = GlobalKey<RefreshIndicatorState>();


  @override
  void initState() {
    super.initState();
    random = Random();
   // refreshList();
  }


  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
      await _getTask();
    return null;
  }

  Future<String> _getTask({bool? isCompleted,String? getDate}) {
    return Future.delayed(Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<AddTaskBloc>(context).add(
          GetTaskEvent(
              date: (getDate == null || getDate == "")
                  ? getFormatedDate(DateTime.now().toString())
                  : getDate,
              isCompleted: isCompleted));
      return "";
    });
  }

  getFormatedDate(date) {
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(date);
    var outputFormat = DateFormat('dd/MM/yyyy');
    print(outputFormat.format(inputDate));
    return outputFormat.format(inputDate);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: refreshKey,
      onRefresh: refreshList,
      color: CustomColors.colorBlue,
      child: TaskList(
          isFilterApply: widget.isFilterApply,
          isCompleted: widget.isCompleted),
    );
  }
}
