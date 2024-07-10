import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Notification extends StatefulWidget {
  const Notification({super.key});

  @override
  State<Notification> createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: colorController.whiteColor,
    appBar: AppBar(elevation: 0,backgroundColor: Colors.transparent,),
    body: Column(
      children: [
        reusableText('Notifications'),
        reusablaSizaBox(context, 0.030),
        
      ],
    )
  );
  }
}