import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/presentation/bloc/add_task_bloc.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/presentation/bloc/add_task_state.dart';

import '../../../../../../core/base/base_bloc.dart';
import '../../../../../../core/error_bloc_listener/error_bloc_listener.dart';
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
  String enterDescriptionText = "";
  String enterCommentText = "";
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
      body:ErrorBlocListener<AddTaskBloc>(
          bloc: BlocProvider.of<AddTaskBloc>(context),
          child:  BlocBuilder<AddTaskBloc, BaseState>(
              builder: (context, state) {
                if(state is UpdateTaskState){
                  ProgressDialog.hideLoadingDialog(context);
                  Future.delayed(Duration.zero, () {
                    Navigator.of(context).pop();
                  });
                  BlocProvider.of<AddTaskBloc>(context).add(
                      GetTaskEvent(date: state.model?.data!.startDate ?? "" ));
                }
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
      showBackButton: true,
      child: Expanded(
        child: RoundedCornerDecoration(
          SingleChildScrollView(
            child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:  12),
    child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                    maxLength: 300,
                    controller: widget.descriptionController,
                    onChanged: (value){
                      enterDescriptionText = value;
                    },
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
                        counterText: "${enterDescriptionText.length}/300",
                        labelText: "Description",
                        enabledBorder:
                        titleBorder(color: Colors.transparent),
                        focusedBorder:
                        titleBorder(color: Colors.transparent)),
                  ),
                ),
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
                        maxLength: 50,
                        onChanged: (value){
                          setState(() {
                            enterCommentText = value;
                          });
                        },
                        controller: widget.commentController,
                        decoration: InputDecoration(
                            hintStyle: CustomTextStyle.styleSemiBold.copyWith(
                                fontSize: DeviceUtil.isTablet ? 16 : 14
                            ),
                            counterText: "${enterCommentText.length}/50",
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
                      Fluttertoast.cancel();
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
                      Fluttertoast.cancel();
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
