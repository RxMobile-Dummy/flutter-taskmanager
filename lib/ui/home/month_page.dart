import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../custom/progress_bar.dart';
import '../../utils/calendar.dart';
import '../../utils/colors.dart';
import '../../utils/style.dart';
import '../../widget/task_list.dart';
import 'fab_menu_option/add_task/presentation/bloc/add_task_bloc.dart';

import 'fab_menu_option/add_task/presentation/bloc/add_task_event.dart';

class MonthPage extends StatefulWidget {
  var dateSelectionHandler;
  bool isFilterApply;
  bool isCompleted;
  final void Function(String) callback;

  MonthPage({required this.callback,this.dateSelectionHandler,required this.isCompleted,required this.isFilterApply});

  @override
  _MonthPageState createState() => _MonthPageState();
}

class _MonthPageState extends State<MonthPage> {
  bool isExpanded = false;
  String? date1;
  var random;
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  final Map<DateTime, List> _events = {};
   int? day;
  int currentMonth = DateTime.now().month;

  @override
  void initState() {
    super.initState();
    random = Random();
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    await _getTask(getDate: date1);
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
    date1 = outputFormat.format(inputDate).toString();
    return outputFormat.format(inputDate);
  }

  void getDate(String date) { widget.callback(date); }
  @override
  Widget build(BuildContext context) {
    return  RefreshIndicator(
      key: refreshKey,
      onRefresh: refreshList,
      child: Container(
      child: Column(
        children: [
          Card(
            margin: EdgeInsets.all(0),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            child: Calendar(
              startOnMonday: false,
              weekDays: const ["M", "T", "W", "T", "F", "S", "S"],
              events: _events,
              onRangeSelected: (range) =>
                  print("Range is ${range.from}, ${range.to}"),
              onDateSelected: (date) {
                setState(() {
                  day = date.day;
                  
                  getFormatedDate(date.toString());
                  getDate(date1 ?? "");
                  print(date1);
                });
              },
              isExpandable: true,
              isExpanded: false,
              hideArrows: true,
              eventDoneColor: CustomColors.colorBlue,
              selectedColor: Colors.pink,
              todayColor: CustomColors.colorPurple,
              eventColor: CustomColors.colorRed,
              hideTodayIcon: true,
              onMonthChanged: (DateTime month) {
                setState(() {
                  currentMonth = month.month;
                });
              },
              dayBuilder: (context, DateTime day) {
                return Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: day.month == currentMonth && day.day == this.day
                          ? CustomColors.colorBlue
                          : Colors.white),
                  child: Text(
                    "${day.day}",
                    style: CustomTextStyle.styleBold.copyWith(
                        fontSize:
                        currentMonth == day.month && day.day == this.day
                            ? 16
                            : 12,
                        color: currentMonth == day.month
                            ? day.day == DateTime.now().day
                            ? Colors.red
                            : day.day == this.day
                            ? Colors.white
                            : Colors.black
                            : Colors.grey),
                  ),
                );
              },
              bottomBarArrowColor: Colors.red,
              dayOfWeekStyle: CustomTextStyle.styleBold
                  .copyWith(fontSize: 12, color: Colors.grey.shade600),
            ),
          ),
          Expanded(
            child: TaskList(
                isFilterApply: widget.isFilterApply,
                selectedDate : date1,
                isCompleted: widget.isCompleted), /*TaskList(),*/
          ),
        ],
      ),
    ),
    );
  }
}
