import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/features/login/data/model/get_user_role_model.dart';
import 'package:task_management/features/login/data/model/sign_up_model.dart';
import 'package:task_management/utils/colors.dart';

import '../../../../core/base/base_bloc.dart';
import '../../../../custom/progress_bar.dart';
import '../../../../ui/home/home.dart';
import '../../../../utils/device_file.dart';
import '../../../../utils/style.dart';
import '../../../../widget/button.dart';
import '../../../../widget/decoration.dart';
import '../../../../widget/rounded_corner_page.dart';
import '../../../../widget/textfield.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';
import 'package:task_management/injection_container.dart' as Sl;

import 'login.dart';




class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isPasswordShow = true;
  LoginBloc? loginBloc;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController role = TextEditingController();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  GetUserRoleModel getUserRoleModel = GetUserRoleModel();
  List<String> userRoleList = [];
  String? _selectedUserRole;
  String? userRole;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _getUserRole();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<LoginBloc, BaseState>(
          listener: (context, state) async {
            if (state is StateOnSuccess) {
              ProgressDialog.hideLoadingDialog(context);
            }else if (state is SignUpState) {
              ProgressDialog.hideLoadingDialog(context);
              SignUpModel? model = state.model;
              if(model!.success == true){
                Fluttertoast.cancel();
                Fluttertoast.showToast(
                    msg: model.message ?? "",
                    toastLength: Toast.LENGTH_LONG,
                    fontSize: DeviceUtil.isTablet ? 20 : 12,
                    backgroundColor: CustomColors.colorBlue,
                    textColor: Colors.white
                );
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString('access', model.data!.authenticationToken!.access ?? "");
                prefs.setString('refresh', model.data!.authenticationToken!.refresh ?? "");
                prefs.setString('id', model.data?.id!.toString() ?? "");
                String user = jsonEncode(model.data?.toJson());
                prefs.setString('userData', user);
                Navigator.pushAndRemoveUntil<dynamic>(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return Home();
                  },),
                      (route) => false,
                );
              }else {
                Fluttertoast.cancel();
                Fluttertoast.showToast(
                    msg: model.error ?? "",
                    toastLength: Toast.LENGTH_LONG,
                    fontSize: DeviceUtil.isTablet ? 20 : 12,
                    backgroundColor: CustomColors.colorBlue,
                    textColor: Colors.white
                );
              }
            //  Get.off(Login());
            } else if (state is GetUserRoleState) {
            ProgressDialog.hideLoadingDialog(context);
            getUserRoleModel = state.model!;
            for(int i=0;i<getUserRoleModel.data!.length;i++){
              userRoleList.add(getUserRoleModel.data![i].userRole ?? "");
            }
            print(getUserRoleModel.message??"");
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
            }
          },
          bloc: BlocProvider.of<LoginBloc>(context),
          child:  BlocBuilder<LoginBloc, BaseState>(builder: (context, state) {
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
      title: "Sign Up",
      isFirstPage: false,
      showBackButton: true,
      child: Expanded(
        child: RoundedCornerDecoration(
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 32,
                ),
                CustomTextField(
                  key: const Key("firstName"),
                  label: "First name",
                  hint: "Enter first name",
                  errorMessage: "Please Enter first name",
                  textEditingController: firstName,
                  textInputType: TextInputType.name,
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomTextField(
                  key: const Key("lastName"),
                  label: "Last name",
                  hint: "Enter last name",
                  errorMessage: "Please Enter last name",
                  textEditingController: lastName,
                  textInputType: TextInputType.name,
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomTextField(
                  key: const Key("email"),
                  label: "Email",
                  hint: "Enter email",
                  isEmail: true,
                  errorMessage: "Please Enter email",
                  textEditingController: email,
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomTextField(
                  key: const Key("mobile"),
                  label: "Mobile",
                  isMobile: true,
                  hint: "Enter mobile number",
                  errorMessage: "Please Enter mobile number",
                  textEditingController: mobile,
                  textInputType: TextInputType.phone,
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomTextField(
                  key: const Key("password"),
                  label: "Password",
                  hint: "Enter password",
                  errorMessage: "Please Enter password",
                  icon: IconButton(
                      icon: Icon(
                        isPasswordShow
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordShow = !isPasswordShow;
                        });
                      }),
                  isObscureText: isPasswordShow,
                  textEditingController: password,
                ),
                const SizedBox(
                  height: 24,
                ),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 10),
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
                       hintStyle: CustomTextStyle.styleSemiBold.copyWith(
                           fontSize: DeviceUtil.isTablet ? 16 : 14
                       ),
                       labelStyle: CustomTextStyle.styleSemiBold.copyWith(
                           fontSize: DeviceUtil.isTablet ? 16 : 14
                       ),
                     ),
                     validator: (value) {
                       if (value == null || value == "") {
                         return 'Please Select User role.';
                       }
                       return null;
                     },
                     borderRadius: BorderRadius.circular(5),
                     hint: const Text('Please choose a user Role'), // Not necessary for Option 1
                     value: _selectedUserRole,
                     onChanged: (String? newValue) {
                       setState(() {
                         _selectedUserRole = newValue;
                       });
                       for(int i=0;i<getUserRoleModel.data!.length;i++){
                         if(_selectedUserRole == getUserRoleModel.data![i].userRole){
                           userRole = getUserRoleModel.data![i].id!.toString();
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
           ),
                /*CustomTextField(
                  key: Key("role"),
                  label: "Role",
                  hint: "Enter role",
                  errorMessage: "Please Enter role",
                  textEditingController: role,
                  textInputType: TextInputType.name,
                ),*/
                Button(
                  "Sign Up",
                  onPress: () {
                    FocusScope.of(context).unfocus();
                    if(_formKey.currentState!.validate()){
                      _formKey.currentState?.save();
                      _signUpUser(
                        role: userRole,
                        password: password.text,
                        mobile: "+91${mobile.text}",
                        lastName: lastName.text,
                        firstName: firstName.text,
                        email: email.text,
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
                    //Get.off(Home());
                  },
                ),
                /*const SizedBox(
                  height: 48,
                )*/
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> _signUpUser({String? email, String? password,String? mobile,String? firstName,String? lastName, String? role}) {
    //loginBloc = BlocProvider.of<LoginBloc>(context);
    return Future.delayed(Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<LoginBloc>(context).add(
          SignUpEvent(
            email: email?.trim(),
            firstName: firstName?.trim(),
            lastName: lastName?.trim(),
            mobile: mobile?.trim(),
            password: password?.trim(),
            role: role?.trim(),
          ));
      return "";
    });
  }
  Future<String> _getUserRole() {
    return Future.delayed(Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<LoginBloc>(context).add(
          GetUserRoleEvent());
      return "";
    });
  }

}
