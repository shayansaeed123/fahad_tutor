

import 'package:fahad_tutor/res/reusableText.dart';
import 'package:flutter/cupertino.dart';

Widget reusablecardbtn(BuildContext context,String text,Color color,textcolor,){
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(11),
      color: color,
    ),
    child: Center(child: reusableText(text,color: textcolor,),),
  );
}