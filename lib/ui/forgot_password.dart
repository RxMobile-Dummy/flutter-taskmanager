import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:task_management/ui/reset_password.dart';

import '../core/base/base_bloc.dart';
import '../custom/progress_bar.dart';
import '../features/login/data/model/forgot_password_model.dart';
import '../features/login/data/model/login_model.dart';
import '../features/login/presentation/bloc/login_bloc.dart';
import '../features/login/presentation/bloc/login_event.dart';
import '../features/login/presentation/bloc/login_state.dart';
import '../features/login/presentation/pages/login.dart';
import '../utils/colors.dart';
import '../utils/device_file.dart';
import '../widget/button.dart';
import '../widget/rounded_corner_page.dart';
import '../widget/textfield.dart';
import 'package:task_management/injection_container.dart' as Sl;

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey =  GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<LoginBloc, BaseState>(
          listener: (context, state) {
            if (state is StateOnSuccess) {
              ProgressDialog.hideLoadingDialog(context);
            }else if (state is ForgotPasswordStatus) {
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
                Navigator.pushAndRemoveUntil<dynamic>(
                  context,
                  MaterialPageRoute(builder: (context) =>BlocProvider<LoginBloc>(
                    create: (context) => Sl.Sl<LoginBloc>(),
                    child: ResetPassword(email: emailController.text),
                  )),
                      (route) => false,
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
        title: "Forgot Password",
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
                    key: const Key("tefUsername"),
                    label: "Username",
                    hint: "Enter username",
                    isEmail: true,
                    errorMessage: "Please enter email.",
                    textEditingController: emailController,
                    textInputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Button("Send Request",onPress: (){
                    FocusScope.of(context).unfocus();
                    if(_formKey.currentState!.validate()){
                      _formKey.currentState?.save();
                      _forgotPassward(emailController.text);
                    }else{
                      Fluttertoast.showToast(
                          msg: "Please fill all the details.",
                          toastLength: Toast.LENGTH_LONG,
                          fontSize: DeviceUtil.isTablet ? 20 : 12,
                          backgroundColor: CustomColors.colorBlue,
                          textColor: Colors.white
                      );
                    }
                   // Get.to(ResetPassword());
                  },),
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
}
