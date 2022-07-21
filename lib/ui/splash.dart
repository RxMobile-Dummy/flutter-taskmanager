import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/features/login/presentation/bloc/login_bloc.dart';

import '../onboarding/onboarding.dart';
import '../utils/style.dart';
import '../widget/size.dart';
import 'home/home.dart';


class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState()  {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var authToken = prefs.getString('access');
      Timer(Duration(seconds: 2), () {
        Get.off(
          BlocProvider<LoginBloc>(
            create: (context) =>
                BlocProvider.of<LoginBloc>(context), child: authToken == null ? OnBoarding() : Home(),),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var imageWidth = MediaQuery.of(context).size.width/4;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/ic_logo.png",width: imageWidth,height: imageWidth,),
            sized_16(),
            Text(
              "Task Manager",
              style: CustomTextStyle.styleBold.copyWith(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
