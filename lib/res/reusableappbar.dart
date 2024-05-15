


import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusableappimage.dart';
import 'package:fahad_tutor/views/profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

reusableappbar(BuildContext context,Color color){
  return AppBar(
        elevation: 0.0,
        foregroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            reusableappimage(context, .10, .04, 'assets/images/coin_icon.png'),
            // Image.asset(
            // width: MediaQuery.of(context).size.width * .10,
            // height: MediaQuery.of(context).size.height * .04,
            // filterQuality: FilterQuality.high,
            // fit: BoxFit.contain,
            // 'assets/images/coin_icon.png',),
            // Lottie.asset('assets/images/error_lottie.json'),
            AnimatedContainer(
              duration: Duration(seconds: 1),
              width: MediaQuery.of(context).size.width * .4,
            height: MediaQuery.of(context).size.height * .035,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Center(child: reusableText('Earn Referral Commision',fontweight: FontWeight.bold)),
            ),
          ],
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(),));
          },
          child: Container(
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * .03,),
            child: reusableappimage(context, .0, .0, 'assets/images/profile.png'),
            
            // Image.asset(
            //     filterQuality: FilterQuality.high,
            //     fit: BoxFit.contain,
            //     'assets/images/profile.png',),
          ),
        ),
        // Icon(CupertinoIcons.circle_filled,color: colorController.blackColor,size: 40,),
        actions: [
          reusableappimage(context, .115, .1, 'assets/images/not_icon.png'),
          // Icon(CupertinoIcons.bell_circle_fill,color: colorController.yellowColor,size: 40,),
          // Image.asset(
          //   width: MediaQuery.of(context).size.width * .115,
          //   height: MediaQuery.of(context).size.height * .1,
          //   filterQuality: FilterQuality.high,
          //   fit: BoxFit.contain,
          //   'assets/images/not_icon.png',),
          SizedBox(width: MediaQuery.of(context).size.width * 0.02,)
        ],
      );
}