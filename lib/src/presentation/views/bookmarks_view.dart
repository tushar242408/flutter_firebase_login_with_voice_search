import 'dart:convert';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:task2/src/core/constants/app_text_style.dart';
import 'package:task2/src/core/constants/color_constants.dart';
import 'package:task2/src/core/constants/constant_imports.dart';
import 'package:task2/src/core/helper/helper_imports.dart';
import 'package:task2/src/data/network/search_data.dart';
import 'package:task2/src/data/repositories/data_repository.dart';
import 'package:task2/src/presentation/state_management/theme_provider.dart';
import 'package:task2/src/presentation/state_management/user_profile_provider.dart';
import 'package:task2/src/presentation/views/settings.dart';
import 'package:task2/src/presentation/widgets/custom_app_bar.dart';
import 'package:task2/src/presentation/widgets/custom_text_widgets.dart';

import 'history_screen.dart';
class BookmarkView extends StatelessWidget {
   BookmarkView({Key? key,this.data,this.id}) : super(key: key);
var data,id;

  @override
  Widget build(BuildContext context) {

    return   Consumer<UserProvider>(
        builder: (context,_data,child){
          final themeChanger = Provider.of<ThemeChanger>(context);
          return Scaffold(
            appBar: CustomAppBar(
              isShowLeading: true,
              leadingicon: IconButton(icon: const Icon(Icons.arrow_back),onPressed: (){
              Navigator.pop(context);

              },),

              title: 'PingoLearn-Round 2',

            ),

              body: Center(

                  child: Column(
                    children: [
                      SizedBox(height: 20,),
               Text(
                        'Your word:\n ${data['word']}',
                        style: TextStyle(
                          fontSize:23,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      Column(
                        children: [
                          _textBlock('Meaning','${data['meaning']}'),
                          _textBlock('Example','${data['example']}'),




                          '${data['imageUrl']}'!='null'?   Container(
                              child: Image.network('${data['imageUrl']}',height: 150,
                                width: 150,fit: BoxFit.fill,)):Container(
                            child: Image.asset('assets/images/image_not_found.png',height: 150,
                              width: 150,fit: BoxFit.fill,),),
                        ],
                      )


                    ],
                  )

              ),

            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: AvatarGlow(
              animate: false ,

              glowColor: ColorConstants.red,
              endRadius: 75.0,
              duration: const Duration(milliseconds: 2000),
              repeatPauseDuration: const Duration(milliseconds: 100),
              repeat: true,
              child: FloatingActionButton(
                backgroundColor: ColorConstants.red,
                onPressed:()async{
                  await UserCollection().deleteBookmark(id,data);
                  Navigator.pop(context);
                },
                child: Icon( Icons.delete ,color: ColorConstants.white,),
              ),
            ),

          );}

        );
  }
  Widget _textBlock(String title,String data){
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.black12.withOpacity(0.04),
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(
            fontSize:20,
            fontWeight: FontWeight.w700,
          ),
            textAlign: TextAlign.center,),
          Text(data, style: const TextStyle
            (
            fontSize:17,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w300,
          ),
            textAlign: TextAlign.center,),

        ],
      ),
    );
  }


}
