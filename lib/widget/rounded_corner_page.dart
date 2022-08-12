import 'package:flutter/material.dart';

import '../utils/colors.dart';
import 'appbar.dart';

// ignore: must_be_immutable
class RoundedCornerPage extends StatelessWidget {
  String title;
  Widget child;
  bool backButton;
  bool isFirstPage;
  Widget? actions;
  bool showBackButton;

  RoundedCornerPage(
      {required this.title,
      required this.child,
      this.isFirstPage = false,
         this.actions,
      this.backButton = true, this.showBackButton = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColors.colorBlue,
      child: Column(
        children: [
          Container(
            child: CustomAppBar(
              title: title,
              isFirstPage: isFirstPage,
              actions: actions ?? SizedBox(),
              backButton: backButton,
              showBackButton: showBackButton,
            ),
          ),
          child
        ],
      ),
    );
  }
}
