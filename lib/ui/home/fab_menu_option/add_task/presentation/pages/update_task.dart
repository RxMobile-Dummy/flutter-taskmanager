import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/add_task_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/update_task.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/presentation/bloc/add_task_bloc.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/presentation/bloc/add_task_state.dart';

import '../../../../../../core/base/base_bloc.dart';
import '../../../../../../custom/progress_bar.dart';
import '../../../../../../utils/border.dart';
import '../../../../../../utils/colors.dart';
import '../../../../../../utils/style.dart';
import '../../../../../../widget/button.dart';
import '../../../../../../widget/decoration.dart';
import '../../../../../../widget/rounded_corner_page.dart';
import '../bloc/add_task_event.dart';


class UpdateTask extends StatefulWidget {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  int taskId;
  UpdateTask({required this.taskId,required this.commentController,required this.descriptionController,required this.titleController});
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
              print(model!.message??"");
              Navigator.of(context).pop();
            }else if (state is StateErrorGeneral) {
              ProgressDialog.hideLoadingDialog(context);
            }
          },
          bloc: BlocProvider.of<AddTaskBloc>(context),
          child:  BlocBuilder<AddTaskBloc, BaseState>(builder: (context, state) {
            return buildWidget();
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.only(left: 16, top: 32),
                    child: Row(
                      children: [
                        Text(
                          "For",
                          style: CustomTextStyle.styleBold,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(100)),
                          child: Text("Assignee"),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Text(
                          "In",
                          style: CustomTextStyle.styleBold,
                        ),
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
                    )),
                Container(
                  margin: EdgeInsets.only(top: 24),
                  color: Colors.grey.shade200,
                  padding: EdgeInsets.only(left: 4, right: 16),
                  child: TextField(
                    style: CustomTextStyle.styleSemiBold,
                    controller: widget.titleController,
                    decoration: InputDecoration(
                        border: titleBorder(color: Colors.grey.shade200),
                        hintText: "Title",
                        hintStyle: CustomTextStyle.styleSemiBold,
                        labelStyle: CustomTextStyle.styleSemiBold,
                        enabledBorder:
                        titleBorder(color: Colors.grey.shade200),
                        focusedBorder:
                        titleBorder(color: Colors.grey.shade200)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 24),
                  color: Colors.grey.shade200,
                  padding: EdgeInsets.only(left: 4, right: 16),
                  child: TextField(
                    style: CustomTextStyle.styleSemiBold,
                    controller: widget.descriptionController,
                    decoration: InputDecoration(
                        border: titleBorder(color: Colors.grey.shade200),
                        hintText: "Description",
                        hintStyle: CustomTextStyle.styleSemiBold,
                        labelStyle: CustomTextStyle.styleSemiBold,
                        enabledBorder:
                        titleBorder(color: Colors.grey.shade200),
                        focusedBorder:
                        titleBorder(color: Colors.grey.shade200)),
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
                  margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    children: [
                      TextField(
                        style: CustomTextStyle.styleSemiBold,
                        maxLines: 3,
                        controller: widget.commentController,
                        decoration: InputDecoration(
                            labelStyle: CustomTextStyle.styleSemiBold,
                            enabledBorder:
                            titleBorder(color: Colors.transparent),
                            focusedBorder:
                            titleBorder(color: Colors.transparent)),
                      ),
                      Container(
                        color: Colors.grey.shade100,
                        padding: const EdgeInsets.only(
                            left: 16, top: 16, right: 16, bottom: 16),
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
                    )),
                Container(
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
                ),
                Button(
                  "Update Task",
                  onPress: () {
                    _updateTask(
                      context,
                      id: widget.taskId,
                      start_date: "2012-09-04 06:00",
                      end_date: "2012-09-04 06:00",
                      task_status: "",
                      tag_id: "",
                      reviewer_id: "",
                      project_id: "",
                      priority: "Urgent",
                      is_private: "false",
                      comment: widget.commentController.text,
                      assignee_id: "",
                      description: widget.descriptionController.text,
                      name: widget.titleController.text,
                      isCompleted: true,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
