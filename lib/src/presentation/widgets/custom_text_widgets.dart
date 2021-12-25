import 'package:flutter/material.dart';
import 'package:task2/src/core/constants/app_text_style.dart';
import 'package:task2/src/core/constants/constant_imports.dart';



class CustomTextWidgets extends StatelessWidget {
  final String textString;
  final TextStyle? style;

  const CustomTextWidgets({
    required this.textString,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textString,
      style: style ?? AppTextStyles.regularText(fontSize: Dimensions.px18),
    );
  }
}
