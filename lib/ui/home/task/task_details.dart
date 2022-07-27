import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/delete_task_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/presentation/bloc/add_task_event.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/presentation/bloc/add_task_state.dart';
import 'package:task_management/ui/home/pages/comment/data/model/add_comment_model.dart';
import 'package:task_management/ui/home/pages/comment/data/model/delete_comment_model.dart';
import 'package:task_management/ui/home/pages/comment/data/model/get_comment_model.dart';
import 'package:task_management/ui/home/pages/comment/data/model/update_comment_model.dart';
import 'package:task_management/ui/home/pages/comment/presentation/bloc/comment_event.dart';

import '../../../core/base/base_bloc.dart';
import '../../../custom/progress_bar.dart';
import '../../../utils/border.dart';
import '../../../utils/colors.dart';
import '../../../utils/style.dart';
import '../../../widget/button.dart';
import '../../../widget/decoration.dart';
import '../../../widget/profile_pi.dart';
import '../../../widget/rounded_corner_page.dart';
import '../../../widget/size.dart';
import '../../../widget/textfield.dart';
import '../fab_menu_option/add_task/presentation/bloc/add_task_bloc.dart';
import '../pages/comment/presentation/bloc/comment_bloc.dart';
import '../pages/comment/presentation/bloc/comment_state.dart';


class TaskDetails extends StatefulWidget {
  @override
  _TaskDetailsState createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  var isCommentDisplay = false;
  int selectedMenu = 0;
  GetCommentModel getCommentModel = GetCommentModel();
  TextEditingController commentController = TextEditingController();
  var authToken;

  @override
  void initState() {
     WidgetsBinding.instance.addPostFrameCallback((_) async {
       SharedPreferences prefs = await SharedPreferences.getInstance();
       authToken  = prefs.getString('id');
      await _getComment(comment_user_id: authToken);
       // var token = prefs.getString('access');
       print(authToken);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AddTaskBloc, BaseState>(
          listener: (context, state) {
            if (state is StateOnSuccess) {
              ProgressDialog.hideLoadingDialog(context);
            } else if (state is DeleteTaskState) {
              ProgressDialog.hideLoadingDialog(context);
              DeleteTaskModel? model = state.model;
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(model!.message??""),
              ));
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
        title: "",
        backButton: false,
        actions: Container(
          margin: EdgeInsets.only(right: 8),
          child: popupMenu(),
        ),
        child: Expanded(
            child: RoundedCornerDecoration(Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 16, right: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      "Meeting according with design team in Central Park",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyle.styleBold.copyWith(
                        fontSize: 20,
                      ),
                    ),
                    sized_16(size: 32.0),
                    item(
                        Row(
                          children: [
                            userProfilePic(),
                            sized_16(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                title("Assigned To"),
                                sized_16(size: 4.0),
                                Text(
                                  "Saksi Malik",
                                  style: CustomTextStyle.styleSemiBold
                                      .copyWith(fontSize: 16),
                                )
                              ],
                            ),
                          ],
                        ),
                        isFirst: true),
                    item(Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.date_range,
                          color: Colors.grey,
                        ),
                        sized_16(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            title("Date"),
                            sized_16(size: 4.0),
                            Text(
                              "Aug 5,2020",
                              style: CustomTextStyle.styleSemiBold
                                  .copyWith(fontSize: 16),
                            )
                          ],
                        ),
                      ],
                    )),
                    item(Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.description,
                          color: Colors.grey,
                        ),
                        sized_16(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            title("Description"),
                            sized_16(size: 4.0),
                            Text(
                              "Lorem ipsum dolor sit amet,\nconsectetur adipiscing.",
                              style: CustomTextStyle.styleSemiBold
                                  .copyWith(fontSize: 16),
                            )
                          ],
                        ),
                      ],
                    )),
                    item(Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.device_hub,
                          color: Colors.grey,
                        ),
                        sized_16(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            title("Members"),
                            sized_16(size: 16.0),
                            Row(
                              children: [
                                userProfilePic(),
                                sized_16(size: 4.0),
                                userProfilePic(),
                                sized_16(size: 4.0),
                                userProfilePic(),
                                sized_16(size: 4.0),
                                userProfilePic(),
                              ],
                            )
                          ],
                        ),
                      ],
                    )),
                    item(Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Transform.rotate(
                          angle: 2.5,
                          child: const Icon(
                            Icons.insert_link,
                            color: Colors.grey,
                          ),
                        ),
                        sized_16(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            title("Tag"),
                            sized_16(size: 10.0),
                            Container(
                              child: const Text("Personal"),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: Colors.blue.shade50),
                                  color: Colors.white),
                              padding: const EdgeInsets.all(8),
                            )
                          ],
                        ),
                      ],
                    )),
                    BlocListener<CommentBloc, BaseState>(
                        listener: (context, state) async {
                          if (state is StateOnSuccess) {
                            ProgressDialog.hideLoadingDialog(context);
                          }  else if (state is GetCommentState) {
                            ProgressDialog.hideLoadingDialog(context);
                           // GetCommentModel? model = state.model;
                            getCommentModel = state.model!;
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(getCommentModel.message??""),
                            ));
                           // Navigator.of(context).pop();
                          }else if (state is AddCommentState) {
                            ProgressDialog.hideLoadingDialog(context);
                            AddCommentModel? model = state.model;
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(model!.message??""),
                            ));
                            await _getComment(comment_user_id: authToken);
                            //Navigator.of(context).pop();
                          }else if (state is UpdateCommentState) {
                            ProgressDialog.hideLoadingDialog(context);
                            UpdateCommentModel? model = state.model;
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(model!.message??""),
                            ));
                            Navigator.of(context).pop();
                            await _getComment(comment_user_id: authToken);
                          }else if (state is DeleteCommentState) {
                            ProgressDialog.hideLoadingDialog(context);
                            DeleteCommentModel? model = state.model;
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(model!.message??""),
                            ));
                            await _getComment(comment_user_id: authToken);
                           // Navigator.of(context).pop();
                          }else if (state is StateErrorGeneral) {
                            ProgressDialog.hideLoadingDialog(context);
                          }
                        },
                        bloc: BlocProvider.of<CommentBloc>(context),
                        child:  BlocBuilder<CommentBloc, BaseState>(builder: (context, state) {
                          return Column(
                            children: [
                              commentSection(),
                              Button(
                                "Complete Task",
                                onPress: () {},
                                horizontalMargin: 0,
                                verticalMargin: 8,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isCommentDisplay = !isCommentDisplay;
                                    /*_getComment(
                                      id: 8,
                                      comment_user_id: "10",
                                      task_id: "",
                                      project_id: "4"
                                    );*/
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Comment",
                                      style: CustomTextStyle.styleBold,
                                    ),
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(top: 8),
                                          alignment: Alignment.topCenter,
                                          child: Transform.rotate(
                                            angle: isCommentDisplay ? 3 : 0,
                                            child: Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Colors.grey.shade500,
                                            ),
                                          ),
                                        ),
                                        Transform.rotate(
                                          angle: isCommentDisplay ? 3 : 0,
                                          child: const Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        })
                    ),
                    sized_16()
                  ],
                ),
              ),
            ))));
  }
  commentSection() {
    return Visibility(
      visible: isCommentDisplay,
      child: Container(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 0, right: 0, top: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  TextField(
                    style: CustomTextStyle.styleMedium,
                    controller: commentController,
                    maxLines: 3,
                    decoration: InputDecoration(
                        hintStyle: CustomTextStyle.styleMedium
                            .copyWith(color: Colors.grey),
                        hintText: "Write a comment",
                        labelStyle: CustomTextStyle.styleSemiBold,
                        enabledBorder: titleBorder(color: Colors.transparent),
                        focusedBorder: titleBorder(color: Colors.transparent)),
                  ),
                   Container(
          color: Colors.grey.shade100,
          padding: const EdgeInsets.only(
              left: 16, top: 10, right: 16, bottom: 10),
          child: Row(
            children: [
              Icon(
                Icons.add_photo_alternate,
                color: Colors.grey.shade400,
              ),
              sized_16(size: 8.0),
              Transform.rotate(
                angle: 2.5,
                child: Icon(
                  Icons.attachment,
                  color: Colors.grey.shade400,
                ),
              ),
              Expanded(
                child: Container(),
              ),
              GestureDetector(
                onTap: () async {
                   SharedPreferences prefs = await SharedPreferences.getInstance();
                   var authToken = prefs.getString('id');
                   print(authToken);
                  _addComment(
                    comment_user_id: authToken,
                    description: commentController.text,
                    files: [
                      "https://upload.wikimedia.org/wikipedia/commons/3/3f/JPEG_example_flower.jpg",
                      "https://jpeg.org/images/jpeg-home.jpg"
                    ],
                  );
                },
                child: Text(
                  "Send",
                  style: CustomTextStyle.styleBold
                      .copyWith(color: CustomColors.colorBlue),
                ),
              )
            ],
          ),
        ),
                ],
              ),
            ),
            listComment()
          ],
        ),
      ),
    );
  }

  listComment() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return commentItem(index);
      },
      itemCount: getCommentModel.data?.length,
      primary: false,
      shrinkWrap: true,
    );
  }

  item(Widget child, {isFirst: false, isLast: false}) {
    return Column(
      children: [if (!isFirst) divider(), sized_16(), child, sized_16()],
    );
  }

  commentItem(index) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              userProfilePic(),
              sized_16(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                   "${getCommentModel.data![index].userData?.firstName}" " ${getCommentModel.data![index].userData?.lastName}",
                    style: CustomTextStyle.styleSemiBold.copyWith(fontSize: 16),
                  ),
                  sized_16(size: 4.0),
                  Text(
                    "3 Days ago",
                    style: CustomTextStyle.styleMedium
                        .copyWith(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 0, top: 8),
                child: Text(
                  getCommentModel.data![index].description ?? "Lorem ipsum dolor sit amet,consectetur\nadipiscing.",
                  style:
                  CustomTextStyle.styleMedium.copyWith(color: Colors.black),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 0, top: 8),
                child:Row(
                  children: [
                    GestureDetector(
                      child: Text(
                        "Edit",
                        style: CustomTextStyle.styleBold
                            .copyWith(color: CustomColors.colorBlue),
                      ),
                      onTap: (){
                        commentController.text = getCommentModel.data![index].description ?? "";
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => Theme(
                                data: ThemeData(
                                    bottomSheetTheme: const BottomSheetThemeData(
                                        backgroundColor: Colors.black,
                                        modalBackgroundColor: Colors.grey)),
                                child: showEditDialogContent(
                                  index,
                                  commentController,
                                    getCommentModel.data![index].id ?? 0,
                                  getCommentModel.data![index].commentUserId ?? "",
                                )));
                        /*_updateComment(
                          description: getCommentModel.data![index].description,
                          task_id: "",
                          comment_user_id: getCommentModel.data![index].commentUserId,
                          id: authToken,
                        );*/
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: GestureDetector(
                        child: Text(
                          "Delete",
                          style: CustomTextStyle.styleBold
                              .copyWith(color: CustomColors.colorBlue),
                        ),
                        onTap: (){
                          _deleteComment(
                            comment_user_id: getCommentModel.data![index].commentUserId,
                            id: getCommentModel.data![index].id,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
         /* Visibility(
              visible: index == 1,
              child: Container(
                margin: EdgeInsets.only(top: 12),
                width: double.infinity,
                height: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    "https://starsunfolded.com/wp-content/uploads/2018/03/Sakshi-Malik.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ))*/
        ],
      ),
    );
  }

  showEditDialogContent(int index,TextEditingController description,int id,String comment_user_id) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(16), topLeft: Radius.circular(16)),
            color: Colors.white),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 32,
              ),
              CustomTextField(
                //initialValue: description.text,
                label: "Description",
                minLines: 5,
                textEditingController: description,
              ),
              Container(
                margin: const EdgeInsets.only(left: 16, top: 32),
                child: Text(
                  "Choose Color",
                  style: CustomTextStyle.styleBold,
                ),
              ),
              Button(
                "Done",
                onPress: () {
                  _updateComment(
                    description: description.text,
                    task_id: "",
                    comment_user_id: comment_user_id,
                    id: id,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  title(String title) {
    return Text(
      title,
      style: CustomTextStyle.styleMedium
          .copyWith(color: Colors.grey, fontSize: 16),
    );
  }

  divider() {
    return Divider(
      height: 2,
      indent: 8,
    );
  }

  popupMenu() {
    return PopupMenuButton(
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: Text(
              "Add to Project",
              style: CustomTextStyle.styleMedium,
            ),
            value: 1,
            onTap: (){

            },
          ),
          PopupMenuItem(
            child: Text(
              "Add Member",
              style: CustomTextStyle.styleMedium,
            ),
            value: 2,
            onTap: (){

            },
          ),
          PopupMenuItem(
            child: Text(
              "Delete Task",
              style: CustomTextStyle.styleMedium,
            ),
            value: 3,
            onTap: (){
              _deleteTask(id: 31);
            },
          ),

          PopupMenuItem(
            child: Text(
              "View Tag",
              style: CustomTextStyle.styleMedium,
            ),
            value: 3,
            onTap: (){
             /* Navigator.push(
                context,MaterialPageRoute(builder: (context) =>BlocProvider<LoginBloc>(
                create: (context) => Sl.Sl<LoginBloc>(),
                child: Login(),
              )),);*/
            },
          ),
        ];
      },
      onSelected: (int value) {
        setState(() {
          selectedMenu = value;
        });
      },
      initialValue: selectedMenu,
      offset: Offset(
          0, selectedMenu == 3 ? 300 : selectedMenu == 2 ? 200 : 100),
      elevation: 4,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4)),
      icon: Icon(Icons.settings,color: Colors.white,),
    );
  }

  Future<String> _deleteTask({int? id }) {
    return Future.delayed(Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<AddTaskBloc>(context).add(
          DeleteTaskEvent(id: id ?? 0 ));
      return "";
    });
  }

  Future<String> _addComment({String? comment_user_id,List<String>? files,String? description}) {
    return Future.delayed(Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<CommentBloc>(context).add(
          AddCommentEvent(
            description: description ?? "",
            comment_user_id: int.parse(comment_user_id ?? ""),
            files: files ?? [],
          ));
      return "";
    });
  }

  Future<String> _updateComment({int? id,String? comment_user_id,String? task_id,String? description}) {
    return Future.delayed(Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<CommentBloc>(context).add(
          UpdateCommentEvent(
            id: id ?? 0,
              description: description ?? "",
              task_id: task_id ?? "",
              comment_user_id: comment_user_id ?? ""
          ));
      return "";
    });
  }

  Future<String> _deleteComment({int? id,String? comment_user_id,}) {
    return Future.delayed(Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<CommentBloc>(context).add(
          DeleteCommentEvent(
              id: id ?? 0,
              comment_user_id: comment_user_id ?? "",
          ));
      return "";
    });
  }

  Future<String> _getComment({String? comment_user_id,}) {
    return Future.delayed(Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<CommentBloc>(context).add(
          GetCommentEvent(
            comment_user_id: comment_user_id ?? "",
          ));
      return "";
    });
  }
}
