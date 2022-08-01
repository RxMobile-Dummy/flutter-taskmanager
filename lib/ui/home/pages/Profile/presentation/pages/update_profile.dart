import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/features/login/presentation/bloc/login_state.dart';
import 'package:task_management/ui/home/pages/Profile/data/model/update_profile_model.dart';
import 'package:task_management/ui/home/pages/Profile/presentation/bloc/profile_bloc.dart';
import 'package:task_management/ui/home/pages/Profile/presentation/bloc/profile_state.dart';
import 'package:task_management/ui/home/pages/user_status/presentation/bloc/user_status_state.dart';

import '../../../../../../core/Strings/strings.dart';
import '../../../../../../core/base/base_bloc.dart';
import '../../../../../../custom/progress_bar.dart';
import '../../../../../../features/login/presentation/bloc/login_bloc.dart';
import '../../../../../../features/login/presentation/bloc/login_event.dart';
import '../../../../../../utils/style.dart';
import '../../../../../../widget/button.dart';
import '../../../../../../widget/decoration.dart';
import '../../../../../../widget/rounded_corner_page.dart';
import '../../../../../../widget/textfield.dart';
import '../../../user_status/presentation/bloc/user_status_bloc.dart';
import '../../../user_status/presentation/bloc/user_status_event.dart';
import '../bloc/profile_event.dart';

class UpdateProfile extends StatefulWidget {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  File? imageFile;
  int selectedUserRole;
  int selectedUserStatus;

  //GetUserStatusModel getUserStatusModel = GetUserStatusModel();
  // GetUserRoleModel getUserRoleModel = GetUserRoleModel();
  UpdateProfile({
    required this.email,
    required this.lastName,
    required this.firstName,
    required this.mobile,
    required this.imageFile,
    required this.selectedUserStatus,
    required this.selectedUserRole,
    // required this.getUserStatusModel,
    // required this.getUserRoleModel
  });

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  bool isPasswordShow = true;
  UpdateProfileBloc? updateProfileBloc;

  //TextEditingController password = TextEditingController();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  UpdateUserProfileModel updateUserProfileModel = UpdateUserProfileModel();
  List<String> userRoleList = [];
  List<String> userStatusList = [];
  String? selectRole;
  String? selectStatus;
  String? userRole;
  String? userStatus;
  List<String>? imageList;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _getUserStatus();
      await _getUserRole();
    });
    /*  for(int i=0;i< widget.getUserRoleModel.data!.length;i++){
      userRoleList.add(widget.getUserRoleModel.data![i].userRole ?? "");
    }
    for(int i=0;i< widget.getUserStatusModel.data!.length;i++){
      userStatusList.add(widget.getUserStatusModel.data![i].userStatus ?? "");
    }*/
    super.initState();
  }

  Future<String> _getUserStatus() {
    return Future.delayed(Duration()).then((_) {
      //ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<UserStatusBloc>(context).add(GetUserStatusEvent());
      return "";
    });
  }

  Future<String> _getUserRole() {
    return Future.delayed(Duration()).then((_) {
      // ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<LoginBloc>(context).add(GetUserRoleEvent());
      return "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<UpdateProfileBloc, BaseState>(
          listener: (context, state) async {
            if (state is StateOnSuccess) {
              ProgressDialog.hideLoadingDialog(context);
            } else if (state is UpdateProfileState) {
              ProgressDialog.hideLoadingDialog(context);
              updateUserProfileModel = state.model!;
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(updateUserProfileModel.message ?? ""),
              ));
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String user = jsonEncode(updateUserProfileModel.data?.toJson());
              prefs.setString('userData', user);
              Navigator.of(context).pop();
              //  Get.off(Login());
            } else if (state is StateErrorGeneral) {
              ProgressDialog.hideLoadingDialog(context);
            }
          },
          bloc: BlocProvider.of<UpdateProfileBloc>(context),
          child: BlocBuilder<UpdateProfileBloc, BaseState>(
              builder: (context, state) {
            return Form(
              key: _formKey,
              child: buildWidget(),
            );
          })),
    );
  }

  Widget buildWidget() {
    return RoundedCornerPage(
      title: "Update Profile",
      isFirstPage: true,
      child: Expanded(
        child: RoundedCornerDecoration(
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 32,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child:
                          (widget.imageFile == null || widget.imageFile == "")
                              ? Image.asset(
                                  'assets/images/image_holder.png',
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.fill,
                                )
                              : widget.imageFile.toString().contains("static")
                                  ? Image.network(
                                      "${Strings.baseUrl}${widget.imageFile?.path}",
                                      height: 120,
                                      width: 120,
                                      fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace){
                                        return const Text("IMAGE GET ERROR....");
                            }
                                    )
                                  : Image.file(
                                      widget.imageFile!,
                                      height: 120,
                                      width: 120,
                                      fit: BoxFit.cover,
                                    ),
                    ),
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) => GestureDetector(
                                onTap: () => Navigator.of(context).pop(),
                                child: Theme(
                                    data: ThemeData(
                                        bottomSheetTheme:
                                            const BottomSheetThemeData(
                                                backgroundColor: Colors.black,
                                                modalBackgroundColor:
                                                    Colors.grey)),
                                    child: showSheetForImage()),
                              ));
                      print("OPEN");
                    },
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                CustomTextField(
                  key: Key("firstName"),
                  label: "first name",
                  hint: "Enter first name",
                  errorMessage: "Please Enter first name",
                  textEditingController: widget.firstName,
                  textInputType: TextInputType.name,
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomTextField(
                  key: Key("lastName"),
                  label: "last name",
                  hint: "Enter last name",
                  errorMessage: "Please Enter last name",
                  textEditingController: widget.lastName,
                  textInputType: TextInputType.name,
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomTextField(
                  key: Key("email"),
                  label: "email",
                  hint: "Enter email",
                  errorMessage: "Please Enter email",
                  textEditingController: widget.email,
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomTextField(
                  key: Key("mobile"),
                  label: "mobile",
                  hint: "Enter mobile number",
                  errorMessage: "Please Enter mobile number",
                  textEditingController: widget.mobile,
                  textInputType: TextInputType.phone,
                ),
                const SizedBox(
                  height: 24,
                ),
                BlocBuilder<LoginBloc, BaseState>(
                  builder: (context, state) {
                    if (state is GetUserRoleState) {
                      ProgressDialog.hideLoadingDialog(context);
                      userRoleList = [];
                      for (int i = 0; i < state.model!.data!.length; i++) {
                        userRoleList.add(state.model!.data![i].userRole ?? "");
                      }
                      for (int i = 0; i < state.model!.data!.length; i++) {
                        if (widget.selectedUserRole ==
                            state.model!.data![i].id) {
                          selectRole =
                              state.model!.data![i].userRole!.toString();
                        }
                      }
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField(
                                isExpanded: true,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value == "") {
                                    return 'Please Select User role.';
                                  }
                                  return null;
                                },
                                borderRadius: BorderRadius.circular(5),
                                hint: const Text('Please choose a Role'),
                                // Not necessary for Option 1
                                value: selectRole,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectRole = newValue!;
                                  });
                                  for (int i = 0;
                                      i < state.model!.data!.length;
                                      i++) {
                                    if (selectRole ==
                                        state.model!.data![i].userRole) {
                                      userRole =
                                          state.model!.data![i].id!.toString();
                                      widget.selectedUserRole =
                                          state.model!.data![i].id!;
                                    }
                                  }
                                },
                                items: userRoleList.map((userRole) {
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
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                BlocBuilder<UserStatusBloc, BaseState>(
                  builder: (context, state) {
                    if (state is GetUserStatusState) {
                      ProgressDialog.hideLoadingDialog(context);
                      userStatusList = [];
                      for (int i = 0; i < state.model!.data!.length; i++) {
                        userStatusList
                            .add(state.model!.data![i].userStatus ?? "");
                      }
                      for (int i = 0; i < state.model!.data!.length; i++) {
                        if (widget.selectedUserStatus ==
                            state.model!.data![i].id) {
                          selectStatus =
                              state.model!.data![i].userStatus!.toString();
                        }
                      }
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField(
                                isExpanded: true,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value == "") {
                                    return 'Please Select User status.';
                                  }
                                  return null;
                                },
                                borderRadius: BorderRadius.circular(5),
                                hint: const Text('Please choose a user status'),
                                // Not necessary for Option 1
                                value: selectStatus,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectStatus = newValue ?? "";
                                  });
                                  for (int i = 0;
                                      i < state.model!.data!.length;
                                      i++) {
                                    if (selectStatus ==
                                        state.model!.data![i].userStatus) {
                                      userStatus =
                                          state.model!.data![i].id!.toString();
                                    }
                                  }
                                },
                                items: userStatusList.map((userRole) {
                                  return DropdownMenuItem(
                                    child: Text(userRole),
                                    value: userRole,
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                Button(
                  "Update Profile",
                  onPress: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState?.save();
                      imageList = [];
                     if(!widget.imageFile!.path.contains('static')){
                       imageList?.add(widget.imageFile!.path);
                     }
                      _updateProfile(
                        role: userRole == null
                            ? widget.selectedUserRole
                            : int.parse(userRole ?? ""),
                        mobile: "+91${widget.mobile.text}",
                        lastName: widget.lastName.text,
                        firstName: widget.firstName.text,
                        email: widget.email.text,
                        status_id: userStatus == null
                            ? widget.selectedUserStatus
                            : int.parse(userStatus ?? ""),
                        profilePic:  imageList,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Please fill all the detials."),
                      ));
                    }
                    //Get.off(Home());
                  },
                ),
                const SizedBox(
                  height: 48,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showSheetForImage() {
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
                  icon: const Icon(
                    Icons.camera,
                    size: 35,
                  ),
                  onPressed: () {
                    getFromCamera();
                  },
                ),
                Text(
                  "Camera",
                  style: CustomTextStyle.styleBold,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 120),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.image_outlined,
                      size: 35,
                    ),
                    onPressed: () {
                      getFromGallery();
                    },
                  ),
                  Text(
                    "Gallery",
                    style: CustomTextStyle.styleBold,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<String> _updateProfile(
      {String? email,
      List<String>? profilePic,
      String? mobile,
      String? firstName,
      String? lastName,
      int? role,
      int? status_id}) {
    return Future.delayed(Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<UpdateProfileBloc>(context).add(UpdateProfileEvent(
        email: email ?? "",
        role: role ?? 0,
        first_name: firstName ?? "",
        last_name: lastName ?? "",
        mobile_number: mobile ?? "",
        profile_pic: profilePic ?? [],
        status_id: status_id ?? 0,
      ));
      return "";
    });
  }

  getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        widget.imageFile = File(pickedFile.path);
        print(widget.imageFile);
      });
    }
  }

  getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        widget.imageFile = File(pickedFile.path);
        print(widget.imageFile);
      });
    }
  }
}
