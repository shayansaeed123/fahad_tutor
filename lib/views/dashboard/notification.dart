import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: colorController.whiteColor,
    appBar: AppBar(elevation: 0,backgroundColor: Colors.transparent,
    leading:  Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
      child: InkWell(
        onTap: (){Navigator.pop(context);},
        child: Image.asset('assets/images/gradient_back.png',fit: BoxFit.contain,height: MediaQuery.of(context).size.height * 0.02,)),
    ),),
    body: Padding(
      padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .032),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          reusableText('Notifications',color: colorController.blackColor,fontsize: 23,fontweight: FontWeight.bold),
          reusablaSizaBox(context, 0.030),
          Expanded(
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .025),
                decoration: BoxDecoration(
                  color: colorController.whiteColor,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: colorController.grayTextColor,blurRadius: 4.0,offset: Offset(0, 2),
                      ),],),
                child: ListTile(
                  leading: Image.asset('assets/images/not_img.png',fit: BoxFit.contain,),
                  title: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                    reusableText('Preferred Tuition',color: colorController.blackColor,fontsize: 15),
                    reusablaSizaBox(context, 0.003),
                    reusableText('You have a new tuition:',color: colorController.blackColor,fontsize: 13),
                    reusablaSizaBox(context, 0.007),
                  ],),
                  subtitle: reusableText('2w',color: colorController.blackColor,fontsize: 11),
                  trailing: Image.asset('assets/images/view.png',fit: BoxFit.contain,height: MediaQuery.of(context).size.height * 0.04,)
                ),
              );
            },),
          )
        ],
      ),
    )
  );
  }
}