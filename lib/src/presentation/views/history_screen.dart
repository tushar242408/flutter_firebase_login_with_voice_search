

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task2/src/core/constants/constant_imports.dart';
import 'package:task2/src/data/repositories/data_repository.dart';
import 'package:task2/src/presentation/state_management/user_profile_provider.dart';
import 'package:task2/src/presentation/widgets/custom_text_widgets.dart';

import 'bookmarks_view.dart';

class HistoryScreen extends StatelessWidget {
   HistoryScreen({Key? key}) : super(key: key);
  List _dataBookmark=[];
getData(id)async{
  _dataBookmark=await UserCollection().getBookmark('$id');

}
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
        builder: (context,_data,child){
          getData(_data.user!.uid);
        return Container(
          padding:EdgeInsets.only(top:Dimensions.px10),
          child: ListView.builder(
              itemCount: _dataBookmark.length,
              itemBuilder: (context,index){
            return InkWell(
              onTap:(){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>BookmarkView(data: _dataBookmark[index],id:'${_data.user!.uid}')));
              },
              child: Container(
                margin: EdgeInsets.all(Dimensions.px10),
                padding: EdgeInsets.all(Dimensions.px15),
                height: 80,
                width: double.infinity,

                decoration: BoxDecoration(
                  color: ColorConstants.lightGrey,
                    boxShadow: [new BoxShadow(
                      color: ColorConstants.grey,
                      offset:Offset.fromDirection(0.2) ,
                      blurRadius: 2.0,
                    ),],
                  borderRadius: BorderRadius.circular(Dimensions.px15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextWidgets(textString: _dataBookmark[index]['word'],
                      style:  AppTextStyles.semiBoldText(
                        color: ColorConstants.black,
                        fontSize: Dimensions.px30,
                      ),),
              IconButton(
              icon: Icon(Icons.delete,color:ColorConstants.red,size: Dimensions.px40,),
              onPressed: ()async{
                await UserCollection().deleteBookmark('${_data.user!.uid}',_dataBookmark[index]);
              },
              )

                  ],
                ),
              ),
            );
          }),

        );
      }
    );
  }
}
