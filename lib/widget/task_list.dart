import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/update_task.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/presentation/bloc/add_task_bloc.dart';

import '../core/base/base_bloc.dart';
import '../custom/progress_bar.dart';
import '../ui/home/fab_menu_option/add_task/data/model/delete_task_model.dart';
import '../ui/home/fab_menu_option/add_task/presentation/bloc/add_task_event.dart';
import '../ui/home/fab_menu_option/add_task/presentation/bloc/add_task_state.dart';
import '../ui/home/pages/comment/presentation/bloc/comment_bloc.dart';
import '../ui/home/task/task_details.dart';
import '../utils/colors.dart';
import '../utils/style.dart';
import 'package:task_management/injection_container.dart' as Sl;

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AddTaskBloc, BaseState>(
        listener: (context, state) {
          if (state is StateOnSuccess) {
            ProgressDialog.hideLoadingDialog(context);
          }else if (state is DeleteTaskState) {
            ProgressDialog.hideLoadingDialog(context);
            DeleteTaskModel? model = state.model;
            print(model!.message??"");
            Navigator.of(context).pop();
          }else if (state is UpdateTaskState) {
            ProgressDialog.hideLoadingDialog(context);
            UpdateTaskModel? model = state.model;
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
    );
  }

  Widget buildWidget(){
    return Container(
      color: Colors.grey.shade100,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 72),
        itemBuilder: (context, index) {
          if (index % 6 == 0) {
            return headerItem();
          }
          return contentItem(index, index % 2 == 0,context);
        },
        itemCount: 12,
      ),
    );
  }

  headerItem() {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: Text(
        "TODAY, AUG 4/2018",
        style: CustomTextStyle.styleMedium
            .copyWith(color: Colors.grey, fontSize: 14),
      ),
    );
  }

  contentItem(index, bool isRejected,BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,MaterialPageRoute(builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<AddTaskBloc>(
                create: (context) => Sl.Sl<AddTaskBloc>(),
              ),
              BlocProvider<CommentBloc>(
                create: (context) => Sl.Sl<CommentBloc>(),
              ),
            ], child: TaskDetails(),)),);
        //Get.to(TaskDetails());
      },
      child: Container(
        margin: const EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade100,
                  offset: Offset(0, 100),
                  blurRadius: 1,
                  spreadRadius: 100)
            ]),
        child: Slidable(
          actionExtentRatio: 0.25,
          actionPane: const SlidableStrechActionPane(),
          secondaryActions: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
            ),
            IconSlideAction(
              onTap: () {},
              color: isRejected ? CustomColors.colorRed : CustomColors.colorBlue,
              iconWidget: Container(
                child:  IconButton(
                  onPressed: () {
                    _updateTask(
                      context,
                      id: "29",
                      start_date: "2012-09-04 06:00",
                      end_date: "2012-09-04 06:00",
                      task_status: "",
                      tag_id: "",
                      reviewer_id: "",
                      project_id: "",
                      priority: "Urgent",
                      is_private: "false",
                      comment: "",
                      assignee_id: "",
                      description: "",
                      name: 'New Task 233345',
                    );
                  }, icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),),
              ),
              caption: "Edit",
            ),
            IconSlideAction(
              onTap: () {},
              color: isRejected ? CustomColors.colorRed : CustomColors.colorBlue,
              iconWidget: Container(
                child:  IconButton(
                onPressed: () {
                  _deleteTask(id: "32",context: context);
                }, icon: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),),
              ),
              caption: "Delete",
            ),
          ],
          child: Container(
            padding: const EdgeInsets.only(top: 16, bottom: 16, left: 16),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 16),
                  width: 16,
                  height: 16,
                  alignment: Alignment.center,
                  child: isRejected
                      ? const Icon(
                          Icons.check_circle,
                          size: 18,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.radio_button_unchecked,
                          color: Colors.blue,
                          size: 18,
                        ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Go fishing with Stephen",
                        style: CustomTextStyle.styleSemiBold.copyWith(
                            color: isRejected ? Colors.grey : Colors.black,
                            decoration: isRejected
                                ? TextDecoration.lineThrough
                                : TextDecoration.none),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "09:00 AM",
                        style: CustomTextStyle.styleMedium.copyWith(
                            color: Colors.grey,
                            decoration: isRejected
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 20,
                  width: 4,
                  color:
                      isRejected ? CustomColors.colorRed : CustomColors.colorBlue,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> _deleteTask({String? id, required BuildContext context}) {
    //loginBloc = BlocProvider.of<LoginBloc>(context);
    return Future.delayed(Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<AddTaskBloc>(context).add(
          DeleteTaskEvent(id: id ?? "" ));
      return "";
    });
  }

  Future<String> _updateTask(BuildContext context,{
    String? id,
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
  }) {
    //loginBloc = BlocProvider.of<LoginBloc>(context);
    return Future.delayed(Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<AddTaskBloc>(context).add(
          UpdateTaskEvent(
            id: id ?? "",
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

          ));
      return "";
    });
  }
}
