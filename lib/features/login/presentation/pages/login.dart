import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/features/login/data/model/forgot_password_model.dart';
import 'package:task_management/features/login/presentation/pages/sign_up.dart';

import '../../../../core/base/base_bloc.dart';
import '../../../../custom/progress_bar.dart';
import '../../../../ui/forgot_password.dart';
import '../../../../ui/home/fab_menu_option/add_note/presentation/bloc/add_note_bloc.dart';
import '../../../../ui/home/fab_menu_option/add_task/presentation/bloc/add_task_bloc.dart';
import '../../../../ui/home/home.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/device_file.dart';
import '../../../../utils/style.dart';
import '../../../../widget/button.dart';
import '../../../../widget/decoration.dart';
import '../../../../widget/rounded_corner_page.dart';
import '../../../../widget/textfield.dart';
import '../../data/model/login_model.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';
import 'package:task_management/injection_container.dart' as Sl;




class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isPasswordShow = true;
  LoginBloc? loginBloc;
  TextEditingController userName = TextEditingController();
  TextEditingController tiePassword = TextEditingController();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<LoginBloc, BaseState>(
        listener: (context, state) async {
          if (state is StateOnSuccess) {
            ProgressDialog.hideLoadingDialog(context);
          }else if (state is LoginState) {
            ProgressDialog.hideLoadingDialog(context);
            LoginModel? model = state.model;
            if(model!.success == true){
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
        bloc: BlocProvider.of<LoginBloc>(context),
        child:  BlocBuilder<LoginBloc, BaseState>(builder: (context, state) {
          return Form(
              key: _formKey,
              child: buildWidget());
        })
      ),
    );
  }

  Widget buildWidget(){
    return RoundedCornerPage(
      title: "Login",
      isFirstPage: true,
      child: Expanded(
        child: RoundedCornerDecoration(
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 32,
                ),
                CustomTextField(
                  key: Key("tefUsername"),
                  label: "Username",
                  isEmail: true,
                  hint: "Enter username",
                  errorMessage: "Please Enter userName",
                  textEditingController: userName,
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomTextField(
                  key: Key("tefPassword"),
                  label: "Password",
                  hint: "Enter password",
                  errorMessage: "Please Enter Password",
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
                  textEditingController: tiePassword,
                  isObscureText: isPasswordShow,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>BlocProvider<LoginBloc>(
                        create: (context) => Sl.Sl<LoginBloc>(),
                        child: ForgotPassword(),
                      )),
                    );
                   // Get.to(ForgotPassword());
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 8, top: 16, right: 16),
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forgot Password?",
                      style: CustomTextStyle.styleBold.copyWith(
                          fontSize: DeviceUtil.isTablet ? 16 : 14
                      ),
                    ),
                  ),
                ),
                Button(
                  "Login",
                  onPress: () {
                    if(_formKey.currentState!.validate()){
                      _formKey.currentState?.save();
                      FocusScope.of(context).unfocus();
                      _loginUser(userName.text,tiePassword.text);
                    }else{
                      FocusScope.of(context).unfocus();
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Don't have account ?",
                      style: CustomTextStyle.styleBold.copyWith(
                          fontSize: DeviceUtil.isTablet ? 16 : 14
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>BlocProvider<LoginBloc>(
                            create: (context) => Sl.Sl<LoginBloc>(),
                            child: SignUp(),
                          )),
                        );
                        // Get.to(ForgotPassword());
                      },
                      child:Text(
                          " Create One",
                          style: CustomTextStyle.styleBold
                              .copyWith(color: CustomColors.colorBlue,
                              fontSize: DeviceUtil.isTablet ? 16 : 14),
                        ),
                    ),
                  ],
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

  Future<String> _loginUser(String email,String password) {
    //loginBloc = BlocProvider.of<LoginBloc>(context);
    return Future.delayed(Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<LoginBloc>(context).add(
          LoginEvent(email: email.trim(), password: password.trim()));
      return "";
    });
  }
}
