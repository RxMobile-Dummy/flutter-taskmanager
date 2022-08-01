import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/get_task_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/update_task.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/presentation/bloc/add_task_bloc.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/presentation/pages/add_task.dart';
import 'package:task_management/ui/home/pages/add_member/presentation/bloc/add_member_bloc.dart';

import '../core/base/base_bloc.dart';
import '../custom/progress_bar.dart';
import '../ui/home/fab_menu_option/add_task/data/model/delete_task_model.dart';
import '../ui/home/fab_menu_option/add_task/presentation/bloc/add_task_event.dart';
import '../ui/home/fab_menu_option/add_task/presentation/bloc/add_task_state.dart';
import '../ui/home/fab_menu_option/add_task/presentation/pages/update_task.dart';
import '../ui/home/pages/comment/presentation/bloc/comment_bloc.dart';
import '../ui/home/task/task_details.dart';
import '../utils/colors.dart';
import '../utils/style.dart';
import 'package:task_management/injection_container.dart' as Sl;

class TaskList extends StatefulWidget {
  bool isFilterApply;
  bool isCompleted;

  TaskList({required this.isCompleted, required this.isFilterApply});

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  // GetTaskModel getTaskModel = GetTaskModel();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  String taskStatus = "";

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   await _getTask(
    //       isCompleted: widget.isCompleted, isFilterApply: widget.isFilterApply);
    // });
    super.initState();
  }

  // Future<String> _getTask({bool? isCompleted, bool isFilterApply = false}) {
  //   return Future.delayed(Duration()).then((_) {
  //     ProgressDialog.showLoadingDialog(context);
  //     BlocProvider.of<AddTaskBloc>(context).add(isFilterApply
  //         ? GetTaskEvent(date: "", isCompleted: isCompleted)
  //         : GetTaskEvent(date: ""));
  //     return "";
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTaskBloc, BaseState>(
      bloc: BlocProvider.of<AddTaskBloc>(context),
      builder: (context, state) {
        print("dataasdasdasd");
        if (state is GetTaskState) {
          if (state.model?.data != null &&
              (state.model?.data?.isNotEmpty ?? false)) {
            return buildWidget(state.model?.data);
          }
        }
        return Center(
          child: Text(
            "No Task found for this user",
            style: CustomTextStyle.styleSemiBold
                .copyWith(color: CustomColors.colorBlue, fontSize: 18),
          ),
        );
      },
    );
    //_getTask(isCompleted: widget.isCompleted,isFilterApply: widget.isFilterApply);
    //_getTask();
    /*return BlocListener<AddTaskBloc, BaseState>(
        listener: (context, state) async {
      debugPrint("Listened");
      if (state is StateOnSuccess) {
        ProgressDialog.hideLoadingDialog(context);
      } else if (state is GetTaskState) {
        ProgressDialog.hideLoadingDialog(context);
        getTaskModel = state.model!;
        print(getTaskModel.message ?? "");
        // Navigator.of(context).pop();
      } else if (state is DeleteTaskState) {
        ProgressDialog.hideLoadingDialog(context);
        DeleteTaskModel? model = state.model;
        print(model!.message ?? "");
        // Navigator.of(context).pop();
        // await _getTask();
      } else if (state is StateErrorGeneral) {
        ProgressDialog.hideLoadingDialog(context);
      }
    },
        //bloc: BlocProvider.of<AddTaskBloc>(context),
        child: BlocBuilder<AddTaskBloc, BaseState>(builder: (context, state) {
      if (state is GetTaskState) {
        if (state.model?.data != null && (state.model?.data?.isNotEmpty ?? false)) {
          return buildWidget(state.model?.data);
        }
      }
      return Center(
        child: Text(
          "No Task found for this user",
          style: CustomTextStyle.styleSemiBold
              .copyWith(color: CustomColors.colorBlue, fontSize: 18),
        ),
      );
    }));*/
  }

  Widget buildWidget(List<Data>? list) {
    return Container(
      color: Colors.grey.shade100,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 72),
        itemBuilder: (context, index) {
          /* if (index % 6 == 0) {
            return headerItem();
          }*/
          return contentItem(index, context, list!);
        },
        itemCount: /*12*/ list?.length ?? 0,
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

  contentItem(index, BuildContext context, List<Data> list) {
    var getTaskModel = list[index];
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MultiBlocProvider(
                    providers: [
                      BlocProvider<AddTaskBloc>(
                        create: (context) => Sl.Sl<AddTaskBloc>(),
                      ),
                      BlocProvider<CommentBloc>(
                        create: (context) => Sl.Sl<CommentBloc>(),
                      ),
                      BlocProvider<AddMemberBloc>(
                        create: (context) => Sl.Sl<AddMemberBloc>(),
                      ),
                    ],
                    child: TaskDetails(getTaskModel: getTaskModel,),
                  )),
        );
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
                  offset: const Offset(0, 100),
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
              color: getTaskModel.isCompleted ?? false
                  ? CustomColors.colorRed
                  : CustomColors.colorBlue,
              iconWidget: Container(
                child: IconButton(
                  onPressed: () {
                    titleController.text = getTaskModel.name ?? "";
                    descriptionController.text = getTaskModel.description ?? "";
                    commentController.text = getTaskModel.comment ?? "";
                    startDate.text = getTaskModel.startDate ?? "";
                    endDate.text = getTaskModel.endDate ?? "";
                    taskStatus = getTaskModel.isCompleted ?? false ? "Completed" : "InCompleted";
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlocProvider<AddTaskBloc>(
                            create: (context) => Sl.Sl<AddTaskBloc>(),
                            child: UpdateTask(
                              titleController: titleController,
                              commentController: commentController,
                              descriptionController: descriptionController,
                              taskId: getTaskModel.id ?? 0,
                              endDate: startDate,
                              startDate: startDate,
                              selectedRadio: taskStatus,
                            ),
                          )),
                    );
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              ),
              caption: "Edit",
            ),
            IconSlideAction(
              onTap: () {},
              color: getTaskModel.isCompleted ?? false
                  ? CustomColors.colorRed
                  : CustomColors.colorBlue,
              iconWidget: Container(
                child: IconButton(
                  onPressed: () {
                    _deleteTask(id: getTaskModel.id, context: context);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
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
                  child: getTaskModel.isCompleted ?? false
                      ? const Icon(
                          Icons.radio_button_unchecked,
                          color: Colors.red,
                          size: 18,
                        )
                      : const Icon(
                          Icons.check_circle,
                          size: 18,
                          color: Colors.blue,
                        ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Title: ",
                            style: CustomTextStyle.styleSemiBold.copyWith(
                                color: getTaskModel.isCompleted ?? false
                                    ? Colors.grey
                                    : Colors.black,
                                decoration: getTaskModel.isCompleted ?? false
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none),
                          ),
                          Text(
                            getTaskModel.name ??
                                "" /*"Go fishing with Stephen"*/,
                            style: CustomTextStyle.styleSemiBold.copyWith(
                                color: getTaskModel.isCompleted ?? false
                                    ? Colors.grey
                                    : Colors.black,
                                decoration: getTaskModel.isCompleted ?? false
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Text(
                            "Description: ",
                            style: CustomTextStyle.styleSemiBold.copyWith(
                                color: getTaskModel.isCompleted ?? false
                                    ? Colors.grey
                                    : Colors.black,
                                decoration: getTaskModel.isCompleted ?? false
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none),
                          ),
                          Text(
                            getTaskModel.description ??
                                "" /*"Go fishing with Stephen"*/,
                            style: CustomTextStyle.styleSemiBold.copyWith(
                                color: getTaskModel.isCompleted ?? false
                                    ? Colors.grey
                                    : Colors.black,
                                decoration: getTaskModel.isCompleted ?? false
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Text(
                            "Comment: ",
                            style: CustomTextStyle.styleSemiBold.copyWith(
                                color: getTaskModel.isCompleted ?? false
                                    ? Colors.grey
                                    : Colors.black,
                                decoration: getTaskModel.isCompleted ?? false
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none),
                          ),
                          Text(
                            getTaskModel.comment ??
                                "" /*"Go fishing with Stephen"*/,
                            style: CustomTextStyle.styleSemiBold.copyWith(
                                color: getTaskModel.isCompleted ?? false
                                    ? Colors.grey
                                    : Colors.black,
                                decoration: getTaskModel.isCompleted ?? false
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "09:00 AM",
                        style: CustomTextStyle.styleMedium.copyWith(
                            color: Colors.grey,
                            decoration: getTaskModel.isCompleted ?? false
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
                  color: getTaskModel.isCompleted ?? false
                      ? CustomColors.colorRed
                      : CustomColors.colorBlue,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> _deleteTask({int? id, required BuildContext context}) {
    return Future.delayed(Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<AddTaskBloc>(context).add(DeleteTaskEvent(id: id ?? 0));
      return "";
    });
  }
}
