
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/delete_task_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/data/model/get_task_model.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/presentation/bloc/add_task_event.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/presentation/bloc/add_task_state.dart';
import 'package:task_management/ui/home/pages/add_member/presentation/bloc/add_member_bloc.dart';
import 'package:task_management/ui/home/pages/comment/data/model/add_comment_model.dart';
import 'package:task_management/ui/home/pages/comment/data/model/delete_comment_model.dart';
import 'package:task_management/ui/home/pages/comment/data/model/get_comment_model.dart';
import 'package:task_management/ui/home/pages/comment/data/model/update_comment_model.dart';
import 'package:task_management/ui/home/pages/comment/presentation/bloc/comment_event.dart';

import '../../../core/Strings/strings.dart';
import '../../../core/base/base_bloc.dart';
import '../../../custom/progress_bar.dart';
import '../../../utils/border.dart';
import '../../../utils/colors.dart';
import '../../../utils/device_file.dart';
import '../../../utils/style.dart';
import '../../../widget/button.dart';
import '../../../widget/decoration.dart';
import '../../../widget/profile_pi.dart';
import '../../../widget/rounded_corner_page.dart';
import '../../../widget/size.dart';
import '../../../widget/textfield.dart';
import '../fab_menu_option/add_task/presentation/bloc/add_task_bloc.dart';
import '../pages/add_member/presentation/pages/add_member_page.dart';
import '../pages/comment/presentation/bloc/comment_bloc.dart';
import '../pages/comment/presentation/bloc/comment_state.dart';
import 'package:task_management/injection_container.dart' as Sl;

class TaskDetails extends StatefulWidget {
  var getTaskModel;

  TaskDetails({required this.getTaskModel});

  @override
  _TaskDetailsState createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  var isCommentDisplay = false;
  int selectedMenu = 0;
  GetCommentModel getCommentModel = GetCommentModel();
  TextEditingController commentController = TextEditingController();
  TextEditingController commentControllerForAdd = TextEditingController();
  var authToken;
  File? imageFile;
  File? imageFileForEdit;
  List<String>? imageList;
  List<String>? imageListForEdit;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      authToken = prefs.getString('id');
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
              if(model!.success == true){
                Fluttertoast.showToast(
                    msg: model.message ?? "",
                    toastLength: Toast.LENGTH_LONG,
                    fontSize: DeviceUtil.isTablet ? 20 : 12,
                    backgroundColor: CustomColors.colorBlue,
                    textColor: Colors.white
                );
                Navigator.of(context).pop();
              }else{
                Fluttertoast.showToast(
                    msg: model.error ?? "",
                    toastLength: Toast.LENGTH_LONG,
                    fontSize: DeviceUtil.isTablet ? 20 : 12,
                    backgroundColor: CustomColors.colorBlue,
                    textColor: Colors.white
                );
              }
            } else if (state is StateErrorGeneral) {
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
         // bloc: BlocProvider.of<AddTaskBloc>(context),
          child: BlocBuilder<AddTaskBloc, BaseState>(builder: (context, state) {
            return buildWidget(context);
          })),
    );
  }

  Widget buildWidget(BuildContext context) {
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
                const SizedBox(
                  height: 24,
                ),
                Text(
                  widget.getTaskModel
                      .name /*"Meeting according with design team in Central Park"*/,
                  maxLines: 3,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextStyle.styleBold.copyWith(
                    fontSize: DeviceUtil.isTablet ? 20 : 16,
                  ),
                ),
                sized_16(size: 32.0),
            /*    item(
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
                    isFirst: true),*/
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
                          widget.getTaskModel.startDate,
                          style: CustomTextStyle.styleSemiBold
                              .copyWith(fontSize: DeviceUtil.isTablet ? 16 : 14,),
                        )
                      ],
                    ),
                  ],
                )),
                item(Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
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
                          widget.getTaskModel
                              .description /*"Lorem ipsum dolor sit amet,\nconsectetur adipiscing."*/,
                          style: CustomTextStyle.styleSemiBold
                              .copyWith(fontSize: DeviceUtil.isTablet ? 16 : 14),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ],
                )),
            /*    item(Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
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
                )),*/
                /*  item(Row(
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
                        */ /*Column(
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
                        ),*/ /*
                      ],
                    )),*/
                BlocListener<CommentBloc, BaseState>(
                    listener: (context, state) async {
                      if (state is StateOnSuccess) {
                        ProgressDialog.hideLoadingDialog(context);
                      } else if (state is GetCommentState) {
                        ProgressDialog.hideLoadingDialog(context);
                        // GetCommentModel? model = state.model;
                        getCommentModel = state.model!;
                       if(getCommentModel.success == true){
                         Fluttertoast.showToast(
                             msg: getCommentModel.message ?? "",
                             toastLength: Toast.LENGTH_LONG,
                             fontSize: DeviceUtil.isTablet ? 20 : 12,
                             backgroundColor: CustomColors.colorBlue,
                             textColor: Colors.white
                         );
                       }else{
                         Fluttertoast.showToast(
                             msg: getCommentModel.error ?? "",
                             toastLength: Toast.LENGTH_LONG,
                             fontSize: DeviceUtil.isTablet ? 20 : 12,
                             backgroundColor: CustomColors.colorBlue,
                             textColor: Colors.white
                         );
                       }
                        // Navigator.of(context).pop();
                      } else if (state is AddCommentState) {
                        ProgressDialog.hideLoadingDialog(context);
                        AddCommentModel? model = state.model;
                        if(model!.success == true){
                          Fluttertoast.showToast(
                              msg: model.message ?? "",
                              toastLength: Toast.LENGTH_LONG,
                              fontSize: DeviceUtil.isTablet ? 20 : 12,
                              backgroundColor: CustomColors.colorBlue,
                              textColor: Colors.white
                          );
                          imageFile = null;
                          await _getComment(comment_user_id: authToken);
                        }else{
                          Fluttertoast.showToast(
                              msg: model.error ?? "",
                              toastLength: Toast.LENGTH_LONG,
                              fontSize: DeviceUtil.isTablet ? 20 : 12,
                              backgroundColor: CustomColors.colorBlue,
                              textColor: Colors.white
                          );
                        }
                        //Navigator.of(context).pop();
                      } else if (state is UpdateCommentState) {
                        ProgressDialog.hideLoadingDialog(context);
                        UpdateCommentModel? model = state.model;
                        if(model!.success == true){
                          Fluttertoast.showToast(
                              msg: model.message ?? "",
                              toastLength: Toast.LENGTH_LONG,
                              fontSize: DeviceUtil.isTablet ? 20 : 12,
                              backgroundColor: CustomColors.colorBlue,
                              textColor: Colors.white
                          );
                          Navigator.of(context).pop();
                          await _getComment(comment_user_id: authToken);
                        }else{
                          Fluttertoast.showToast(
                              msg: model.error ?? "",
                              toastLength: Toast.LENGTH_LONG,
                              fontSize: DeviceUtil.isTablet ? 20 : 12,
                              backgroundColor: CustomColors.colorBlue,
                              textColor: Colors.white
                          );
                        }
                      } else if (state is DeleteCommentState) {
                        ProgressDialog.hideLoadingDialog(context);
                        DeleteCommentModel? model = state.model;
                        if(model!.success == true){
                          Fluttertoast.showToast(
                              msg: model.message ?? "",
                              toastLength: Toast.LENGTH_LONG,
                              fontSize: DeviceUtil.isTablet ? 20 : 12,
                              backgroundColor: CustomColors.colorBlue,
                              textColor: Colors.white
                          );
                          await _getComment(comment_user_id: authToken);
                        }else{
                          Fluttertoast.showToast(
                              msg: model.error ?? "",
                              toastLength: Toast.LENGTH_LONG,
                              fontSize: DeviceUtil.isTablet ? 20 : 12,
                              backgroundColor: CustomColors.colorBlue,
                              textColor: Colors.white
                          );
                        }
                      } else if (state is StateErrorGeneral) {
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
                    bloc: BlocProvider.of<CommentBloc>(context),
                    child: BlocBuilder<CommentBloc, BaseState>(
                        builder: (context, state) {
                      return Column(
                        children: [
                          commentSection(context),
                        /*  Button(
                            "Complete Task",
                            onPress: () {},
                            horizontalMargin: 0,
                            verticalMargin: 8,
                          ),*/
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
                    })),
                sized_16()
              ],
            ),
          ),
        ))));
  }

  commentSection(BuildContext context) {
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
              child:Padding(
                padding: EdgeInsets.symmetric(horizontal: 16,vertical: 5),
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){
                        FocusScope.of(context).unfocus();
                        showModalBottomSheet(
                            context: context,
                            builder: (context1) => GestureDetector(
                              onTap: () => Navigator.of(context1).pop(),
                              child: Theme(
                                  data: ThemeData(
                                      bottomSheetTheme:
                                      const BottomSheetThemeData(
                                          backgroundColor:
                                          Colors.black,
                                          modalBackgroundColor:
                                          Colors.grey)),
                                  child: showSheetForImage(context)),
                            ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.grey),
                            borderRadius: BorderRadius.circular(10,)),
                        child:
                        (imageFile == null || imageFile == "")
                            ? Image.asset(
                          'assets/images/image_holder.png',
                          height: DeviceUtil.isTablet ? 120 : 80,
                          width: DeviceUtil.isTablet ? 120 : 80,
                          fit: BoxFit.fill,
                        )
                            : imageFile.toString().contains("static")
                            ? Image.network(
                            "${Strings.baseUrl}${imageFile?.path}",
                            height: DeviceUtil.isTablet ? 120 : 80,
                            width: DeviceUtil.isTablet ? 120 : 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace){
                              return const Text("IMAGE GET ERROR....");
                            }
                        )
                            : Image.file(
                          imageFile!,
                          height:  DeviceUtil.isTablet ? 120 : 80,
                          width:  DeviceUtil.isTablet ? 120 : 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    TextField(
                      style: CustomTextStyle.styleMedium.copyWith(
                          fontSize: DeviceUtil.isTablet ? 16 : 14
                      ),
                      controller: commentControllerForAdd,
                      maxLines: 3,
                      decoration: InputDecoration(
                          hintStyle: CustomTextStyle.styleMedium
                              .copyWith(color: Colors.grey,
                              fontSize: DeviceUtil.isTablet ? 16 : 14),
                          hintText: "Write a comment",
                          labelStyle: CustomTextStyle.styleSemiBold.copyWith(
                              fontSize: DeviceUtil.isTablet ? 16 : 14
                          ),
                          enabledBorder: titleBorder(color: Colors.transparent),
                          focusedBorder: titleBorder(color: Colors.transparent)),
                    ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.end,
                     children: [
                       GestureDetector(
                         onTap: () async {
                           FocusScope.of(context).unfocus();
                           SharedPreferences prefs =
                           await SharedPreferences.getInstance();
                           var authToken = prefs.getString('id');
                           print(authToken);
                           imageList = [];
                           imageList?.add(imageFile!.path);
                           _addComment(
                             comment_user_id: authToken,
                             description: commentControllerForAdd.text,
                             files: imageList,
                           );
                           commentControllerForAdd.clear();
                         },
                         child: Text(
                           "Send",
                           style: CustomTextStyle.styleBold
                               .copyWith(color: CustomColors.colorBlue),
                         ),
                       )
                     ],
                   )
                   /* Container(
                      color: Colors.grey.shade100,
                      padding: const EdgeInsets.only(
                          left: 16, top: 10, right: 16, bottom: 10),
                      child: Row(
                        children: [
                          *//* IconButton(
                          icon: Icon(
                            Icons.add_photo_alternate,
                            color: Colors.grey.shade400,
                          ),
                          onPressed: () {
                          },
                        ),*//*

                          sized_16(size: 8.0),
                          *//* Transform.rotate(
                          angle: 2.5,
                          child: Icon(
                            Icons.attachment,
                            color: Colors.grey.shade400,
                          ),
                        ),*//*
                          Expanded(
                            child: Container(),
                          ),
                          GestureDetector(
                            onTap: () async {
                              FocusScope.of(context).unfocus();
                              SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                              var authToken = prefs.getString('id');
                              print(authToken);
                              imageList = [];
                              imageList?.add(imageFile!.path);
                              _addComment(
                                comment_user_id: authToken,
                                description: commentController.text,
                                files: imageList,
                              );
                              commentController.clear();
                            },
                            child: Text(
                              "Send",
                              style: CustomTextStyle.styleBold
                                  .copyWith(color: CustomColors.colorBlue),
                            ),
                          )
                        ],
                      ),
                    ),*/
                  ],
                ),
              ),
            ),
            getCommentModel.data != null
                ? getCommentModel.data!.length <= 0
                    ? SizedBox()
                    : listComment(context)
                : SizedBox()
          ],
        ),
      ),
    );
  }

  showSheetForImage(BuildContext context, {bool isEdit = false}) {
    return Material(
      child: Container(
        height: 150,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(16), topLeft: Radius.circular(16)),
            color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon:  Icon(
                    Icons.camera,
                    size: DeviceUtil.isTablet ? 35 : 25,
                  ),
                  onPressed: () {
                    Get.back();
                    getFromCamera(context, isEdit: isEdit);
                    //Navigator.pop(context);
                  },
                ),
                Text(
                  "Camera",
                  style: CustomTextStyle.styleBold.copyWith(
                    fontSize: DeviceUtil.isTablet ? 16 : 12
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 120),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon:  Icon(
                      Icons.image_outlined,
                      size: DeviceUtil.isTablet ? 35 : 25,
                    ),
                    onPressed: () {
                      Get.back();
                      getFromGallery(context, isEdit: isEdit);
                    },
                  ),
                  Text(
                    "Gallery",
                    style: CustomTextStyle.styleBold.copyWith(
                        fontSize: DeviceUtil.isTablet ? 16 : 12
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  getFromCamera(BuildContext context, {bool isEdit = false}) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        if (isEdit == true) {
          imageFileForEdit = File(pickedFile.path);
        } else {
          imageFile = File(pickedFile.path);
        }
        //isEdit ? imageFileForEdit : imageFile = File(pickedFile.path);
        print(imageFile);
        print(imageFileForEdit);
      });
    }
  }

  getFromGallery(BuildContext context, {bool isEdit = false}) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        if (isEdit == true) {
          imageFileForEdit = File(pickedFile.path);
        } else {
          imageFile = File(pickedFile.path);
        }
        //  isEdit ? imageFileForEdit : imageFile = File(pickedFile.path);
        print(imageFile);
        print(imageFileForEdit);
      });
    }
  }

  listComment(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return commentItem(index, context);
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

  commentItem(index, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              userProfilePic(
                  radius: 30.0,
                  imagePath: (getCommentModel.data![index].files!.isEmpty)
                      ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRA7ECizMinUV4oPQG6BUFIZZmeXehbj7pytQ&usqp=CAU"
                      : "${Strings.baseUrl}${getCommentModel.data![index].files![0]}"),
              sized_16(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${getCommentModel.data![index].userData?.firstName}"
                    " ${getCommentModel.data![index].userData?.lastName}",
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyle.styleSemiBold.copyWith(fontSize: DeviceUtil.isTablet ? 16 : 14),
                  ),
                  sized_16(size: 4.0),
                  /*Text(
                    "${getCommentModel.data![index].userData?.email}",
                    style: CustomTextStyle.styleMedium
                        .copyWith(fontSize: 14, color: Colors.grey),
                  ),*/
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
                  getCommentModel.data![index].description ??
                      "Lorem ipsum dolor sit amet,consectetur\nadipiscing.",
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style:
                      CustomTextStyle.styleMedium.copyWith(color: Colors.black,
                        fontSize: DeviceUtil.isTablet ? 16 : 14
                      ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 0, top: 8),
                child: Row(
                  children: [
                    GestureDetector(
                      child:  Icon(
                        Icons.edit,color: CustomColors.colorBlue,
                        size:DeviceUtil.isTablet ? 22 : 18,
                      ),/*Text(
                        "Edit",
                        style: CustomTextStyle.styleBold
                            .copyWith(color: CustomColors.colorBlue),
                      ),*/
                      onTap: () {
                        commentController.text =
                            getCommentModel.data![index].description ?? "";
                        imageFileForEdit =
                            File(getCommentModel.data![index].files![0]);
                        print(".................");
                        openBottomSheet(context, index, commentController);
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
                        child:  Icon(
                          Icons.delete,color: CustomColors.colorBlue,
                          size: DeviceUtil.isTablet ? 22 : 18,
                        ),/*Text(
                          "Delete",
                          style: CustomTextStyle.styleBold
                              .copyWith(color: CustomColors.colorBlue),
                        ),*/
                        onTap: () {
                          _deleteComment(
                            comment_user_id:
                                getCommentModel.data![index].commentUserId,
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

  openBottomSheet(BuildContext context, int index,
      TextEditingController textEditingController) {
    showModalBottomSheet(
        context: context,
        builder: (context1) {
          return  StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Theme(
                data: ThemeData(
                    bottomSheetTheme: const BottomSheetThemeData(
                        backgroundColor: Colors.black,
                        modalBackgroundColor: Colors.grey)),
                // child: showEditDialogContent(
                //     index,
                //     textEditingController,
                //     getCommentModel.data![index].id ?? 0,
                //     getCommentModel.data![index].commentUserId ?? "",
                //     context1)
                child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: SingleChildScrollView(
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(16),
                            topLeft: Radius.circular(16)),
                        color: Colors.white),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 32,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: GestureDetector(
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2, color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: (imageFileForEdit == null ||
                                      imageFileForEdit == "")
                                      ? Image.asset(
                                    'assets/images/image_holder.png',
                                    height: DeviceUtil.isTablet ? 120 : 80,
                                    width: DeviceUtil.isTablet ? 120 : 80,
                                    fit: BoxFit.fill,
                                  )
                                      : imageFileForEdit
                                      .toString()
                                      .contains("static")
                                      ? Image.network(
                                    "${Strings.baseUrl}${imageFileForEdit?.path}",
                                    height: DeviceUtil.isTablet ? 120 : 80,
                                    width: DeviceUtil.isTablet ? 120 : 80,
                                    fit: BoxFit.cover,
                                  )
                                      : Image.file(
                                    imageFileForEdit!,
                                    height: DeviceUtil.isTablet ? 120 : 80,
                                    width: DeviceUtil.isTablet ? 120 : 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  left: 0.5,
                                  right: 0.5,
                                  bottom: 0.1,
                                  child: Container(
                                    padding: EdgeInsets.all(2.0),
                                    alignment: Alignment.bottomCenter,
                                    color: Colors.black26,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        InkWell(
                                          onTap: () async {
                                            // Get.back();
                                            PickedFile? pickedFile =
                                            await ImagePicker().getImage(
                                              source: ImageSource.camera,
                                              maxWidth: 1800,
                                              maxHeight: 1800,
                                            );
                                            if (pickedFile != null) {
                                              setState(() {
                                                imageFileForEdit =
                                                    File(pickedFile.path);
                                                //isEdit ? imageFileForEdit : imageFile = File(pickedFile.path);
                                                print(imageFile);
                                                print(imageFileForEdit);
                                              });
                                            }
                                            /* getFromCamera(context,
                                                isEdit: true);*/
                                          },
                                          child: const Icon(
                                            Icons.camera,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            //  Get.back();
                                            PickedFile? pickedFile =
                                            await ImagePicker().getImage(
                                              source: ImageSource.gallery,
                                              maxWidth: 1800,
                                              maxHeight: 1800,
                                            );
                                            if (pickedFile != null) {
                                              setState(() {
                                                imageFileForEdit =
                                                    File(pickedFile.path);
                                                //  isEdit ? imageFileForEdit : imageFile = File(pickedFile.path);
                                                print(imageFile);
                                                print(imageFileForEdit);
                                              });
                                            }
                                            // getFromGallery(context,isEdit: true);
                                          },
                                          child: const Icon(
                                            Icons.image_outlined,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              /* showModalBottomSheet(
                      context: context,
                      builder: (context1) => GestureDetector(
                        onTap: () => Navigator.of(context1).pop(),
                        child: Theme(
                            data: ThemeData(
                                bottomSheetTheme:
                                const BottomSheetThemeData(
                                    backgroundColor: Colors.black,
                                    modalBackgroundColor:
                                    Colors.grey)),
                            child: showSheetForImage(context1,
                                isEdit: true)),
                      ));*/
                              print("OPEN");
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        CustomTextField(
                          //initialValue: description.text,
                          label: "Description",
                          minLines: 5,
                          textEditingController: textEditingController,
                        ),
                        Button(
                          "Done",
                          onPress: () {
                            FocusScope.of(context).unfocus();
                            imageListForEdit = [];
                            imageListForEdit?.add(imageFileForEdit!.path);
                            if(!imageFileForEdit!.path.contains('static')){
                              imageList?.add(imageFileForEdit!.path);
                            }
                            _updateComment(
                              description: textEditingController.text,
                              task_id: "",
                              comment_user_id:
                              getCommentModel.data![index].commentUserId ??
                                  "",
                              id: getCommentModel.data![index].id ?? 0,
                              files: imageListForEdit,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                )));
          });
        });
  }

  showEditDialogContent(int index, TextEditingController description, int id,
      String comment_user_id, BuildContext context) {
    return Container(
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
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: GestureDetector(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child:
                          (imageFileForEdit == null || imageFileForEdit == "")
                              ? Image.asset(
                                  'assets/images/image_holder.png',
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.fill,
                                )
                              : imageFileForEdit.toString().contains("static")
                                  ? Image.network(
                                      "${Strings.baseUrl}${imageFileForEdit?.path}",
                                      height: 120,
                                      width: 120,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      imageFileForEdit!,
                                      height: 120,
                                      width: 120,
                                      fit: BoxFit.cover,
                                    ),
                    ),
                    Positioned(
                      left: 0.5,
                      right: 0.5,
                      bottom: 0.1,
                      child: Container(
                        padding: EdgeInsets.all(2.0),
                        alignment: Alignment.bottomCenter,
                        color: Colors.black26,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                getFromCamera(context, isEdit: true);
                              },
                              child: const Icon(
                                Icons.camera,
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                PickedFile? pickedFile =
                                    await ImagePicker().getImage(
                                  source: ImageSource.gallery,
                                  maxWidth: 1800,
                                  maxHeight: 1800,
                                );
                                if (pickedFile != null) {
                                    imageFileForEdit = File(pickedFile.path);
                                    //  isEdit ? imageFileForEdit : imageFile = File(pickedFile.path);
                                    print(imageFile);
                                    print(imageFileForEdit);
                                }
                                // getFromGallery(context,isEdit: true);
                              },
                              child: const Icon(
                                Icons.image_outlined,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  /* showModalBottomSheet(
                      context: context,
                      builder: (context1) => GestureDetector(
                        onTap: () => Navigator.of(context1).pop(),
                        child: Theme(
                            data: ThemeData(
                                bottomSheetTheme:
                                const BottomSheetThemeData(
                                    backgroundColor: Colors.black,
                                    modalBackgroundColor:
                                    Colors.grey)),
                            child: showSheetForImage(context1,
                                isEdit: true)),
                      ));*/
                  print("OPEN");
                },
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            CustomTextField(
              //initialValue: description.text,
              label: "Description",
              minLines: 5,
              textEditingController: description,
            ),
            /* Container(
                margin: const EdgeInsets.only(left: 16, top: 32),
                child: Text(
                  "Choose Color",
                  style: CustomTextStyle.styleBold,
                ),
              ),*/
            Button(
              "Done",
              onPress: () {
                FocusScope.of(context).unfocus();
                imageListForEdit = [];
                imageListForEdit?.add(imageFileForEdit!.path);
                _updateComment(
                  description: description.text,
                  task_id: "",
                  comment_user_id: comment_user_id,
                  id: id,
                  files: imageListForEdit,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  title(String title) {
    return Text(
      title,
      style: CustomTextStyle.styleMedium
          .copyWith(color: Colors.grey, fontSize: DeviceUtil.isTablet ? 16 : 14,),
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
      itemBuilder: (BuildContext c1) {
        return [
        /*  PopupMenuItem(
            child: Text(
              "Add to Project",
              style: CustomTextStyle.styleMedium,
            ),
            value: 1,
            onTap: () {},
          ),*/
          PopupMenuItem(
            child: Text(
              "Add Member",
              style: CustomTextStyle.styleMedium.copyWith(
                fontSize: DeviceUtil.isTablet ? 16: 14
              ),
            ),
            value: 2,
          ),
        /*  PopupMenuItem(
            child: Text(
              "Delete Task",
              style: CustomTextStyle.styleMedium,
            ),
            value: 3,
            onTap: () {
              _deleteTask(id: 31);
            },
          ),*/
        ];
      },
      onSelected: (int value) {
        setState(() {
          selectedMenu = value;
        });

        if (value == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>
            MultiBlocProvider(
              providers: [
                BlocProvider<AddMemberBloc>(
                  create: (context) => Sl.Sl<AddMemberBloc>(),
                ),
              ],
              child: GetAllUserList(project_id: widget.getTaskModel.projectId),
            )),
          );
        }
      },
      initialValue: selectedMenu,
      offset: Offset(
          0,
          selectedMenu == 3
              ? 300
              : selectedMenu == 2
                  ? 200
                  : 100),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      icon: Icon(
        Icons.settings,
        color: Colors.white,
      ),
    );
  }

  Future<String> _deleteTask({int? id}) {
    return Future.delayed(Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<AddTaskBloc>(context).add(DeleteTaskEvent(id: id ?? 0));
      return "";
    });
  }

  Future<String> _addComment(
      {String? comment_user_id, List<String>? files, String? description}) {
    return Future.delayed(Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<CommentBloc>(context).add(AddCommentEvent(
        description: description ?? "",
        comment_user_id: int.parse(comment_user_id ?? ""),
        files: files ?? [],
      ));
      return "";
    });
  }

  Future<String> _updateComment(
      {int? id,
      String? comment_user_id,
      String? task_id,
      String? description,
      List<String>? files}) {
    return Future.delayed(Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<CommentBloc>(context).add(UpdateCommentEvent(
        id: id ?? 0,
        description: description ?? "",
        task_id: task_id ?? "",
        comment_user_id: comment_user_id ?? "",
        files: files ?? [],
      ));
      return "";
    });
  }

  Future<String> _deleteComment({
    int? id,
    String? comment_user_id,
  }) {
    return Future.delayed(Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<CommentBloc>(context).add(DeleteCommentEvent(
        id: id ?? 0,
        comment_user_id: comment_user_id ?? "",
      ));
      return "";
    });
  }

  Future<String> _getComment({
    String? comment_user_id,
  }) {
    return Future.delayed(Duration()).then((_) {
      //ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<CommentBloc>(context).add(GetCommentEvent(
        comment_user_id: comment_user_id ?? "",
      ));
      return "";
    });
  }
}
