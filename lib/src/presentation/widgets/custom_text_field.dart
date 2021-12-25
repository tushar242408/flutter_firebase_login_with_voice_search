import 'package:flutter/material.dart';
import 'package:task2/src/core/constants/color_constants.dart';
import 'package:task2/src/core/constants/constant_imports.dart';
import 'package:task2/src/core/helper/helper_imports.dart';

import 'custom_text_widgets.dart';


class CustomTextField extends StatelessWidget {
  final String title;
  final TextStyle? style;
  final bool isObscureText;
  final TextInputType? textInputType;
  final int? maxLength;
  TextEditingController? controller;
     CustomTextField({Key? key,

this.controller,

      required this.title,
    this.style,
    this.isObscureText = false,
    this.textInputType,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidgets(textString: title,
          style:  AppTextStyles.boldText(
            color: ColorConstants.black,
            fontSize: Dimensions.px20,
            height: 0.5,
          ),


        ),
        SizeHelper.h1(),
        Container(
          padding: EdgeInsets.all(5),
          height: 40,
          // width: isLargeTf ? double.infinity : Dimensions.px189,
          decoration: BoxDecoration(
            border: Border.all(
                color: ColorConstants.shuttleGray, width: 0.8, style: BorderStyle.solid),

            borderRadius: BorderRadius.circular(Dimensions.px5),
          ),
          child: TextField(
            controller: controller,
            obscureText: isObscureText,
            maxLength: maxLength,
            style: AppTextStyles.regularText(fontSize: Dimensions.px20),
            textAlign: TextAlign.start,
            keyboardType: textInputType,
            decoration: const InputDecoration(
              counterText: '',
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
