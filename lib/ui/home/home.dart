import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/presentation/bloc/add_note_bloc.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/add_task_model.dart';
import 'package:task_management/ui/home/pages/Profile/presentation/bloc/profile_bloc.dart';
import 'package:task_management/ui/home/pages/Project/presentation/bloc/project_bloc.dart';
import 'package:task_management/ui/home/pages/my_task.dart';
import 'package:task_management/ui/home/pages/Project/presentation/pages/project.dart';
import 'package:task_management/ui/home/pages/Profile/presentation/pages/profile.dart';
import 'package:task_management/ui/home/pages/quick_notes.dart';
import 'package:task_management/ui/home/pages/user_status/presentation/bloc/user_status_bloc.dart';

import '../../custom/progress_bar.dart';
import '../../utils/style.dart';
import 'fab_menu_option/add_check_list.dart';
import 'fab_menu_option/add_note/presentation/pages/add_note.dart';
import 'fab_menu_option/add_task/presentation/bloc/add_task_bloc.dart';
import 'fab_menu_option/add_task/presentation/bloc/add_task_event.dart';
import 'fab_menu_option/add_task/presentation/pages/add_task.dart';
import 'package:task_management/injection_container.dart' as Sl;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Widget myTask;
  Widget dashboardWidget = BlocProvider<ProjectBloc>(
    create: (context) => Sl.Sl<ProjectBloc>(),
    child: Project(),
  );

  /* Project();*/
  Widget quickNoteWidget = BlocProvider<AddNoteBloc>(
    create: (context) => Sl.Sl<AddNoteBloc>(),
    child: QuickNotes(),
  );
  Widget profileWidget = MultiBlocProvider(
    providers: [
      BlocProvider<AddNoteBloc>(
        create: (context) => Sl.Sl<AddNoteBloc>(),
      ),
      BlocProvider<AddTaskBloc>(
        create: (context) => Sl.Sl<AddTaskBloc>(),
      ),
      BlocProvider<UserStatusBloc>(
        create: (context) => Sl.Sl<UserStatusBloc>(),
      ),
      BlocProvider<UpdateProfileBloc>(
        create: (context) => Sl.Sl<UpdateProfileBloc>(),
      ),
    ],
    child: Profile(),
  );
  Widget? selectedWidget;
  int menuIndex = 0;
  GlobalKey keyFab = GlobalKey();
  bool isFabClicked = false;

  @override
  void initState() {
    super.initState();
    myTask = BlocProvider<AddTaskBloc>(
      create: (context) => Sl.Sl<AddTaskBloc>(),
      child: MyTask(),
    );
    selectedWidget = myTask;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: selectedWidget,
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          notchMargin: 8,
          shape: CircularNotchedRectangle(),
          child: Padding(
            padding: EdgeInsets.only(top: 12, bottom: 12),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: IconButton(
                  icon: Icon(Icons.check_circle,
                      color: menuIndex == 0 ? Colors.black : Colors.grey),
                  onPressed: () {
                    menuIndex = 0;
                    getMenuItem();
                  },
                )),
                Expanded(
                    child: IconButton(
                  icon: Icon(
                    Icons.dashboard,
                    color: menuIndex == 1 ? Colors.black : Colors.grey,
                  ),
                  onPressed: () {
                    menuIndex = 1;
                    getMenuItem();
                  },
                )),
                Expanded(
                  child: SizedBox(),
                ),
                Expanded(
                    child: IconButton(
                        icon: Icon(Icons.receipt,
                            color: menuIndex == 2 ? Colors.black : Colors.grey),
                        onPressed: () {
                          menuIndex = 2;
                          getMenuItem();
                        })),
                Expanded(
                    child: IconButton(
                        icon: Icon(Icons.person,
                            color: menuIndex == 3 ? Colors.black : Colors.grey),
                        onPressed: () {
                          menuIndex = 3;
                          getMenuItem();
                        })),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showTaskMenuDialog();
          },
          backgroundColor: Colors.black,
          child: Icon(Icons.add),
        ));
  }

  showTaskMenuDialog() {
    var alertDialog = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      content: Wrap(
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  child: FlatButton(
                    child: Text(
                      "Add Task",
                      style: CustomTextStyle.styleSemiBold,
                    ),
                    onPressed: () {
                      Get.back();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider<AddTaskBloc>(
                              create: (context) => Sl.Sl<AddTaskBloc>(),
                              child: AddTask(),
                            )),
                      ).then((value) {
                        if (value != null) {
                          context.read<AddTaskBloc>().getTaskCall();
                        }
                        print(value);
                      });
                      //Get.to(AddTask());
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: FlatButton(
                    child: Text(
                      "Add Quick Notes",
                      style: CustomTextStyle.styleSemiBold,
                    ),
                    onPressed: () {
                      Get.back();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider<AddNoteBloc>(
                              create: (context) => Sl.Sl<AddNoteBloc>(),
                              child: AddNote(),
                            )),
                      );
                      //Get.to(AddNote());
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  child: FlatButton(
                    child: Text(
                      "Add Check List",
                      style: CustomTextStyle.styleSemiBold,
                    ),
                    onPressed: () {
                      Get.back();
                      Get.to(AddCheckList());
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    showDialog(context: context, builder: (context) => alertDialog);
  }

  getFormatedDate(date) {
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(date);
    var outputFormat = DateFormat('dd/MM/yyyy');
    print(outputFormat.format(inputDate));
    return outputFormat.format(inputDate);
  }

  getMenuItem() {
    if (menuIndex == 0 && selectedWidget != myTask) {
      selectedWidget = myTask;
      setState(() {});
    } else if (menuIndex == 1 && selectedWidget != dashboardWidget) {
      selectedWidget = dashboardWidget;
      setState(() {});
    } else if (menuIndex == 2 && selectedWidget != quickNoteWidget) {
      selectedWidget = quickNoteWidget;
      setState(() {});
    } else {
      if (selectedWidget != profileWidget) {
        selectedWidget = profileWidget;
        setState(() {});
      }
    }
  }
}
