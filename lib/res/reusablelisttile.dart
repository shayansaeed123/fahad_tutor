

import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

Widget reusablelisttile(BuildContext context,Function ontap,String image,title){
  return Padding(
    padding: const EdgeInsets.only(bottom: 3.0),
    child: ListTile(
      onTap: (){
        ontap();
      },
    contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.01), // Adjust as needed
    tileColor: Colors.grey[200],
    dense: true, // Decrease the height of the ListTile
    minVerticalPadding: 0, // Reduce the vertical padding
    horizontalTitleGap: 8.0, // Increase the gap between the leading and title
    // verticalTitleGap: 0, // Reduce the gap between the title and subtitle/trailing
    leading: Image.asset(image,fit: BoxFit.contain,height: MediaQuery.of(context).size.height * .025,),
    title: reusableText(title,fontsize: 14.5),
    // subtitle: Text('Subtitle'),
    trailing: Icon(CupertinoIcons.arrow_right),
    ),
  );

  // ListTile(
  
  //   // contentPadding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * .01),
  //   tileColor: colorController.grayTextColor,
  //   leading: Image.asset('assets/images/basic_info_icon.png',fit: BoxFit.contain,height: MediaQuery.of(context).size.height * .035,),
  //   title: Text('hello'),
  //   trailing: Text('data'),
  // );
}