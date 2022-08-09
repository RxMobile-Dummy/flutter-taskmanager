import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/style.dart';

class CustomAppBar extends StatelessWidget {
  String title;
  String description;
  bool isFirstPage;
  bool showBackButton;
  bool backButton;
  Widget actions;

  CustomAppBar(
      {this.title = "",
      this.description = "",
      this.isFirstPage = false,
      required this.actions,
      this.backButton = false,
      this.showBackButton = false,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 40, bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          showBackButton
              ? IconButton(
              icon: backButton
                  ? Icon(Icons.keyboard_backspace)
                  : Icon(Icons.close),
              onPressed: () {
                if (!isFirstPage) {
                  Get.back();
                }
              },
              color: Colors.white)
              : SizedBox(),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 16),
              child: Text(
                title,
                style: CustomTextStyle.styleBold
                    .copyWith(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
          if (actions != null) actions
        ],
      ),
    );
  }
}
