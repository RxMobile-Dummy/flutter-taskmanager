import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/get_task_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/presentation/bloc/add_task_bloc.dart';
import 'package:task_management/widget/task_list.dart';


import '../../../core/base/base_bloc.dart';
import '../../../custom/progress_bar.dart';
import '../../../utils/style.dart';
import '../../../widget/home_appbar.dart';
import '../fab_menu_option/add_task/data/model/delete_task_model.dart';
import '../fab_menu_option/add_task/presentation/bloc/add_task_state.dart';
import '../month_page.dart';
import '../today_page.dart';

class MyTask extends StatefulWidget {
  @override
  _MyTaskState createState() => _MyTaskState();
}

class _MyTaskState extends State<MyTask> with SingleTickerProviderStateMixin {
  late TabController tabController;
  late PageController pageController;
  var todayPage =  TodayPage();
  var monthPage = MonthPage();
  int selectedTaskValue = 3;
  GetTaskModel getTaskModel = GetTaskModel();

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
    tabController.addListener(() {});
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        title: "Work List",
        leading: Container(),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Text(
                    "InCompleted Tasks",
                    style: CustomTextStyle.styleMedium,
                  ),
                  value: 1,
                ),
                PopupMenuItem(
                  child: Text(
                    "Completed Tasks",
                    style: CustomTextStyle.styleMedium,
                  ),
                  value: 2,
                ),
                PopupMenuItem(
                  child: Text(
                    "All Tasks",
                    style: CustomTextStyle.styleMedium,
                  ),
                  value: 3,
                ),
              ];
            },
            onSelected: (int value) {
              setState(() {
                selectedTaskValue = value;
              });
            },
            initialValue: selectedTaskValue,
            offset: Offset(
                0,
                selectedTaskValue == 3
                    ? 300
                    : selectedTaskValue == 2 ? 200 : 100),
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            icon: Icon(Icons.format_list_numbered),
          )
        ],
        bottomMenu: PreferredSize(
          preferredSize: Size(double.infinity, 96),
          child: DefaultTabController(
            length: 2,
            child: TabBar(
                onTap: (index) {
                  pageController.animateToPage(index,
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeInOut);
                },
                controller: tabController,
                labelStyle: CustomTextStyle.styleMedium.copyWith(fontSize: 18),
                indicatorColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.label,
                unselectedLabelColor: Colors.white38,
                tabs: [
                  Tab(
                    child: Text(
                      "Today",
                    ),
                  ),
                  Tab(
                    child: Text("Month",),
                  ),
                ]),
          ),
        ),
      ).build(),
      body: buildWidget()/*BlocListener<AddTaskBloc, BaseState>(
          listener: (context, state) {
            if (state is StateOnSuccess) {
              ProgressDialog.hideLoadingDialog(context);
            } else if (state is GetTaskState) {
              ProgressDialog.hideLoadingDialog(context);
              getTaskModel = state.model!;
              print(getTaskModel.message??"");
              Navigator.of(context).pop();
            }else if (state is StateErrorGeneral) {
              ProgressDialog.hideLoadingDialog(context);
            }
          },
          bloc: BlocProvider.of<AddTaskBloc>(context),
          child:  BlocBuilder<AddTaskBloc, BaseState>(builder: (context, state) {
            return buildWidget();
          })
      ),*/
    );
  }

  Widget buildWidget(){
    return Container(
      child: PageView(
        controller: pageController,
        onPageChanged: (page) {
          setState(() {
            tabController.index = page;
          });
        },
        children: [
          todayPage, monthPage],
      ),
    );
  }
}
