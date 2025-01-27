import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/database/my_shared.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusableappimage.dart';
import 'package:fahad_tutor/views/dashboard/notification.dart';
import 'package:fahad_tutor/views/profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

reusableappbar(BuildContext context, Color color, Function ontap,
    ValueListenable<Object?> profileimg, Function notificationtap) {
  return AppBar(
    elevation: 0.0,
    foregroundColor: colorController.whiteColor,
    backgroundColor: colorController.whiteColor,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        reusableappimage(context, .10, .035, 'assets/images/coin_icon.png'),
        AnimatedContainer(
          duration: Duration(seconds: 1),
          width: MediaQuery.of(context).size.width * .4,
          height: MediaQuery.of(context).size.height * .028,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Center(
              child: InkWell(
                onTap: (){
        launch('https://fahadtutors.com/Referral.php');
      },
                child: reusableText('Earn Referral Commision',
                    fontweight: FontWeight.bold),
              )),
        ),
      ],
    ),
    centerTitle: true,
    leading: Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.0153),
      child: InkWell(
        onTap: () {
          ontap();
        },
        child: Container(
            child: ValueListenableBuilder(
          valueListenable: profileimg,
          builder: (context, value, child) {
            return value != 'https://www.fahadtutors.com/fta_admin/'
                ? CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.07,
                    backgroundColor: colorController.blackColor,
                    backgroundImage: NetworkImage(
                      value.toString(),
                    ),
                  )
                : reusableappimage(
                    context, .0, .0, 'assets/images/profile.png');
          },
        )),
      ),
    ),
    actions: [
      Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.0153),
        child: InkWell(
            onTap: () {
              notificationtap();
            },
            child: reusableappimage(
                context, .115, .075, 'assets/images/not_icon.png')),
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.015,
      )
    ],
  );
}
