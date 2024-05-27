


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Widget reusableyoutubeIcon(BuildContext context){
  return InkWell(
    onTap: (){
      launch('https://youtube.com/@fahadtutorsfta?si=ntx5BBwfHIJHlTZ_');
    },
    child: Container(
                    height: MediaQuery.of(context).size.height * .03,
                      width: MediaQuery.of(context).size.width * .25,
                    child: Image.asset(
                      'assets/images/yout.png',
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.fitWidth,
                      ),
                  ),
  );
}