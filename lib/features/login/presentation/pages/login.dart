
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_management/features/login/presentation/pages/sign_up.dart';

import '../../../../core/base/base_bloc.dart';
import '../../../../core/error_bloc_listener/error_bloc_listener.dart';
import '../../../../custom/progress_bar.dart';
import '../../../../ui/forgot_password.dart';
import '../../../../ui/home/home.dart';
import '../../../../utils/colors.dart';
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
      body: ErrorBlocListener<LoginBloc>(
        bloc: BlocProvider.of<LoginBloc>(context),
       // callback:  _loginUser(userName.text,tiePassword.text),
        child:  BlocBuilder<LoginBloc, BaseState>(builder: (context, state)  {
          if(state is LoginState) {
            ProgressDialog.hideLoadingDialog(context);
            Future.delayed(Duration.zero, () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Home()),
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
      title: "Login",
      isFirstPage: false,
      showBackButton: false,
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
                  key: const Key("tefUsername"),
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
                  key: const Key("tefPassword"),
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
                    Future.delayed(Duration.zero, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>BlocProvider<LoginBloc>(
                          create: (context) => Sl.Sl<LoginBloc>(),
                          child: ForgotPassword(),
                        )),
                      );
                    });
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
                      Fluttertoast.cancel();
                      Fluttertoast.showToast(
                          msg: "Please fill all the details.",
                          toastLength: Toast.LENGTH_LONG,
                          fontSize: DeviceUtil.isTablet ? 20 : 12,
                          backgroundColor: CustomColors.colorBlue,
                          textColor: Colors.white
                      );
                    }
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
                        Future.delayed(Duration.zero, () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>BlocProvider<LoginBloc>(
                              create: (context) => Sl.Sl<LoginBloc>(),
                              child: SignUp(),
                            )),
                          );
                        });
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
    return Future.delayed(Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<LoginBloc>(context).add(
          LoginEvent(email: email.trim(), password: password.trim()));
      return "";
    });
  }
}
