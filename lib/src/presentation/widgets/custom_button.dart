import 'package:flutter/material.dart';
import 'package:task2/src/core/constants/app_text_style.dart';
import 'package:task2/src/core/constants/constant_imports.dart';

import 'custom_text_widgets.dart';

class CustomTextButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const CustomTextButton({Key? key, required this.title, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        width: double.infinity,

        decoration: BoxDecoration(
        color: Colors.blue,
          borderRadius: BorderRadius.circular(Dimensions.px8),
        ),
        child:    Center(
          child: CustomTextWidgets(textString: title,
            style:  AppTextStyles.regularText(
            color: ColorConstants.black,
            fontSize: Dimensions.px20,
      ),),
        ),
      ),
    );
  }
}
