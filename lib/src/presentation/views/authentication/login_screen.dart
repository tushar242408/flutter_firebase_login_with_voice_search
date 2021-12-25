import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:task2/src/core/constants/app_text_style.dart';
import 'package:task2/src/core/constants/color_constants.dart';
import 'package:task2/src/core/constants/constant_imports.dart';
import 'package:task2/src/core/helper/helper_imports.dart';
import 'package:task2/src/data/repositories/data_repository.dart';
import 'package:task2/src/presentation/state_management/login_provider.dart';
import 'package:task2/src/presentation/views/authentication/sign_up_screen.dart';
import 'package:task2/src/presentation/views/homepage.dart';
import 'package:task2/src/presentation/widgets/custom_app_bar.dart';
import 'package:task2/src/presentation/widgets/custom_button.dart';
import 'package:task2/src/presentation/widgets/custom_text_field.dart';
import 'package:task2/src/presentation/widgets/custom_text_widgets.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(
        title: 'PingoLearn-Round 2',
      ),
      body:  Consumer<LoginProvider>(
          builder: (context,_data,child){
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0,right: 30),
              child:   Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:  [
                  SizeHelper.h6(),
                  CustomTextField(title: 'Email',controller:_data.email,),
                  SizeHelper.h2(),
                  CustomTextField(title: 'Password',isObscureText: true,controller:_data.password),

                  SizeHelper.h2(),
                  _data.load?CircularProgressIndicator():CustomTextButton(onTap: () {
                    _data.load=true;
                    print('----------------------------------------');
                    print(_data.password);
                    print(_data.load);
                    if( _data.email.text=='' || _data.password.text=='' ){
                      const snackBar = SnackBar(
                        content: Text('Please Fill All The Details'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      _data.load=false;
                      return;
                    }
                    AuthUser().signInEmail(_data.email.text,_data.password.text).then((value){
                      _data.load=false;
                      if(value!=null){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage()));

                      }
                      else{
                        const snackBar = SnackBar(
                          content: Text('Wrong User Credentials'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                      print(_data.load);
                    });
                    }, title: 'Sign up', ),



                  SizeHelper.h2(),


                  InkWell(
                    onTap: ()=>showAlertDialog(context),
                    child: CustomTextWidgets(textString: 'Forget Password',
                      style:  AppTextStyles.boldText(
                        color: ColorConstants.blue,
                        fontSize: Dimensions.px20,
                      ),),
                  ),
                  Container(height: 2,
                    margin: EdgeInsets.all(20),
                    width:double.infinity,
                    color: ColorConstants.shuttleGray,),

                  CustomTextWidgets(textString: 'Don\'t have an account?',
                    style:  AppTextStyles.semiBoldText(
                      color: ColorConstants.black,
                      fontSize: Dimensions.px20,
                    ),),

                  SizeHelper.h2(),
                  InkWell(
                    onTap: ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const SignUp())),
                    child: CustomTextWidgets(textString: 'Register',
                      style:  AppTextStyles.boldText(
                        color: ColorConstants.blue,
                        fontSize: Dimensions.px20,
                      ),),
                  ),
                  SizeHelper.h4(),


                ],

              ),
            ),
          );
        }
      ),
    );
  }
  showAlertDialog(BuildContext context ) {
var controller;
    // set up the button
    Widget okButton = TextButton(
      child: Text("Submit"),
      onPressed: () {
        AuthUser().resetPassword( context.read<LoginProvider>().email.text).then((value) {
          if(value){
            const snackBar = SnackBar(
              content: Text('Please Check Email For Reset Password'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          else{
            const snackBar = SnackBar(
              content: Text('User Not Exist'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }



        });
        context.read<LoginProvider>().email.clear();
        Navigator.pop(context);

      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(

      content:  Container(
          height: 100,
          child: CustomTextField(title: 'Email',controller: context.read<LoginProvider>().email,)),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
