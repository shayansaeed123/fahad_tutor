

import 'package:flutter/cupertino.dart';

Widget reusableappimage(BuildContext context, double width,double height,String url){
  return Image.asset(
            width: MediaQuery.of(context).size.width * width,
            height: MediaQuery.of(context).size.height * height,
            filterQuality: FilterQuality.high,
            fit: BoxFit.contain,
            url,);
}