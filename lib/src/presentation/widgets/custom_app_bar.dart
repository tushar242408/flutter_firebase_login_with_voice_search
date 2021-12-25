import 'package:flutter/material.dart';
import 'package:task2/src/core/constants/app_text_style.dart';
import 'package:task2/src/core/constants/color_constants.dart';
import 'package:task2/src/core/constants/constant_imports.dart';

import 'custom_text_widgets.dart';


class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  // final Color backgroundColor;
  
  final bool isShowLeading;
  final Function()? leadingCallback;
   Widget? leadingicon;
   final String title;


  CustomAppBar({
    this.actions,
    // this.backgroundColor = ColorConstants.white,

    this.isShowLeading = true,

    this.leadingCallback,
    this.leadingicon,
    required this.title,
  });

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  void initState() {
    widget.isShowLeading && widget.leadingicon==null?
    widget.leadingicon=IconButton(icon: const Icon(Icons.arrow_back),onPressed: (){
      Navigator.pop(context);
    },):
        widget.leadingicon=widget.leadingicon;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  PreferredSize(
        preferredSize: Size.fromHeight(80.0), // here the desired height
        child: AppBar(

       leading: widget.leadingicon,
          title: Center(
            child: CustomTextWidgets(textString: widget.title,
              style:  AppTextStyles.boldText(
                color: ColorConstants.black,
                fontSize: Dimensions.px20,
              ),),
          ),
          actions: widget.actions,
        )
    );
  }


}
