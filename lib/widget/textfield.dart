import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/colors.dart';
import '../utils/device_file.dart';
import '../utils/style.dart';


class CustomTextField extends StatelessWidget {
  TextInputType textInputType;
  TextEditingController? textEditingController;
  bool isObscureText = false;
  String? label = "";
  String? hint = "";
  String? initialValue = "abc";
  String? errorMessage = "";
  IconButton? icon;
  Key? key;
  int minLines;
  int? lengthLimit = 5000;
  bool? isEmail = false;
  bool? isMobile = false;

  CustomTextField(
      {this.key,
      this.label,
      this.hint,
      this.textInputType = TextInputType.text,
      this.textEditingController,
      this.icon,
        this.lengthLimit,
      this.minLines = 1,
        this.initialValue,
      this.isObscureText = false,
      this.errorMessage,this.isEmail = false,this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label!,
            style: CustomTextStyle.styleBold.copyWith(
                fontSize: DeviceUtil.isTablet ? 16 : 14
            ),
          ),
          TextFormField(
            //initialValue: textEditingController?.text,
            controller: textEditingController,
            keyboardType: textInputType,
            minLines: minLines,
            maxLines: minLines,
            obscureText: isObscureText,
            validator: (value) {
              if (value!.isEmpty) {
                return errorMessage;
              }else if(isEmail!){
                bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(value);
                if(!emailValid){
                  return "Please enter valid email.";
                }
              }else if(isMobile!){
                bool mobileValid = RegExp(r'^(?:[+0]9)?[0-9]{10}$').hasMatch(value);
                if(!mobileValid){
                  return "Please enter valid mobile number.";
                }
              }
              return null;
            },
            style: CustomTextStyle.styleMedium.copyWith(
                fontSize: DeviceUtil.isTablet ? 16 : 14
            ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(lengthLimit),
              ],
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 16),
              border: border(),
              focusedBorder: border(color: CustomColors.colorBlue),
              hintText: hint,
              hintStyle: CustomTextStyle.styleMedium
                  .copyWith(fontSize: 12, color: Colors.grey),
              errorStyle:CustomTextStyle.styleMedium
                  .copyWith(fontSize: 12, color: Colors.red),
              suffixIcon: icon,
             // errorText: errorMessage,
              enabledBorder: border(),
              alignLabelWithHint: true,
            ),
          )
        ],
      ),
    );
  }

  border({color: Colors.grey}) {
    return UnderlineInputBorder(borderSide: BorderSide(color: color, width: 1));
  }
}
