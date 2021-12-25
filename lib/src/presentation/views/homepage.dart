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

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

bool _load =false,_switchValue=false;
int _page=10;
  var _speechData;
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
List<Widget> _drawerpage=[
  HistoryScreen(),
  SettingsScreen()
];
  @override
  void initState() {

    super.initState();
    _initSpeech();
  }


  void _initSpeech() async {
    UserCollection().getName('kHVKrETu7XZozbb1j9UkFzxxA173');
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }


  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});

  }

  void _onSpeechResult(SpeechRecognitionResult result)async {
    setState(() {
      _load=false;
    });
      _lastWords = result.recognizedWords;


   _speechData=await ApiHandler().getData(_lastWords);
   await Future.delayed(Duration(
     seconds: 1,
   ));
setState(() {
  _load=true;
});
  }
GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {

    return   Consumer<UserProvider>(
        builder: (context,_data,child){
          final themeChanger = Provider.of<ThemeChanger>(context);
        return Scaffold(

          appBar: CustomAppBar(
            isShowLeading: true,
            leadingicon:  _lastWords==""? IconButton(
                icon: Icon(Icons.dehaze),
                onPressed: () {
                  if (_scaffoldKey.currentState!.isDrawerOpen == false) {
                    _scaffoldKey.currentState!.openDrawer();
                  } else {
                    _scaffoldKey.currentState!.openEndDrawer();
                  }
                }):IconButton(icon: const Icon(Icons.arrow_back),onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
              
            },),

            title: 'PingoLearn-Round 2',
            actions: [ _page==10 ?IconButton(icon: Icon(Icons.bookmark_border),onPressed: (){
print(_speechData.definitions![0]);
              UserCollection().storeBookmark(_data.user!.uid,
                  {
                    'meaning':'${_speechData.definitions![0].definition??''}'
                    ,'imageUrl':'${_speechData.definitions![0].imageUrl??''}'
                    ,'example':'${_speechData.definitions![0].example??''}'
                    ,'word':'${_lastWords}'


                  });

            },):Container(),],
          ),
          body: Scaffold(
            key: _scaffoldKey,
            drawer:  Drawer(
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.px20),
            child: Column(
            children: [
              _page!=10 ?   drawerTile(Icons.home,'Home',(){
                setState(() {
                  _page=10;
                });

              }):Container(),
              SizeHelper.h2(),
              drawerTile(Icons.history,'History',(){
                setState(() {
                  _page=0;
                });

              }),
              SizeHelper.h2(),
              drawerTile(Icons.settings,'Settings',(){
                setState(() {
                  _page=1;
                });
              }),
              SizeHelper.h2(),
              Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [

                  drawerTile(Icons.nights_stay_outlined,'Dark Mode',(){}),
              Switch(
                onChanged: (val){
                  _switchValue=!_switchValue;
                  if(!_switchValue)
                  themeChanger.setTheme(ThemeMode.light);
                  else{
                    themeChanger.setTheme(ThemeMode.dark);
                  }
setState(() {

});
                },
                value: _switchValue,
                // activeColor: ColorConstants.white,
                // activeTrackColor: Colors.yellow,
                // inactiveThumbColor: Colors.redAccent,
                // inactiveTrackColor: Colors.orange,
              )

              ],
              )


        ],
        ),
          ),
        ),
            body: _page==0 ||_page ==1?_drawerpage[_page]:Center(

              child: Column(
                children: [
                  SizedBox(height: 20,),
                  _lastWords==''?Text(
                    // If listening is active show the recognized words
                    _speechToText.isListening
                        ? 'Your word:\n$_lastWords'
                        : _speechEnabled
                        ? 'Press the button to start speaking'
                        : 'Speech not available',
                    style: const TextStyle(
                      fontSize:28,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ):Text(
                    'Your word:\n$_lastWords',
                    style: TextStyle(
                      fontSize:23,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  _load?_speechData!=null?
                  Column(
                    children: [
                      _textBlock('Meaning','${_speechData.definitions![0].definition??''}'),
                      _textBlock('Example','${_speechData.definitions![0].example??''}'),




                      '${_speechData.definitions![0].imageUrl}'!='null'?   Container(
                          child: Image.network('${_speechData.definitions![0].imageUrl}',height: 150,
                            width: 150,fit: BoxFit.fill,)):Container(
                        child: Image.asset('assets/images/image_not_found.png',height: 150,
                          width: 150,fit: BoxFit.fill,),),
                          ],
                        ):

                  Container(
                    child: Image.asset('assets/images/image_not_found.png',height: 150,
                      width: 150,fit: BoxFit.fill,),
                  ):Container(),

                    ],
                  )

            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: _page==10 ? AvatarGlow(
              animate: _speechToText.isListening ,
              glowColor: Theme.of(context).primaryColor,
              endRadius: 75.0,
              duration: const Duration(milliseconds: 2000),
              repeatPauseDuration: const Duration(milliseconds: 100),
              repeat: true,
              child: FloatingActionButton(
                onPressed:  _speechToText.isNotListening ? _startListening : _stopListening,
                child: Icon(_speechToText.isNotListening  ? Icons.mic : Icons.mic_none),
              ),
            ):null,
          ),

        );
      }
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

  Widget drawerTile(IconData icon,String title,ontap){
    return  InkWell(
      onTap: ontap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,

          children: [
            Icon(icon,color: ColorConstants.shuttleGray,size: Dimensions.px30,),
            SizedBox(width: 10,),
            CustomTextWidgets(textString: title,
              style:  AppTextStyles.semiBoldText(
                color: ColorConstants.shuttleGray,
                fontSize: Dimensions.px25,
              ),),
          ]),
    );
  }

}
