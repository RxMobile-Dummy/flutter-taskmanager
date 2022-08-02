import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:task_management/features/login/data/model/reset_passward_model.dart';
import 'package:task_management/features/login/presentation/bloc/login_state.dart';
import 'package:task_management/ui/reset_success.dart';

import '../core/base/base_bloc.dart';
import '../custom/progress_bar.dart';
import '../features/login/presentation/bloc/login_bloc.dart';
import '../features/login/presentation/bloc/login_event.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<LoginBloc, BaseState>(
          listener: (context, state) {
            if (state is StateOnSuccess) {
              ProgressDialog.hideLoadingDialog(context);
            } if (state is ResetPasswordStatus) {
              ProgressDialog.hideLoadingDialog(context);
              ResetPasswardModel? model = state.model;
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(model!.message??""),
              ));
              Get.to(ResetSuccess());
            }else if (state is StateErrorGeneral) {
              ProgressDialog.hideLoadingDialog(context);
            }
          },
          bloc: BlocProvider.of<LoginBloc>(context),
          child:  BlocBuilder<LoginBloc, BaseState>(builder: (context, state) {
            return buildWidget();
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
                    textEditingController: resetCode,
                    textInputType: TextInputType.number,
                  ),
                  const SizedBox(height: 32,),
                  CustomTextField(
                    key: const Key("tefPassword"),
                    label: "New password",
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
                      if(resetCode.text.isNotEmpty){
                        if(tieNewPassword.text == tieConfirmPassword.text){
                          _resetPassward(tieNewPassword.text,widget.email);
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('Password does not same'),
                          ),);
                        }
                      }else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please enter reset code.'),
                        ),);
                      }
                      //Get.to(ResetSuccess());
                    },
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
  Future<String> _resetPassward(String passward,String email) {
    //loginBloc = BlocProvider.of<LoginBloc>(context);
    return Future.delayed(const Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<LoginBloc>(context).add(
          ResetPasswordEvent(newPassword: passward.trim(),email: email));
      return "";
    });
  }
}
