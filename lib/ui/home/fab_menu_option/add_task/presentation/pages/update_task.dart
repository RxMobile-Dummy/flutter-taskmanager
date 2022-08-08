import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/add_task_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/update_task.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/presentation/bloc/add_task_bloc.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/presentation/bloc/add_task_state.dart';

import '../../../../../../core/base/base_bloc.dart';
import '../../../../../../custom/progress_bar.dart';
import '../../../../../../utils/border.dart';
import '../../../../../../utils/colors.dart';
import '../../../../../../utils/device_file.dart';
import '../../../../../../utils/style.dart';
import '../../../../../../widget/button.dart';
import '../../../../../../widget/decoration.dart';
import '../../../../../../widget/rounded_corner_page.dart';
import '../../../../pages/Project/presentation/bloc/project_bloc.dart';
import '../../../../pages/Project/presentation/bloc/project_event.dart';
import '../../../../pages/Project/presentation/bloc/project_state.dart';
import '../bloc/add_task_event.dart';


class UpdateTask extends StatefulWidget {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  int taskId;
  String selectedRadio;
  String projectId;
  UpdateTask({required this.projectId,required this.selectedRadio,required this.endDate,required this.startDate,required this.taskId,required this.commentController,required this.descriptionController,required this.titleController});
  @override
  _UpdateTaskState createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {

  List<Color> listColors = [
    CustomColors.colorPurple,
    CustomColors.colorBlue,
    CustomColors.colorRed,
    Colors.green,
    Colors.cyan
  ];

  Color? selectedColors;
  List<String> projectList = [];
  String? selectProject;
  List<dynamic> listOfProject = [];
  final GlobalKey<FormState> _formKey =  GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _getProject();
    });
    super.initState();
  }

  Future<String> _getProject() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('id');
    print(id);
    return Future.delayed(Duration()).then((_) {
      //ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<ProjectBloc>(context).add(
          GetAllProjectsEvent(
            id: int.parse(id ?? ""),
          ));
      return "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:BlocListener<AddTaskBloc, BaseState>(
          listener: (context, state) {
            if (state is StateOnSuccess) {
              ProgressDialog.hideLoadingDialog(context);
            } else if (state is UpdateTaskState) {
              ProgressDialog.hideLoadingDialog(context);
              AddTaskModel? model = state.model;
              if(model!.success == true){
                Fluttertoast.showToast(
                    msg: model.message ?? "",
                    toastLength: Toast.LENGTH_LONG,
                    fontSize: DeviceUtil.isTablet ? 20 : 12,
                    backgroundColor: CustomColors.colorBlue,
                    textColor: Colors.white
                );
                Navigator.of(context).pop(model.data!.startDate);
              }else{
                Fluttertoast.showToast(
                    msg: model.error ?? "",
                    toastLength: Toast.LENGTH_LONG,
                    fontSize: DeviceUtil.isTablet ? 20 : 12,
                    backgroundColor: CustomColors.colorBlue,
                    textColor: Colors.white
                );
              }
            }else if (state is StateErrorGeneral) {
              ProgressDialog.hideLoadingDialog(context);
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
            return Form(
              key: _formKey,
              child: buildWidget(),
            );
          })
      ),
    );
  }
  Widget buildWidget(){
    return RoundedCornerPage(
      title: "Update Task",
      child: Expanded(
        child: RoundedCornerDecoration(
          SingleChildScrollView(
            child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:  12),
    child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*Container(
                    margin: EdgeInsets.only(left: 16, top: 32),
                    child: Row(
                      children: [
                       *//* Text(
                          "For",
                          style: CustomTextStyle.styleBold,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(100)),
                          child: const Text("Assignee"),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Text(
                          "In",
                          style: CustomTextStyle.styleBold,
                        ),*//*
                        SizedBox(
                          width: 16,
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 16),
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(100)),
                          child: Text("Project"),
                        ),
                      ],
                    )),*/
                Container(
                  margin: EdgeInsets.only(top: 16),
                  color: Colors.grey.shade200,
                  padding: EdgeInsets.only(left: 4, right: 16),
                  child: TextFormField(
                    style: CustomTextStyle.styleSemiBold.copyWith(
                        fontSize: DeviceUtil.isTablet ? 16 : 14
                    ),
                    controller: widget.titleController,
                    validator: (value) {
                      if (value == null || value == "") {
                        return 'Please enter task name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintStyle: CustomTextStyle.styleSemiBold.copyWith(
                            fontSize: DeviceUtil.isTablet ? 16 : 14
                        ),
                        labelStyle: CustomTextStyle.styleSemiBold.copyWith(
                            fontSize: DeviceUtil.isTablet ? 16 : 14
                        ),
                        labelText: "Title",
                        enabledBorder:
                        titleBorder(color: Colors.transparent),
                        focusedBorder:
                        titleBorder(color: Colors.transparent)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  color: Colors.grey.shade200,
                  padding: EdgeInsets.only(left: 4, right: 16),
                  child: TextFormField(
                    style: CustomTextStyle.styleSemiBold.copyWith(
                        fontSize: DeviceUtil.isTablet ? 16 : 14
                    ),
                    maxLines: 5,
                    controller: widget.descriptionController,
                    validator: (value) {
                      if (value == null || value == "") {
                        return 'Please enter description';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintStyle: CustomTextStyle.styleSemiBold.copyWith(
                            fontSize: DeviceUtil.isTablet ? 16 : 14
                        ),
                        labelStyle: CustomTextStyle.styleSemiBold.copyWith(
                            fontSize: DeviceUtil.isTablet ? 16 : 14
                        ),
                        labelText: "Description",
                        enabledBorder:
                        titleBorder(color: Colors.transparent),
                        focusedBorder:
                        titleBorder(color: Colors.transparent)),
                  ),
                ),
                /* Container(
                  margin: EdgeInsets.only(left: 16, top: 24),
                  child: Text(
                    "Description",
                    style: CustomTextStyle.styleBold
                        .copyWith(color: Colors.grey),
                  ),
                ),*/
                Container(
                  margin:EdgeInsets.only(/*left: 16, right: 16, */top: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    children: [
                      TextField(
                        style: CustomTextStyle.styleSemiBold.copyWith(
                            fontSize: DeviceUtil.isTablet ? 16 : 14
                        ),
                        maxLines: 5,
                        controller: widget.commentController,
                        decoration: InputDecoration(
                            hintStyle: CustomTextStyle.styleSemiBold.copyWith(
                                fontSize: DeviceUtil.isTablet ? 16 : 14
                            ),
                            labelStyle: CustomTextStyle.styleSemiBold.copyWith(
                                fontSize: DeviceUtil.isTablet ? 16 : 14
                            ),
                            labelText: "Enter Comment",
                            enabledBorder:
                            titleBorder(color: Colors.transparent),
                            focusedBorder:
                            titleBorder(color: Colors.transparent)),
                      ),
                      Container(
                        color: Colors.grey.shade100,
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Transform.rotate(
                              angle: 2.5,
                              child: const Icon(
                                Icons.attachment,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
          Container(
              padding: const EdgeInsets.only(top: 16),
              child: Center(
                  child: TextFormField(
                    controller: widget.startDate,
                    style: CustomTextStyle.styleSemiBold.copyWith(
                        fontSize: DeviceUtil.isTablet ? 16 : 14
                    ),
                    decoration:  InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(width: 1, color: CustomColors.colorBlue),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(width: 1, color: CustomColors.colorBlue),
                      ),
                      suffixIcon: const Icon(Icons.calendar_today,
                        color: CustomColors.colorBlue,),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(width: 1, color: CustomColors.colorBlue),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(width: 1, color: CustomColors.colorBlue),
                      ),
                      labelText: "Enter Start Date",
                      labelStyle: CustomTextStyle.styleSemiBold.copyWith(
                          fontSize: DeviceUtil.isTablet ? 16 : 14
                      ),
                    ),
                    readOnly: true,
                    validator: (value) {
                      if (value == null || value == "") {
                        return 'Please Select Start date.';
                      }
                      return null;
                    },
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          builder: (BuildContext context, Widget ?child) {
                            return Theme(
                              data: ThemeData(
                                primarySwatch: Colors.grey,
                                splashColor: Colors.black,
                                textTheme: const TextTheme(
                                  subtitle1: TextStyle(color: Colors.black),
                                  button: TextStyle(color: Colors.black),
                                ),
                                accentColor: Colors.black,
                                colorScheme: const ColorScheme.light(
                                    primary: CustomColors.colorBlue,
                                    primaryVariant: Colors.black,
                                    secondaryVariant: Colors.black,
                                    onSecondary: Colors.black,
                                    onPrimary: Colors.white,
                                    surface: Colors.black,
                                    onSurface: Colors.black,
                                    secondary: Colors.black),
                                dialogBackgroundColor: Colors.white,
                              ),
                              child: child ??const Text(""),
                            );
                          },
                          firstDate: DateTime(1950),
                          lastDate: DateTime(2100));
                      if (pickedDate != null) {
                        print(pickedDate);
                        String formattedDate =
                        DateFormat('dd/MM/yyyy').format(pickedDate);
                        print(formattedDate);
                        setState(() {
                          widget.startDate.text = formattedDate;
                        });
                      } else {}
                    },
                  ))),
          Container(
              padding: const EdgeInsets.only(top: 16),
              //height: MediaQuery.of(context).size.width / 3,
              child: Center(
                  child: TextFormField(
                    controller: widget.endDate,
                    style: CustomTextStyle.styleSemiBold.copyWith(
                        fontSize: DeviceUtil.isTablet ? 16 : 14
                    ),
                    decoration:  InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(width: 1, color: CustomColors.colorBlue),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(width: 1, color: CustomColors.colorBlue),
                      ),
                      suffixIcon: const Icon(Icons.calendar_today,
                        color: CustomColors.colorBlue,),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(width: 1, color: CustomColors.colorBlue),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(width: 1, color: CustomColors.colorBlue),
                      ),
                      labelText: "Enter End Date",
                      labelStyle: CustomTextStyle.styleSemiBold.copyWith(
                          fontSize: DeviceUtil.isTablet ? 16 : 14
                      ),
                    ),
                    readOnly: true,
                    validator: (value) {
                      if (value == null || value == "") {
                        return 'Please Select End date.';
                      }
                      return null;
                    },
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          builder: (BuildContext context, Widget ?child) {
                            return Theme(
                              data: ThemeData(
                                primarySwatch: Colors.grey,
                                splashColor: Colors.black,
                                textTheme: const TextTheme(
                                  subtitle1: TextStyle(color: Colors.black),
                                  button: TextStyle(color: Colors.black),
                                ),
                                accentColor: Colors.black,
                                colorScheme: const ColorScheme.light(
                                    primary: CustomColors.colorBlue,
                                    primaryVariant: Colors.black,
                                    secondaryVariant: Colors.black,
                                    onSecondary: Colors.black,
                                    onPrimary: Colors.white,
                                    surface: Colors.black,
                                    onSurface: Colors.black,
                                    secondary: Colors.black),
                                dialogBackgroundColor: Colors.white,
                              ),
                              child: child ??const Text(""),
                            );
                          },
                          firstDate: DateTime(1950),
                          //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2100));

                      if (pickedDate != null) {
                        print(
                            pickedDate);
                        String formattedDate =
                        DateFormat('dd/MM/yyyy').format(pickedDate);
                        print(
                            formattedDate);
                        setState(() {
                          widget.endDate.text =
                              formattedDate;
                        });
                      } else {}
                    },
                  ))),
                BlocBuilder<ProjectBloc, BaseState>(
                  builder: (context, state) {
                    if (state is GetAllProjectsState) {
                      ProgressDialog.hideLoadingDialog(context);
                      projectList = [];
                      listOfProject = state.model!.data!;
                      for (int i = 0; i < state.model!.data!.length; i++) {
                        projectList.add(state.model!.data![i].name ?? "");
                      }
                      for(int i=0;i<state.model!.data!.length;i++){
                        if(int.parse(widget.projectId) == state.model!.data![i].id){
                          selectProject = state.model!.data![i].name;
                        }
                      }
                      return Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField(
                                isExpanded: true,
                                style: CustomTextStyle.styleSemiBold.copyWith(
                                    fontSize: DeviceUtil.isTablet ? 16 : 14
                                ),
                                decoration:  InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(width: 1, color: CustomColors.colorBlue),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(width: 1, color: CustomColors.colorBlue),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(width: 1, color: CustomColors.colorBlue),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(width: 1, color: CustomColors.colorBlue),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value == "") {
                                    return 'Please Select User role.';
                                  }
                                  return null;
                                },
                                borderRadius: BorderRadius.circular(5),
                                hint: const Text('Please choose a Role'),
                                value: selectProject,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectProject = newValue!;
                                    for(int i=0;i<listOfProject.length;i++){
                                      if(selectProject == listOfProject[i].name){
                                        widget.projectId = listOfProject[i].id.toString();
                                        break;
                                      }
                                    }
                                  });
                                },
                                items: projectList.map((userRole) {
                                  return DropdownMenuItem(
                                    child: Text(userRole),
                                    value: userRole,
                                  );
                                }).toList(),
                              ),
                            )
                          ],
                        ),
                      );
                    }else if (state is StateErrorGeneral) {
                      ProgressDialog.hideLoadingDialog(context);
                      Fluttertoast.showToast(
                          msg: state.message,
                          toastLength: Toast.LENGTH_LONG,
                          fontSize: DeviceUtil.isTablet ? 20 : 12,
                          backgroundColor: CustomColors.colorBlue,
                          textColor: Colors.white
                      );
                      return const SizedBox();
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                ListTile(
                  leading: Radio<String>(
                    value: 'Completed',
                    groupValue: widget.selectedRadio,
                    activeColor: CustomColors.colorBlue,
                    onChanged: (value) {
                      setState(() {
                        widget.selectedRadio = value!;
                      });
                    },
                  ),
                  title: const Text(
                      'Completed',
                  ),
                ),
                ListTile(
                  leading: Radio<String>(
                    value: 'InCompleted',
                    groupValue: widget.selectedRadio,
                    activeColor: CustomColors.colorBlue,
                    onChanged: (value) {
                      setState(() {
                        widget.selectedRadio = value!;
                      });
                    },
                  ),
                  title: const Text('InCompleted'),
                ),
             /*   Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 24),
                    color: Colors.grey.shade200,
                    padding: EdgeInsets.only(
                        left: 16, right: 16, top: 16, bottom: 16),
                    child: Row(
                      children: [
                        Text(
                          "Due Date",
                          style: CustomTextStyle.styleMedium
                              .copyWith(fontSize: 14),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 16),
                          child: Text(
                            "Anytime",
                            style: CustomTextStyle.styleMedium
                                .copyWith(color: Colors.white, fontSize: 14),
                          ),
                          padding: EdgeInsets.only(
                              left: 12, right: 12, top: 6, bottom: 6),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(100)),
                        )
                      ],
                    )),*/
         /*       Container(
                  margin: EdgeInsets.only(left: 16, top: 24),
                  child: Text(
                    "Add Member",
                    style: CustomTextStyle.styleBold
                        .copyWith(color: Colors.grey),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 16, top: 16),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(100)),
                  child: Text("Anyone"),
                ),*/
                const SizedBox(
                  height: 12,
                ),
                Button(
                  "Update Task",
                  verticalMargin: 10,
                  horizontalMargin: 0,
                  onPress: () {
                    FocusScope.of(context).unfocus();
                    if(_formKey.currentState!.validate()){
                      _formKey.currentState?.save();
                      _updateTask(
                        context,
                        id: widget.taskId,
                        start_date: widget.startDate.text.toString(),
                        end_date: widget.endDate.text.toString(),
                        task_status: "",
                        tag_id: "",
                        reviewer_id: "",
                        project_id: widget.projectId,
                        priority: "Urgent",
                        is_private: "false",
                        comment: widget.commentController.text,
                        assignee_id: "",
                        description: widget.descriptionController.text,
                        name: widget.titleController.text,
                        isCompleted: widget.selectedRadio == "Completed" ? true : false,
                      );
                    }else{
                      Fluttertoast.showToast(
                          msg: "Please fill all the details.",
                          toastLength: Toast.LENGTH_LONG,
                          fontSize: DeviceUtil.isTablet ? 20 : 12,
                          backgroundColor: CustomColors.colorBlue,
                          textColor: Colors.white
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Future<String> _updateTask(BuildContext context,{
    int? id,
    String? name,
    String? description,
    String? assignee_id,
    String? comment,
    String? is_private,
    String? priority,
    String? project_id,
    String? reviewer_id,
    String? tag_id,
    String? task_status,
    String? end_date,
    String? start_date,
    bool? isCompleted,
  }) {
    //loginBloc = BlocProvider.of<LoginBloc>(context);
    return Future.delayed(Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<AddTaskBloc>(context).add(
          UpdateTaskEvent(
            id: id ?? 0,
            name: name ?? "",
            description: description ?? "",
            assignee_id: assignee_id ?? "",
            comment: comment ?? "",
            is_private: is_private ?? "",
            priority: priority ?? "",
            project_id: project_id ?? "",
            reviewer_id: reviewer_id ?? "",
            tag_id: tag_id ?? "",
            task_status: task_status ?? "",
            end_date: end_date ?? "",
            start_date: start_date ?? "",
            isCompleted:  isCompleted ?? false,
          ));
      return "";
    });
  }
}
