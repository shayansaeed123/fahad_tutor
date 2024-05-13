




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget reusablelink(BuildContext context,String image,Function ontap){

  return Padding(
    padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.0235),
    child: InkWell(
      onTap: (){
        ontap();
      },
      child: Image.asset(image,fit: BoxFit.contain,height: MediaQuery.of(context).size.height * .030,)),
  );
}