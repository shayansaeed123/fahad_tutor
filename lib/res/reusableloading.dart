




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';


Widget reusableloadingrow(BuildContext context, bool isLoading) {
  return isLoading == true
      ?  
        AlertDialog(
        backgroundColor: Colors.transparent,
            title: Center(
              child: Lottie.asset('assets/images/lottie_anim.json',
              alignment: Alignment.center,
              animate: true,
              filterQuality: FilterQuality.high,
              fit: BoxFit.contain,height: MediaQuery.of(context).size.height *0.05,
              repeat: true,),
            ),
          )
      
      : Container();
}
