import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:task_management/features/login/data/model/reset_passward_model.dart';
import 'package:task_management/features/login/presentation/bloc/login_state.dart';
import 'package:task_management/ui/reset_success.dart';
import 'package:task_management/utils/colors.dart';

import '../core/base/base_bloc.dart';
import '../custom/progress_bar.dart';
import '../features/login/data/model/forgot_password_model.dart';
import '../features/login/presentation/bloc/login_bloc.dart';
import '../features/login/presentation/bloc/login_event.dart';
import '../utils/device_file.dart';
import '../utils/style.dart';
import '../widget/button.dart';
import '../widget/rounded_corner_page.dart';
import '../widget/textfield.dart';

class ResetPassword extends StatefulWidget {
  String email;
  ResetPassword({required this.email});
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool isNewPasswordShow = true, isConfirmPasswordShow = true;
  TextEditingController tieNewPassword = TextEditingController();
  TextEditingController tieConfirmPassword = TextEditingController();
  TextEditingController resetCode = TextEditingController();
  final GlobalKey<FormState> _formKey =  GlobalKey<FormState>();
  int secondsRemaining = 60;
  bool enableResend = false;
  Timer? timer;

  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
    super.initState();
  }


  @override
  dispose(){
    timer!.cancel();
    super.dispose();
  }

  void _resendCode() {
    setState((){
      secondsRemaining = 60;
      enableResend = false;
      _forgotPassward(widget.email);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<LoginBloc, BaseState>(
          listener: (context, state) {
            if (state is StateOnSuccess) {
              ProgressDialog.hideLoadingDialog(context);
            } else if (state is ResetPasswordStatus) {
              ProgressDialog.hideLoadingDialog(context);
              ResetPasswardModel? model = state.model;
              if(model!.success == true){
                Fluttertoast.showToast(
                    msg: model.message ?? "",
                    toastLength: Toast.LENGTH_LONG,
                    fontSize: DeviceUtil.isTablet ? 20 : 12,
                    backgroundColor: CustomColors.colorBlue,
                    textColor: Colors.white
                );
                Get.to(ResetSuccess());
              }else{
                Fluttertoast.showToast(
                    msg: model.error ?? "",
                    toastLength: Toast.LENGTH_LONG,
                    fontSize: DeviceUtil.isTablet ? 20 : 12,
                    backgroundColor: CustomColors.colorBlue,
                    textColor: Colors.white
                );
              }
            } else if (state is ForgotPasswordStatus) {
              ProgressDialog.hideLoadingDialog(context);
              ForgotPasswordModel? model = state.model;
             if(model!.success == true){
               Fluttertoast.showToast(
                   msg: model.message ?? "",
                   toastLength: Toast.LENGTH_LONG,
                   fontSize: DeviceUtil.isTablet ? 20 : 12,
                   backgroundColor: CustomColors.colorBlue,
                   textColor: Colors.white
               );
             }else{
               Fluttertoast.showToast(
                   msg: model.error ?? "",
                   toastLength: Toast.LENGTH_LONG,
                   fontSize: DeviceUtil.isTablet ? 20 : 12,
                   backgroundColor: CustomColors.colorBlue,
                   textColor: Colors.white
               );
             }
              // Get.off(ResetPassword());
            }else if (state is StateErrorGeneral) {
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
        title: "Reset Password",
        child: Expanded(
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16))),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  CustomTextField(
                    key: const Key("tefResetCode"),
                    label: "Reset code",
                    hint: "Enter code",
                    errorMessage: "Please enter reset code.",
                    textEditingController: resetCode,
                    textInputType: TextInputType.number,
                    lengthLimit: 6,
                  ),
                  const SizedBox(height: 32,),
                  CustomTextField(
                    key: const Key("tefPassword"),
                    label: "New password",
                    errorMessage: "Please enter password",
                    hint: "Enter your password",
                    icon: IconButton(
                        icon: Icon(
                          isNewPasswordShow
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            isNewPasswordShow = !isNewPasswordShow;
                          });
                        }),
                    textEditingController: tieNewPassword,
                    isObscureText: isNewPasswordShow,
                  ),
                  const SizedBox(height: 32,),
                  CustomTextField(
                    key: const Key("tefConfirmPassword"),
                    label: "Confirm password",
                    errorMessage: "Please enter password",
                    hint: "Enter your confirm password",
                    icon: IconButton(
                        icon: Icon(
                          isConfirmPasswordShow
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            isConfirmPasswordShow = !isConfirmPasswordShow;
                          });
                        }),
                    textEditingController: tieConfirmPassword,
                    isObscureText: isConfirmPasswordShow,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Button(
                    "Change Password",
                    onPress: () {
                      FocusScope.of(context).unfocus();
                      if(_formKey.currentState!.validate()){
                        _formKey.currentState?.save();
                        if(tieNewPassword.text == tieConfirmPassword.text){
                          _resetPassward(tieNewPassword.text,resetCode.text);
                        }else{
                          Fluttertoast.showToast(
                              msg: "Password does not same.",
                              toastLength: Toast.LENGTH_LONG,
                              fontSize: DeviceUtil.isTablet ? 20 : 12,
                              backgroundColor: CustomColors.colorBlue,
                              textColor: Colors.white
                          );
                        }
                      }else{
                        Fluttertoast.showToast(
                            msg: "Please fill all the details.",
                            toastLength: Toast.LENGTH_LONG,
                            fontSize: DeviceUtil.isTablet ? 20 : 12,
                            backgroundColor: CustomColors.colorBlue,
                            textColor: Colors.white
                        );
                      }
                      //Get.to(ResetSuccess());
                    },
                  ),
                  const SizedBox(height: 20),
                 Center(
                   child:  Text(
                     'after $secondsRemaining seconds',
                     style: CustomTextStyle.styleBold.copyWith(fontSize: 18,color: Colors.black),
                   ),
                 ),
                  Center(
                    child: FlatButton(
                      onPressed: enableResend ? _resendCode : null,
                      child: Text(
                        'Resend Code',
                        style: CustomTextStyle.styleBold.copyWith(fontSize: 18,color: CustomColors.colorBlue),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Future<String> _forgotPassward(String email) {
    return Future.delayed(const Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<LoginBloc>(context).add(
          ForgotPassEvent(email: email.trim()));
      return "";
    });
  }

  Future<String> _resetPassward(String passward,String otp) {
    //loginBloc = BlocProvider.of<LoginBloc>(context);
    return Future.delayed(const Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<LoginBloc>(context).add(
          ResetPasswordEvent(newPassword: passward.trim(),otp: otp));
      return "";
    });
  }
}
