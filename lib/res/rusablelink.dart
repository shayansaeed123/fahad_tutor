




import 'package:flutter/cupertino.dart';

Widget reusablelink(BuildContext context,String image){

  return Image.asset(image,fit: BoxFit.contain,height: MediaQuery.of(context).size.height * .025,);
}