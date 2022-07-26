import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/features/login/data/model/get_user_role_model.dart';
import 'package:task_management/features/login/data/model/sign_up_model.dart';

import '../../../../core/base/base_bloc.dart';
import '../../../../custom/progress_bar.dart';
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
              print(model!.message??"");
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString('id', model.data!.id!.toString());
              prefs.setString('role', model.data!.role ?? "");
              Navigator.push(
                context,MaterialPageRoute(builder: (context) =>BlocProvider<LoginBloc>(
                create: (context) => Sl.Sl<LoginBloc>(),
                child: Login(),
              )),);
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
                  key: Key("firstName"),
                  label: "first name",
                  hint: "Enter first name",
                  errorMessage: "Please Enter first name",
                  textEditingController: firstName,
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
                  textEditingController: lastName,
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
                  textEditingController: email,
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
                  textEditingController: mobile,
                  textInputType: TextInputType.phone,
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomTextField(
                  key: Key("password"),
                  label: "password",
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
                     hint: const Text('Please choose a Role'), // Not necessary for Option 1
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
