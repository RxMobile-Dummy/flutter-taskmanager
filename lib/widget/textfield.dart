import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
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

  CustomTextField(
      {this.key,
      this.label,
      this.hint,
      this.textInputType = TextInputType.text,
      this.textEditingController,
      this.icon,
      this.minLines = 1,
        this.initialValue,
      this.isObscureText = false,
      this.errorMessage,});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label!,
            style: CustomTextStyle.styleBold,
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
              }
            },
            style: CustomTextStyle.styleMedium,
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
              errorText: errorMessage,
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
