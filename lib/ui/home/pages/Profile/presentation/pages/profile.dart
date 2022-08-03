import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/core/Strings/strings.dart';
import 'package:task_management/ui/home/fab_menu_option/add_note/data/model/get_note_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/get_task_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/presentation/bloc/add_task_bloc.dart';
import 'package:task_management/ui/home/pages/Profile/presentation/bloc/profile_bloc.dart';
import 'package:task_management/ui/home/pages/Profile/presentation/pages/update_profile.dart';
import 'package:task_management/ui/home/pages/user_status/presentation/bloc/user_status_state.dart';

import '../../../../../../core/base/base_bloc.dart';
import '../../../../../../custom/custom_progress_painter.dart';
import '../../../../../../custom/progress_bar.dart';
import '../../../../../../features/login/presentation/bloc/login_bloc.dart';
import '../../../../../../features/login/presentation/pages/login.dart';
import '../../../../../../utils/colors.dart';
import '../../../../../../utils/style.dart';
import '../../../../../../widget/profile_pi.dart';
import '../../../../../../widget/size.dart';
import '../../../../fab_menu_option/add_note/data/model/add_note_model.dart';
import '../../../../fab_menu_option/add_note/presentation/bloc/add_note_bloc.dart';
import '../../../../fab_menu_option/add_note/presentation/bloc/add_note_event.dart';
import '../../../../fab_menu_option/add_note/presentation/bloc/add_note_state.dart';
import '../../../../fab_menu_option/add_task/presentation/bloc/add_task_event.dart';
import '../../../../fab_menu_option/add_task/presentation/bloc/add_task_state.dart';
import '../../../user_status/presentation/bloc/user_status_bloc.dart';
import 'package:task_management/injection_container.dart' as Sl;

import '../../../user_status/presentation/bloc/user_status_event.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  List<String> listCategory = ["To do task", "Quick notes"];
  List<Color> listColor = [
    CustomColors.colorBlue,
    CustomColors.colorRed,
    CustomColors.colorPurple
  ];

  late AnimationController colorController;
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController firstName = TextEditingController();
  File? imageFile;
  late Animation<Color> color;
  Map<String, dynamic> userMap = Map();
  GetTaskModel getTaskModel = GetTaskModel();
  GetNoteModel getNoteModel = GetNoteModel();
  int noOfTask = 0;
  int noOfNote = 0;
  String userStatus = "";
  int totalTask = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await _getNote();
      await _getTask();
      await _getUserStatus();
      setState(() {
        userMap = jsonDecode(prefs.getString('userData') ?? "");
        print(userMap);
      });
    });
    colorController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    color = Tween<Color>(begin: Colors.grey, end: Colors.red).animate(
        CurvedAnimation(parent: colorController, curve: Curves.easeIn));
  }

  Future<String> _getNote() {
    return Future.delayed(Duration()).then((_) {
      //ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<AddNoteBloc>(context).add(GetNoteEvent());
      return "";
    });
  }

  Future<String> _getUserStatus() {
    return Future.delayed(Duration()).then((_) {
      //ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<UserStatusBloc>(context).add(GetUserStatusEvent());
      return "";
    });
  }

  Future<String> _getTask() {
    return Future.delayed(Duration()).then((_) {
      //ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<AddTaskBloc>(context).add(GetTaskEvent(date: ""));
      return "";
    });
  }

  @override
  Widget build(BuildContext context) {
    colorController.forward();
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(.05),
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: Text(
          "Profile",
          style: CustomTextStyle.styleSemiBold.copyWith(fontSize: 18),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout,color: CustomColors.colorBlue,size: 25,),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.clear();
              Navigator.pushAndRemoveUntil(
                context,MaterialPageRoute(builder: (context) =>BlocProvider<LoginBloc>(
                create: (context) => Sl.Sl<LoginBloc>(),
                child: Login(),
              )),
                    (route) => false,
              );
            },
          )
        ],
      ),
      body: buildWidget(), /*BlocListener<AddTaskBloc, BaseState>(
        listener: (context, state) {
          if (state is StateOnSuccess) {
            ProgressDialog.hideLoadingDialog(context);
          } else if (state is GetTaskState) {
            ProgressDialog.hideLoadingDialog(context);
            getTaskModel = state.model!;
            noOfTask = getTaskModel.data!.length;
            print(getTaskModel.message ?? "");
          } else if (state is StateErrorGeneral) {
            ProgressDialog.hideLoadingDialog(context);
          }
        },
        bloc: BlocProvider.of<AddTaskBloc>(context),
        child: BlocBuilder<AddTaskBloc, BaseState>(
          builder: (context, state) {
            return buildWidget();
          },
        ),
      ),*/
    );
  }

  Widget buildWidget() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 24, left: 16, right: 16, bottom: 16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.white10,
                        offset: Offset(1, 100),
                        blurRadius: 40)
                  ]),
              child: Column(
                children: [
                  if (userMap.isNotEmpty)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(top: 16),
                            child: Row(
                              children: [
                                sized_16(),
                                userProfilePic(radius: 30.0,imagePath: "${Strings.baseUrl}${userMap['profile_pic']}"),
                                sized_16(size: 16.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${userMap['first_name']}"
                                              " ${userMap['last_name']}",
                                          style: CustomTextStyle.styleSemiBold,
                                        ),
                                        BlocBuilder<UserStatusBloc, BaseState>(
                                          builder: (context, state) {
                                            if (state is GetUserStatusState) {
                                              ProgressDialog.hideLoadingDialog(context);
                                              for(int i=0;i<state.model!.data!.length;i++){
                                                if(state.model!.data![i].id == int.parse(userMap['status_id'].toString())){
                                                  userStatus = state.model!.data![i].userStatus!;
                                                }
                                              }
                                              return Text(
                                                "  ($userStatus)",
                                                style: CustomTextStyle.styleSemiBold.copyWith(color: CustomColors.colorBlue,fontSize: 20),
                                              );
                                            } else if (state is StateErrorGeneral) {
                                              ProgressDialog.hideLoadingDialog(context);
                                              Fluttertoast.showToast(
                                                  msg: getTaskModel.message ?? "",
                                                  toastLength: Toast.LENGTH_LONG,
                                                  fontSize: 20,
                                                  backgroundColor: CustomColors.colorBlue,
                                                  textColor: Colors.white
                                              );
                                              return const SizedBox();
                                            }else {
                                              return const SizedBox();
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                    sized_16(size: 4.0),
                                    Text(
                                      "${userMap['email']}",
                                      style: CustomTextStyle.styleMedium
                                          .copyWith(color: Colors.grey),
                                    ),
                                    Text(
                                      userMap['mobile_number']
                                          .toString()
                                          .substring(3),
                                      style: CustomTextStyle.styleMedium
                                          .copyWith(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10,top: 10),
                          child: GestureDetector(
                            child: Text(
                              "Update Profile",
                              style: CustomTextStyle.styleSemiBold.copyWith(fontSize: 18,color: CustomColors.colorBlue),
                            ),
                            onTap: (){
                              email.text = userMap['email'];
                              mobile.text = userMap['mobile_number'].toString().substring(3);
                              firstName.text = userMap['first_name'];
                              lastName.text = userMap['last_name'];
                              imageFile = File(userMap['profile_pic']);
                              Navigator.push(
                                context,
                                  MaterialPageRoute(
                                      builder: (context) => MultiBlocProvider(
                                        providers: [
                                          BlocProvider<UserStatusBloc>(
                                            create: (context) => Sl.Sl<UserStatusBloc>(),
                                          ),
                                          BlocProvider<LoginBloc>(
                                            create: (context) => Sl.Sl<LoginBloc>(),
                                          ),
                                          BlocProvider<UpdateProfileBloc>(
                                            create: (context) => Sl.Sl<UpdateProfileBloc>(),
                                          ),
                                        ],
                                        child: UpdateProfile(
                                          selectedUserStatus: int.parse(userMap['status_id']),
                                          selectedUserRole: int.parse(userMap['role']),
                                          mobile: mobile,
                                          email: email,
                                          lastName: lastName,
                                          firstName: firstName,
                                          imageFile: imageFile,
                                        ),
                                      )),
                              );

                            },
                          ),
                        ),
                      ],
                    ),
                  sized_16(size: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      sized_16(size: 16.0),
                      BlocBuilder<AddTaskBloc, BaseState>(
                        builder: (context, state) {
                          if (state is GetTaskState) {
                            ProgressDialog.hideLoadingDialog(context);
                            return Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${state.model!.data!.length}",
                                    style: CustomTextStyle.styleMedium,
                                  ),
                                  Text(
                                    "Create Tasks",
                                    style: CustomTextStyle.styleSemiBold
                                        .copyWith(color: Colors.grey, fontSize: 14),
                                  ),
                                ],
                              ),
                            );
                          }else if (state is StateErrorGeneral) {
                            ProgressDialog.hideLoadingDialog(context);
                            Fluttertoast.showToast(
                                msg: getTaskModel.message ?? "",
                                toastLength: Toast.LENGTH_LONG,
                                fontSize: 20,
                                backgroundColor: CustomColors.colorBlue,
                                textColor: Colors.white
                            );
                            return const SizedBox();
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                      BlocBuilder<AddTaskBloc, BaseState>(
                        builder: (context, state) {
                          if (state is GetTaskState) {
                            ProgressDialog.hideLoadingDialog(context);
                            totalTask =0;
                            for(int i=0;i<state.model!.data!.length;i++){
                              if(state.model!.data![i].isCompleted == true){
                                totalTask++;
                              }
                            }
                            return Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    totalTask.toString(),
                                    style: CustomTextStyle.styleMedium,
                                  ),
                                  Text(
                                    "Completed Tasks",
                                    style: CustomTextStyle.styleSemiBold
                                        .copyWith(color: Colors.grey, fontSize: 14),
                                  ),
                                ],
                              ),
                            );
                          }else if (state is StateErrorGeneral) {
                            ProgressDialog.hideLoadingDialog(context);
                            Fluttertoast.showToast(
                                msg: getTaskModel.message ?? "",
                                toastLength: Toast.LENGTH_LONG,
                                fontSize: 20,
                                backgroundColor: CustomColors.colorBlue,
                                textColor: Colors.white
                            );
                            return const SizedBox();
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    ],
                  ),
                  sized_16(size: 24.0),
                ],
              ),
            ),
            BlocBuilder<AddTaskBloc, BaseState>(
              builder: (context, state) {
                if (state is GetTaskState) {
                  ProgressDialog.hideLoadingDialog(context);
                  return Container(
                    width: 150,
                    margin: const EdgeInsets.only(top: 16),
                    height: 100,
                    child:  taskCategory(0,state.model?.data?.length ?? 0,"Tasks"),
                  );
                }else if (state is StateErrorGeneral) {
                  ProgressDialog.hideLoadingDialog(context);
                  Fluttertoast.showToast(
                      msg: getTaskModel.message ?? "",
                      toastLength: Toast.LENGTH_LONG,
                      fontSize: 20,
                      backgroundColor: CustomColors.colorBlue,
                      textColor: Colors.white
                  );
                  return const SizedBox();
                } else {
                  return const SizedBox();
                }
              },
            ),
            BlocBuilder<AddNoteBloc, BaseState>(
              builder: (context, state) {
                if (state is GetNoteState) {
                  ProgressDialog.hideLoadingDialog(context);
                  return Container(
                    width: 150,
                    margin: const EdgeInsets.only(top: 16),
                    height: 100,
                    child:  taskCategory(1,state.model?.data?.length ?? 0,"Notes"),
                  );
                }else if (state is StateErrorGeneral) {
                  ProgressDialog.hideLoadingDialog(context);
                  Fluttertoast.showToast(
                      msg: getTaskModel.message ?? "",
                      toastLength: Toast.LENGTH_LONG,
                      fontSize: 20,
                      backgroundColor: CustomColors.colorBlue,
                      textColor: Colors.white
                  );
                  return const SizedBox();
                } else {
                  return const SizedBox();
                }
              },
            ),
            statistics()
          ],
        ),
      ),
    );
  }

/*  Widget displayCountWidget(int count,){
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 16),
      height: 100,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return taskCategory(index,count);
        },
        itemCount: 2,
        shrinkWrap: true,
        primary: false,
        scrollDirection: Axis.horizontal,
      ),
    );
  }*/

  taskCategory(index, int count,String name) {
    return Container(
      height: 100,
      width: 150,
      padding: const EdgeInsets.only(left: 12,right:  12),
      margin: EdgeInsets.only(left: index == 0 ? 16 : 16, right: 16),
      decoration: BoxDecoration(
          color: listColor[index], borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            listCategory[index],
            style: CustomTextStyle.styleSemiBold
                .copyWith(color: Colors.white, fontSize: 16),
          ),
          sized_16(size: 4.0),
        Text(
          "$count $name",
          style: CustomTextStyle.styleMedium
              .copyWith(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }

  statistics() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 24, left: 16, right: 16, bottom: 16),
      padding: EdgeInsets.only(left: 16, top: 16, bottom: 16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
                color: Colors.white10, offset: Offset(1, 100), blurRadius: 40)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Statistic",
            style: CustomTextStyle.styleSemiBold,
          ),
          Container(
            decoration: BoxDecoration(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<AddTaskBloc, BaseState>(
                  builder: (context, state) {
                    if (state is GetTaskState) {
                      ProgressDialog.hideLoadingDialog(context);
                      return progressPercentage(
                          double.parse(state.model?.data?.length.toString() ?? ""), "Tasks", CustomColors.colorRed);
                    }else if (state is StateErrorGeneral) {
                      ProgressDialog.hideLoadingDialog(context);
                      Fluttertoast.showToast(
                          msg: getTaskModel.message ?? "",
                          toastLength: Toast.LENGTH_LONG,
                          fontSize: 20,
                          backgroundColor: CustomColors.colorBlue,
                          textColor: Colors.white
                      );
                      return const SizedBox();
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                //Expanded(child: Container()),
               // progressPercentage(0.4, "To Do", CustomColors.colorBlue),
                 const SizedBox( width:  60,),
                BlocBuilder<AddNoteBloc, BaseState>(
                  builder: (context, state) {
                    if (state is GetNoteState) {
                      ProgressDialog.hideLoadingDialog(context);
                      return progressPercentage(double.parse(state.model?.data?.length.toString() ?? ""),
                          "Quick Notes", CustomColors.colorPurple);
                    }else if (state is StateErrorGeneral) {
                      ProgressDialog.hideLoadingDialog(context);
                      Fluttertoast.showToast(
                          msg: getTaskModel.message ?? "",
                          toastLength: Toast.LENGTH_LONG,
                          fontSize: 20,
                          backgroundColor: CustomColors.colorBlue,
                          textColor: Colors.white
                      );
                      return const SizedBox();
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                Expanded(child: Container()),
              ],
            ),
          )
        ],
      ),
    );
  }

  progressPercentage(percentage, title, color) {
    return Container(
        margin: EdgeInsets.only(bottom: 4, top: 16),
        child: Column(
          children: [
            CustomPaint(
              child: Container(
                width: 86,
                height: 86,
                alignment: Alignment.center,
                child: Text(
                  "${percentage * 100}%",
                  style: CustomTextStyle.styleSemiBold.copyWith(fontSize: 18),
                ),
              ),
              painter: CircleProgressBarPainter(
                  backgroundColor: Colors.grey.shade300,
                  foregroundColor: color,
                  strokeWidth: 2,
                  percentage: percentage),
            ),
            sized_16(size: 6.0),
            Text(
              title,
              style: CustomTextStyle.styleSemiBold,
            )
          ],
        ));
  }
}
