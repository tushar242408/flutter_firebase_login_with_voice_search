import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task2/src/core/constants/app_text_style.dart';
import 'package:task2/src/core/constants/color_constants.dart';
import 'package:task2/src/core/constants/constant_imports.dart';
import 'package:task2/src/core/helper/helper_imports.dart';
import 'package:task2/src/data/repositories/data_repository.dart';
import 'package:task2/src/presentation/state_management/signup_provider.dart';
import 'package:task2/src/presentation/widgets/custom_app_bar.dart';
import 'package:task2/src/presentation/widgets/custom_button.dart';
import 'package:task2/src/presentation/widgets/custom_text_field.dart';
import 'package:task2/src/presentation/widgets/custom_text_widgets.dart';

import '../homepage.dart';
import 'login_screen.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(
        title: 'PingoLearn-Round 2',
      ),
body: Consumer<SignupProvider>(
    builder: (context,_data,child){
    return     SingleChildScrollView(
      child:   Padding(
        padding: const EdgeInsets.only(left: 30.0,right: 30),
        child:   Column(

          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:  [
            SizeHelper.h4(),
            CustomTextField(title: 'Name',controller: _data.name,),
            SizeHelper.h2(),
             CustomTextField(title: 'Email',controller: _data.email,),
            SizeHelper.h2(),
            CustomTextField(title: 'Password',isObscureText: true,controller: _data.password,),
            SizeHelper.h2(),
            CustomTextField(title: 'Confirm Password',isObscureText:true,controller: _data.confirmPassword,),
            SizeHelper.h2(),



            _data.load?CircularProgressIndicator(): CustomTextButton(onTap: () {
              _data.load=true;

              print(_data.confirmPassword.text=='');
              if(_data.name.text=='' || _data.email.text=='' || _data.password.text=='' || _data.confirmPassword.text==''){
                const snackBar = SnackBar(
                  content: Text('Please Fill All The Details'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                _data.load=false;
                return;
              }
              if(_data.password.text!=_data.confirmPassword.text){
                const snackBar = SnackBar(
                  content: Text('Passwords are not match'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                _data.load=false;
                return;
              }


              AuthUser().signUp(_data.email.text,_data.password.text,_data.name.text).then((value){


                if(value!=null){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage()));

                }
                else{
                  const snackBar = SnackBar(
                    content: Text('Wrong User Credentials'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                _data.load=false;
              });


            }, title: 'Sign up',),
            Container(height: 2,
            margin: EdgeInsets.all(20),
            width:double.infinity,
            color: ColorConstants.shuttleGray,),

              CustomTextWidgets(textString: 'Already have an account?',
                style:  AppTextStyles.semiBoldText(
                  color: ColorConstants.black,
                  fontSize: Dimensions.px20,
                ),),
            SizeHelper.h2(),

            InkWell(
              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const Login())),
              child: CustomTextWidgets(textString: 'Log in',
              style:  AppTextStyles.boldText(
              color: ColorConstants.blue,
              fontSize: Dimensions.px20,
              ),),
            ),
            SizeHelper.h2(),


          ],

        ),
      ),
    );
  }
),
    );
  }
}
