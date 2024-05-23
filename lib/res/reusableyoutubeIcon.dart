


import 'package:flutter/cupertino.dart';

Widget reusableyoutubeIcon(BuildContext context){
  return Container(
                  height: MediaQuery.of(context).size.height * .03,
                    width: MediaQuery.of(context).size.width * .25,
                  child: Image.asset(
                    'assets/images/yout.png',
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.fitWidth,
                    ),
                );
}