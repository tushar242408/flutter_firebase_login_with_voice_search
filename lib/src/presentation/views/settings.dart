import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task2/src/core/constants/color_constants.dart';
import 'package:task2/src/core/constants/constant_imports.dart';
import 'package:task2/src/core/helper/helper_imports.dart';
import 'package:task2/src/data/repositories/data_repository.dart';
import 'package:task2/src/presentation/state_management/login_provider.dart';
import 'package:task2/src/presentation/state_management/user_profile_provider.dart';
import 'package:task2/src/presentation/widgets/custom_text_field.dart';
import 'package:task2/src/presentation/widgets/custom_text_widgets.dart';

import 'authentication/login_screen.dart';
import 'homepage.dart';


class SettingsScreen extends StatelessWidget {
   SettingsScreen({Key? key}) : super(key: key);
  late String name='';
getName(String id)async{
   name=(await UserCollection().getName(id))!;
}
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
        builder: (context,_data,child){
          getName(_data.user!.uid);

        return Container(
          child: Column(
            children: [
              SizeHelper.h2(),
              CustomTextWidgets(textString: '${name}',
                style:  AppTextStyles.boldText(
                  color: ColorConstants.black,
                  fontSize: Dimensions.px30,
                ),),

              CustomTextWidgets(textString: '${_data.user!.email}',
                style:  AppTextStyles.semiBoldText(
                  color: ColorConstants.grey,
                  fontSize: Dimensions.px25,
                ),),
              SizeHelper.h4(),

          _tile(Icons.lock,'Change password',(){
            showAlertDialog(context);
          },ColorConstants.grey),
          _tile(Icons.delete,'Delete Account',(){
            showAlertDialog1(context);


          },ColorConstants.red),
          _tile(Icons.login,'Logout',(){
            AuthUser().signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Login()));


          },ColorConstants.grey),

            ],
          ),

        );
      }
    );
  }
  _tile(icon,title,ontap,color){
    return  InkWell(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.px20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon,color:color,size: Dimensions.px25,),
                SizedBox(width: 10,),
                CustomTextWidgets(textString: title,
                  style:  AppTextStyles.semiBoldText(
                    color: ColorConstants.grey,
                    fontSize: Dimensions.px25,
                  ),),
              ],
            ),


            Icon(Icons.arrow_forward_ios,color:color,size: Dimensions.px25,),


          ],
        ),
      ),
    );
  }
   showAlertDialog1(BuildContext context) {

     // set up the button
     Widget okButton = TextButton(
       child: CustomTextWidgets(textString: "yes"),
       onPressed: () {
         AuthUser().deleteAccount();
         Navigator.pop(context);
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Login()));

       },
     );

     // set up the AlertDialog
     AlertDialog alert = AlertDialog(
       title: CustomTextWidgets(textString: "Delete Account"),
       content:  CustomTextWidgets(textString: "Are You Sure Want to Delete Account"),
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
   showAlertDialog(BuildContext context ) {

     // set up the button
     Widget okButton = TextButton(
       child:  CustomTextWidgets(textString: "Submit"),
       onPressed: () {
         AuthUser().resetPassword( context.read<LoginProvider>().email.text).then((value) {
           if(value){
             const snackBar = SnackBar(
               content:  CustomTextWidgets(textString: 'Please Check Email For Reset Password'),
             );
             ScaffoldMessenger.of(context).showSnackBar(snackBar);
           }
           else{
             const snackBar = SnackBar(
               content:  CustomTextWidgets(textString: 'User Not Exist'),
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
