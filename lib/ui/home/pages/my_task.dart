import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/get_task_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/presentation/bloc/add_task_bloc.dart';
import 'package:task_management/utils/colors.dart';
import 'package:task_management/widget/task_list.dart';


import '../../../core/base/base_bloc.dart';
import '../../../custom/progress_bar.dart';
import '../../../utils/device_file.dart';
import '../../../utils/style.dart';
import '../../../widget/home_appbar.dart';
import '../fab_menu_option/add_task/data/model/delete_task_model.dart';
import '../fab_menu_option/add_task/presentation/bloc/add_task_event.dart';
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
   bool isFilterApply = false;
   bool isCompleted = false;
  //var monthPage = MonthPage();
  int selectedTaskValue = 3;
  GetTaskModel getTaskModel = GetTaskModel();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
     await _getTask();
    });
   // var todayPage =  TodayPage(isCompleted: isCompleted,isFilterApply: isFilterApply,);
    tabController = TabController(vsync: this, length: 2);
    tabController.addListener(() {});
    pageController = PageController();
    super.initState();
  }

  getFormatedDate(date) {
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(date);
    var outputFormat = DateFormat('dd/MM/yyyy');
    print(outputFormat.format(inputDate));
    return outputFormat.format(inputDate);
  }
  
  
  Future<String> _getTask({bool? isCompleted,String? getDate}) {
    return Future.delayed(const Duration()).then((_) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        title: "Work List",
        leading: Container(),
        actions: [
          BlocListener<AddTaskBloc, BaseState>(
              listener: (context, state) {
                if (state is StateOnSuccess) {
                  ProgressDialog.hideLoadingDialog(context);
                } else if (state is GetTaskState) {
                  ProgressDialog.hideLoadingDialog(context);
                  getTaskModel = state.model!;
                 if(getTaskModel.success == true){
                   Fluttertoast.cancel();
                   Fluttertoast.showToast(
                       msg: getTaskModel.message ?? "",
                       toastLength: Toast.LENGTH_LONG,
                       fontSize: DeviceUtil.isTablet ? 20 : 12,
                       backgroundColor: CustomColors.colorBlue,
                       textColor: Colors.white
                   );
                 }else{
                   Fluttertoast.cancel();
                   Fluttertoast.showToast(
                       msg: getTaskModel.error ?? "",
                       toastLength: Toast.LENGTH_LONG,
                       fontSize: DeviceUtil.isTablet ? 20 : 10,
                       backgroundColor: CustomColors.colorBlue,
                       textColor: Colors.white
                   );
                 }
                  /*ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                    content: Text(getTaskModel.message ?? ""),
                  ));*/
                  print(getTaskModel.message??"");
                }else if (state is DeleteTaskState) {
                  ProgressDialog.hideLoadingDialog(context);
                  DeleteTaskModel? model = state.model;
                  if(model!.success == true){
                    Fluttertoast.cancel();
                    Fluttertoast.showToast(
                        msg: getTaskModel.message ?? "",
                        toastLength: Toast.LENGTH_LONG,
                        fontSize: DeviceUtil.isTablet ? 20 : 12,
                        backgroundColor: CustomColors.colorBlue,
                        textColor: Colors.white
                    );
                  }else{
                    Fluttertoast.cancel();
                    Fluttertoast.showToast(
                        msg: getTaskModel.error ?? "",
                        toastLength: Toast.LENGTH_LONG,
                        fontSize: DeviceUtil.isTablet ? 20 : 12,
                        backgroundColor: CustomColors.colorBlue,
                        textColor: Colors.white
                    );
                  }
                  print(model.message ?? "");
                  // Navigator.of(context).pop();
                  // await _getTask();
                }else if (state is StateErrorGeneral) {
                  ProgressDialog.hideLoadingDialog(context);
                  Fluttertoast.cancel();
                  Fluttertoast.showToast(
                      msg: state.message,
                      toastLength: Toast.LENGTH_LONG,
                      fontSize: DeviceUtil.isTablet ? 20 : 12,
                      backgroundColor: CustomColors.colorBlue,
                      textColor: Colors.white
                  );
                }
              },
              bloc: BlocProvider.of<AddTaskBloc>(context),
              child:  BlocBuilder<AddTaskBloc, BaseState>(builder: (context, state) {
                return PopupMenuButton(
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        value: 1,
                        onTap: () async {
                          await _getTask(isCompleted: false);
                          // setState((){
                          //   isFilterApply= true;
                          //   isCompleted = false;
                          // });
                        },
                        child: Text(
                          "InCompleted Tasks",
                          style: CustomTextStyle.styleMedium.copyWith(
                            fontSize: DeviceUtil.isTablet ? 16 : 13
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        value: 2,
                        onTap: () async {
                          await _getTask(isCompleted: true);
                        },
                        child: Text(
                          "Completed Tasks",
                          style: CustomTextStyle.styleMedium.copyWith(
                              fontSize: DeviceUtil.isTablet ? 16 : 13
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        value: 3,
                        onTap: ()async{
                          await _getTask();
                        //   setState(() {
                        //     isFilterApply= false;
                        //     isCompleted = false;
                        //   });
                        },
                        child: Text(
                          "All Tasks",
                          style: CustomTextStyle.styleMedium.copyWith(
                              fontSize: DeviceUtil.isTablet ? 16 : 13
                          ),
                        ),
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
                  icon: const Icon(Icons.format_list_numbered),
                );
              })
          ),
        ],
        bottomMenu: PreferredSize(
          preferredSize: const Size(double.infinity, 96),
          child: DefaultTabController(
            length: 2,
            child: TabBar(
                onTap: (index) {
                  pageController.animateToPage(index,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut);
                },
                controller: tabController,
                labelStyle: CustomTextStyle.styleMedium.copyWith(fontSize: 18),
                indicatorColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.label,
                unselectedLabelColor: Colors.white38,
                tabs: const [
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

  getDateCallBack(String date)async{
    await _getTask(getDate: date);
  }

  Widget buildWidget(){
    return Container(
      child: PageView(
        controller: pageController,
        physics: const AlwaysScrollableScrollPhysics(),
        onPageChanged: (page) async {
          setState(()  {
            tabController.index = page;
          });
          await _getTask();
        },
        children: [
          TodayPage(isCompleted: isCompleted,isFilterApply: isFilterApply),
          MonthPage(isCompleted: isCompleted,isFilterApply: isFilterApply,callback: getDateCallBack),],
      ),
    );
  }
}
