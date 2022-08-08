import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/device_file.dart';
import '../utils/style.dart';

class HomeAppBar {
  final Widget? leading;
  final String? title;
  final List<Widget>? actions;
  var bottomMenu;

  HomeAppBar({this.leading, this.title, this.actions,this.bottomMenu});

  AppBar build() {
    return AppBar(
      elevation: 0,
      backgroundColor: CustomColors.colorBlue,
      leading: leading,

      title: Text(
        title ?? "",
        style: CustomTextStyle.styleBold.copyWith(color: Colors.white,
            fontSize: DeviceUtil.isTablet ? 18 : 15),
      ),
      centerTitle: true,
      actions: actions,
      bottom:bottomMenu
    );
  }
}
