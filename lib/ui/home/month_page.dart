import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/calendar.dart';
import '../../utils/colors.dart';
import '../../utils/style.dart';
import '../../widget/task_list.dart';
import 'fab_menu_option/add_task/presentation/bloc/add_task_bloc.dart';
import 'package:task_management/injection_container.dart' as Sl;

class MonthPage extends StatefulWidget {
  var dateSelectionHandler;

  MonthPage({Key? key, this.dateSelectionHandler}) : super(key: key);

  @override
  _MonthPageState createState() => _MonthPageState();
}

class _MonthPageState extends State<MonthPage> {
  bool isExpanded = false;

  final Map<DateTime, List> _events = {};
   int? day;
  int currentMonth = DateTime.now().month;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Card(
            margin: EdgeInsets.all(0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            child: Calendar(
              startOnMonday: false,
              weekDays: ["M", "T", "W", "T", "F", "S", "S"],
              events: _events,
              onRangeSelected: (range) =>
                  print("Range is ${range.from}, ${range.to}"),
              onDateSelected: (date) {
                setState(() {
                  day = date.day;
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
            child: BlocProvider<AddTaskBloc>(
              create: (context) => Sl.Sl<AddTaskBloc>(),
              child: TaskList(),
            ), /*TaskList(),*/
          )
        ],
      ),
    );
  }
}
