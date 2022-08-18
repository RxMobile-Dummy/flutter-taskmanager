import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_management/ui/reset_password.dart';

import '../core/base/base_bloc.dart';
import '../core/error_bloc_listener/error_bloc_listener.dart';
import '../custom/progress_bar.dart';
import '../features/login/presentation/bloc/login_bloc.dart';
import '../features/login/presentation/bloc/login_event.dart';
import '../features/login/presentation/bloc/login_state.dart';
import '../utils/colors.dart';
import '../utils/device_file.dart';
import '../widget/button.dart';
import '../widget/rounded_corner_page.dart';
import '../widget/textfield.dart';

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
      body: ErrorBlocListener<LoginBloc>(
          bloc: BlocProvider.of<LoginBloc>(context),
          child:  BlocBuilder<LoginBloc, BaseState>(
              builder: (context, state) {
                if(state is ForgotPasswordStatus){
                  ProgressDialog.hideLoadingDialog(context);
                  Future.delayed(Duration.zero, () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => ResetPassword(email: emailController.text),),
                            (route) => false);
                  });
                }
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
        showBackButton: true,
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
                      Fluttertoast.cancel();
                      Fluttertoast.showToast(
                          msg: "Please fill all the details.",
                          toastLength: Toast.LENGTH_LONG,
                          fontSize: DeviceUtil.isTablet ? 20 : 12,
                          backgroundColor: CustomColors.colorBlue,
                          textColor: Colors.white
                      );
                    }
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
