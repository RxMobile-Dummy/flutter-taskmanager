
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/ui/home/fab_menu_option/add_task/presentation/bloc/add_task_event.dart';
import 'package:task_management/ui/home/pages/add_member/presentation/bloc/add_member_bloc.dart';
import 'package:task_management/ui/home/pages/comment/data/model/get_comment_model.dart';
import 'package:task_management/ui/home/pages/comment/presentation/bloc/comment_event.dart';

import '../../../core/Strings/strings.dart';
import '../../../core/base/base_bloc.dart';
import '../../../core/error_bloc_listener/error_bloc_listener.dart';
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
  String addDescriptionText = "";

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      authToken = prefs.getString('id');
      await _getComment(comment_user_id: authToken);
      print(authToken);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ErrorBlocListener<AddTaskBloc>(
          bloc: BlocProvider.of<AddTaskBloc>(context),
          child: BlocBuilder<AddTaskBloc, BaseState>(builder: (context, state) {
            return buildWidget(context);
          })),
    );
  }

  Widget buildWidget(BuildContext context) {
    return RoundedCornerPage(
        title: "",
        backButton: false,
        showBackButton: true,
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
                    Flexible(child: Column(
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
                    ),)
                  ],
                )),
                ErrorBlocListener<CommentBloc>(
                    bloc: BlocProvider.of<CommentBloc>(context),
                    child: BlocBuilder<CommentBloc, BaseState>(
                        builder: (context, state) {
                          if(state is GetCommentState){
                            ProgressDialog.hideLoadingDialog(context);
                            getCommentModel = state.model!;
                          }else if(state is AddCommentState){
                            ProgressDialog.hideLoadingDialog(context);
                            imageFile = null;
                             _getComment(comment_user_id: authToken);
                          }else if(state is UpdateCommentState){
                            ProgressDialog.hideLoadingDialog(context);
                            Future.delayed(Duration.zero, () {
                              Navigator.of(context).pop();
                            });
                             _getComment(comment_user_id: authToken);
                          }else if(state is DeleteCommentState){
                            ProgressDialog.hideLoadingDialog(context);
                            Future.delayed(Duration.zero, () async {
                             await _getComment(comment_user_id: authToken);
                            });
                          }
                          return Column(
                            children: [
                              commentSection(context),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isCommentDisplay = !isCommentDisplay;
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
                        height: DeviceUtil.isTablet ? 120 : 80,
                        width: DeviceUtil.isTablet ? 120 : 80,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2, color: Colors.grey),
                            image: DecorationImage(
                              image: (imageFile == null || imageFile == "")
                                  ? AssetImage(
                                'assets/images/image_holder.png',
                              )
                                  : imageFile.toString().contains("static")
                                  ? NetworkImage(
                                "${Strings.baseUrl}${imageFile?.path}",

                              )
                                  : FileImage(
                                imageFile!,
                              )  as ImageProvider,
                              fit: BoxFit.fill,
                            ),
                            borderRadius: BorderRadius.circular(10,)),
                      ),
                    ),
                    TextField(
                      style: CustomTextStyle.styleMedium.copyWith(
                          fontSize: DeviceUtil.isTablet ? 16 : 14
                      ),
                      controller: commentControllerForAdd,
                      maxLines: 3,
                      maxLength: 300,
                      onChanged: (value){
                        setState(() {
                          addDescriptionText = value;
                        });
                      },
                      decoration: InputDecoration(
                          hintStyle: CustomTextStyle.styleMedium
                              .copyWith(color: Colors.grey,
                              fontSize: DeviceUtil.isTablet ? 16 : 14),
                          hintText: "Write a comment",
                          counterText: "${addDescriptionText.length}/300",
                          labelStyle: CustomTextStyle.styleSemiBold.copyWith(
                              fontSize: DeviceUtil.isTablet ? 16 : 14
                          ),
                          enabledBorder: titleBorder(color: Colors.transparent),
                          focusedBorder: titleBorder(color: Colors.transparent)),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child:  Row(
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
                            if(imageFile != null){
                              imageList?.add(imageFile!.path);
                            }
                            if(commentControllerForAdd.text.isNotEmpty){
                              _addComment(
                                comment_user_id: authToken,
                                description: commentControllerForAdd.text,
                                files: imageList,
                              );
                              commentControllerForAdd.clear();
                            }else{
                              Fluttertoast.cancel();
                              Fluttertoast.showToast(
                                msg: "Please enter comment.",
                                toastLength: Toast.LENGTH_LONG,
                                fontSize: DeviceUtil.isTablet ? 20 : 12,
                                backgroundColor: CustomColors.colorBlue,
                                textColor: Colors.white,
                              );
                            }
                          },
                          child: Text(
                            "Send",
                            style: CustomTextStyle.styleBold
                                .copyWith(color: CustomColors.colorBlue),
                          ),
                        )
                      ],
                    ),
                  )
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
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Container(
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
              ),
              Container(
                margin: const EdgeInsets.only(left: 0, top: 8),
                child: Row(
                  children: [
                    GestureDetector(
                      child:  Icon(
                        Icons.edit,color: CustomColors.colorBlue,
                        size:DeviceUtil.isTablet ? 22 : 18,
                      ),
                      onTap: () {
                        commentController.text =
                            getCommentModel.data![index].description ?? "";
                        imageFileForEdit = File(
                            getCommentModel.data![index].files!.isNotEmpty
                            ? getCommentModel.data![index].files![0]
                                : "");
                        print(".................");
                        openBottomSheet(context, index, commentController,commentController.text);
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: GestureDetector(
                        child:  Icon(
                          Icons.delete,color: CustomColors.colorBlue,
                          size: DeviceUtil.isTablet ? 22 : 18,
                        ),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (ctx) => Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: AlertDialog(
                                  title:  Text(
                                    "Delete Comment",
                                    style: TextStyle(fontSize:  DeviceUtil.isTablet ? 18 : 14),
                                  ),
                                  content:  Container(
                                    child: Text(
                                      "Are you sure you want to delete?",
                                      softWrap: true,
                                      overflow: TextOverflow.fade,
                                      style:  CustomTextStyle.styleMedium.copyWith(
                                          fontSize: DeviceUtil.isTablet ? 18 : 14
                                      ),
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () async {
                                        await _deleteComment(
                                          comment_user_id:
                                          getCommentModel.data![index].commentUserId,
                                          id: getCommentModel.data![index].id,
                                        );
                                        Future.delayed(Duration.zero, () {
                                          Navigator.of(ctx).pop();
                                        });

                                      },
                                      child: Text(
                                        "Yes",
                                        style: CustomTextStyle.styleSemiBold
                                            .copyWith(color: CustomColors.colorBlue, fontSize:
                                        DeviceUtil.isTablet ? 18 : 16),),
                                    ),
                                  ],
                                ),
                              ));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  openBottomSheet(BuildContext context, int index,
      TextEditingController textEditingController,String enterDescriptionText) {
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
                                  height: DeviceUtil.isTablet ? 120 : 80,
                                  width: DeviceUtil.isTablet ? 120 : 80,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2, color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: (imageFileForEdit!.path == null ||
                                          imageFileForEdit!.path == "")
                                          ? AssetImage("assets/images/image_holder.png")
                                     :  imageFileForEdit.toString().contains("static")
                            ? NetworkImage("${Strings.baseUrl}${imageFileForEdit?.path}")
                                          : FileImage( imageFileForEdit!) as ImageProvider,
                                      fit: BoxFit.fill
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0.5,
                                  right: 0.5,
                                  bottom: 0.1,
                                  child: Container(
                                    padding: EdgeInsets.all(2.0),
                                    alignment: Alignment.bottomCenter,
                                    color: Colors.transparent,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        InkWell(
                                          onTap: () async {
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
                                                print(imageFile);
                                                print(imageFileForEdit);
                                              });
                                            }
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
                                              setState(() {
                                                imageFileForEdit =
                                                    File(pickedFile.path);
                                                print(imageFile);
                                                print(imageFileForEdit);
                                              });
                                            }
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
                              print("OPEN");
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ), TextFormField(
                          style: CustomTextStyle.styleSemiBold.copyWith(
                              fontSize: DeviceUtil.isTablet ? 16 : 14
                          ),
                          controller: textEditingController,
                          maxLines: 5,
                          validator: (value) {
                            if (value == null || value == "") {
                              return 'Please enter description';
                            }
                            return null;
                          },
                          maxLength: 300,
                          onChanged: (value){
                            setState(() {
                              enterDescriptionText = value;
                            });
                          },
                          decoration: InputDecoration(
                              hintStyle: CustomTextStyle.styleSemiBold.copyWith(
                                  fontSize: DeviceUtil.isTablet ? 16 : 14
                              ),
                              counterText: "${enterDescriptionText.length}/300",
                              labelStyle: CustomTextStyle.styleSemiBold.copyWith(
                                  fontSize: DeviceUtil.isTablet ? 16 : 14
                              ),
                              hintText: "Description",
                              enabledBorder:
                              titleBorder(color: Colors.transparent),
                              focusedBorder:
                              titleBorder(color: Colors.transparent)),
                        ),
                        Button(
                          "Done",
                          onPress: () {
                            FocusScope.of(context).unfocus();
                            imageListForEdit = [];
                            if(imageFileForEdit!.path.isNotEmpty && !imageFileForEdit!.path.contains('static')){
                              imageListForEdit?.add(imageFileForEdit!.path);
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
                                    print(imageFile);
                                    print(imageFileForEdit);
                                }
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
                  print("OPEN");
                },
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            CustomTextField(
              label: "Description",
              minLines: 5,
              textEditingController: description,
            ),
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
    return const Divider(
      height: 2,
      indent: 8,
    );
  }

  popupMenu() {
    return PopupMenuButton(
      itemBuilder: (BuildContext c1) {
        return [
          PopupMenuItem(
            child: Text(
              "Add Member",
              style: CustomTextStyle.styleMedium.copyWith(
                fontSize: DeviceUtil.isTablet ? 16: 14
              ),
            ),
            value: 2,
          ),
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
      icon: const Icon(
        Icons.settings,
        color: Colors.white,
      ),
    );
  }

  Future<String> _deleteTask({int? id}) {
    return Future.delayed(const Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<AddTaskBloc>(context).add(DeleteTaskEvent(id: id ?? 0));
      return "";
    });
  }

  Future<String> _addComment(
      {String? comment_user_id, List<String>? files, String? description}) {
    return Future.delayed(const Duration()).then((_) {
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
    return Future.delayed(const Duration()).then((_) {
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
    return Future.delayed(const Duration()).then((_) {
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
    return Future.delayed(const Duration()).then((_) {
      BlocProvider.of<CommentBloc>(context).add(GetCommentEvent(
        comment_user_id: comment_user_id ?? "",
      ));
      return "";
    });
  }
}
