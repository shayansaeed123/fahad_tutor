import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusablebtn.dart';
import 'package:fahad_tutor/res/reusablecardbtn.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// reusabletutorDetails(BuildContext context, 
// String details,
// String class_name,
// String tuition_name,
// String Placement,
// int job,
// String subject,
// String share_date,
// String location,
// String limit,
// Function btnontap,
// String group_id,
// String tuition_id,
// int already,
//     ) {
//   return showDialog(
//     context: context,
//     builder: (context) => AlertDialog(
//         backgroundColor: colorController.whiteColor,
//         title: Center(child: reusableText('${class_name}',color: colorController.blackColor,fontsize: 17,fontweight: FontWeight.bold)),
//         content: Container(
//            width: MediaQuery.of(context).size.width,
//                       height: MediaQuery.of(context).size.height  * .39,
//           child: Stack(
//             children: [
//               Opacity(
//                 opacity: 0.13,
//                 child: Center(child: Positioned(child: Image.asset('assets/images/logo_1.png')))),
//               Positioned(child: SingleChildScrollView(
//                 scrollDirection: Axis.vertical,
//                 child: Column(
//                       // mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(children: [Padding(
//                           padding: const EdgeInsets.all(0.0),
//                           child: reusableText('${tuition_name} ',color: colorController.grayTextColor,fontsize: 15),
//                         ),],),
//                         Expanded(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [reusablecardbtn(context, '${Placement}', colorController.btnColor, colorController.whiteColor,width: 0.030),
//                             SizedBox(width: MediaQuery.of(context).size.width * 0.010,),
//                           reusablecardbtn(context, job == 0 ? 'Open' : 'Closed', job == 0 ? colorController.yellowColor : colorController.redColor, job == 0 ? colorController.blackColor : colorController.whiteColor,width: 0.030),],),
//                         )
//                           ],
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(5.0),
//                           child: reusablecardbtn(context, '${subject}', colorController.btnColor, colorController.whiteColor,),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(5.0),
//                           child: reusableText('${share_date}',color: colorController.blackColor,fontsize: 13.7),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(5.0),
//                           child: reusableText('${location}',color: colorController.blackColor,fontsize: 13.7),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal:  5.0,vertical: 7.0),
//                           child: reusableText('Details',color: colorController.blackColor,fontsize: 14.2),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 5.0),
//                           child: reusableText(details,color: colorController.grayTextColor,fontsize: 13.7),
//                         ),
//                       ],
//                     ),
//               ),
//                 ),
//             ],
//           ),
//         ),
//         actions: [
//           Center(child: reusableText('${limit}',color: colorController.blackColor)),
//           SizedBox(width: MediaQuery.of(context).size.width * .010,),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               job == 0 && already == 0 ? ElevatedButton(
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStateColor.resolveWith((states) =>  colorController.btnColor),
//                 ),
//                 onPressed: () {
//                   btnontap();
                  
//                 },
//                 child: reusableText('Apply',color: colorController.whiteColor),
//               ) : Visibility(
//                 visible: true,
//                 child: Container()),
//              job == 0 && already == 0 ? ElevatedButton(
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStateColor.resolveWith((states) =>  colorController.grayTextColor),
//                 ),
//                 onPressed: () {
//                   // btnontap();
//                   Navigator.pop(context);
//                 },
//                 child: reusableText( 'Close',color: colorController.whiteColor,)
//               ) : Expanded(child: reusableBtn(context, 'Close', (){Navigator.pop(context);})),
//             ]
//           ),
//           reusablaSizaBox(context, .01)
//         ],
//       ),
//   );
  
// }

reusabletutorDetails(
  BuildContext context,
  String details,
  String class_name,
  String tuition_name,
  String Placement,
  int job,
  String subject,
  String share_date,
  String location,
  String limit,
  Function btnontap,
  String group_id,
  String tuition_id,
  int already,
  Function updateCardState,
) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: colorController.whiteColor,
      title: Center(
          child: reusableText(
        '$class_name',
        color: colorController.blackColor,
        fontsize: 17,
        fontweight: FontWeight.bold,
      )),
      content: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .39,
        child: Stack(
          children: [
            Opacity(
                opacity: 0.13,
                child: Center(child: Image.asset('assets/images/logo_1.png'))),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: reusableText(
                          '$tuition_name ',
                          color: colorController.grayTextColor,
                          fontsize: 15,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          reusablecardbtn(
                            context,
                            '$Placement',
                            colorController.btnColor,
                            colorController.whiteColor,
                            width: 0.030,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.010,
                          ),
                          reusablecardbtn(
                            context,
                            job == 0 ? 'Open' : 'Closed',
                            job == 0
                                ? colorController.yellowColor
                                : colorController.redColor,
                            job == 0
                                ? colorController.blackColor
                                : colorController.whiteColor,
                            width: 0.030,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: reusablecardbtn(
                      context,
                      '$subject',
                      colorController.btnColor,
                      colorController.whiteColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: reusableText(
                      '$share_date',
                      color: colorController.blackColor,
                      fontsize: 13.7,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: reusableText(
                      '$location',
                      color: colorController.blackColor,
                      fontsize: 13.7,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 7.0),
                    child: reusableText(
                      'Details',
                      color: colorController.blackColor,
                      fontsize: 14.2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: reusableText(
                      details,
                      color: colorController.grayTextColor,
                      fontsize: 13.7,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        Center(child: reusableText('$limit', color: colorController.blackColor)),
        SizedBox(width: MediaQuery.of(context).size.width * .010),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            job == 0 && already == 0
                ? ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => colorController.btnColor),
                    ),
                    onPressed: () {
                      btnontap();
                    },
                    child:
                        reusableText('Apply', color: colorController.whiteColor),
                  )
                : Visibility(
                    visible: true,
                    child: Container(),
                  ),
            job == 0 && already == 0
                ? ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => colorController.grayTextColor),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: reusableText(
                      'Close',
                      color: colorController.whiteColor,
                    ))
                : Expanded(
                    child: reusableBtn(context, 'Close', () {
                      Navigator.pop(context);
                    })),
          ],
        ),
        reusablaSizaBox(context, .01)
      ],
    ),
  );
}


// reusableAutoUpdate(BuildContext context,Function ontap){
//   return showDialog(
//     context: context,
//     builder: (context) => AlertDialog(
//         backgroundColor: colorController.whiteColor,
//         title: Center(child: reusableText('Enable Auto Update',color: colorController.blackColor,fontsize: 18,fontweight: FontWeight.bold)),
//         content: Container(
//            width: MediaQuery.of(context).size.width,
//                       height: MediaQuery.of(context).size.height  * .5,
//           child: Positioned(child: SingleChildScrollView(
//             scrollDirection: Axis.vertical,
//             child: Column(
//                   // mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding( padding: const EdgeInsets.all(0.8),
//                              child: reusableText('Tap Manage app and device',color: colorController.grayTextColor,fontsize: 12),
//                              ),
//                                             Padding(
//                                               padding: const EdgeInsets.all(0.8),
//                                               child: reusableText("Tap Manage, then find the app that you want to \n automatically. To open the app's 'Details' \n page tap the app. Trun on Enable-auto update",color: colorController.grayTextColor,fontsize: 12),
//                                             ),
//                                             Image.asset('assets/images/updatepic.png',filterQuality: FilterQuality.high,fit: BoxFit.cover,)
//                   ]
//           ),
//             ),),
//         ),
//         actions: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//            InkWell(
//             onTap: (){Navigator.pop(context);},
//             child: Image.asset('assets/images/remove.png',height: MediaQuery.of(context).size.height * .05 ,width: MediaQuery.of(context).size.width * .1,)),
//            Container(
//             height: MediaQuery.of(context).size.height * .05 ,
//             width: MediaQuery.of(context).size.width * .1,
//              child: CircleAvatar(backgroundColor: colorController.btnColor,child: InkWell(
//               onTap: (){ontap();},
//               child: Center(child: Icon(CupertinoIcons.arrow_right,color: colorController.whiteColor,))),),
//            )
//             ]
//           ),
//           reusablaSizaBox(context, .01)
//         ],
//       ),
//   );
// }

reusableAutoUpdate(BuildContext context, Function ontap) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: colorController.whiteColor,
      title: Center(
          child: reusableText(
        'Enable Auto Update',
        color: colorController.blackColor,
        fontsize: 18,
        fontweight: FontWeight.bold,
      )),
      content: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .5,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(0.8),
                child: reusableText(
                  'Tap Manage app and device',
                  color: colorController.grayTextColor,
                  fontsize: 12,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0.8),
                child: reusableText(
                  "Tap Manage, then find the app that you want to \n automatically. To open the app's 'Details' \n page tap the app. Turn on Enable-auto update",
                  color: colorController.grayTextColor,
                  fontsize: 12,
                ),
              ),
              Image.asset(
                'assets/images/updatepic.png',
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
              )
            ],
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(
                'assets/images/remove.png',
                height: MediaQuery.of(context).size.height * .05,
                width: MediaQuery.of(context).size.width * .1,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * .05,
              width: MediaQuery.of(context).size.width * .1,
              child: CircleAvatar(
                backgroundColor: colorController.btnColor,
                child: InkWell(
                  onTap: () {
                    ontap();
                  },
                  child: Center(
                      child: Icon(
                    CupertinoIcons.arrow_right,
                    color: colorController.whiteColor,
                  )),
                ),
              ),
            ),
          ],
        ),
        reusablaSizaBox(context, .01)
      ],
    ),
  );
}

reusableAttention(BuildContext context,String title, String text) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: colorController.whiteColor,
      title: Center(
          child: reusableText(
        title,
        color: colorController.blackColor,
        fontsize: 18,
        fontweight: FontWeight.bold,
      )),
      content: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .5,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(0.8),
                child: reusableText(
                  text,
                  color: colorController.grayTextColor,
                  fontsize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(
                'assets/images/remove.png',
                height: MediaQuery.of(context).size.height * .05,
                width: MediaQuery.of(context).size.width * .1,
              ),
            ),
            // Container(
            //   height: MediaQuery.of(context).size.height * .05,
            //   width: MediaQuery.of(context).size.width * .1,
            //   child: CircleAvatar(
            //     backgroundColor: colorController.btnColor,
            //     child: InkWell(
            //       onTap: () {
            //         ontap();
            //       },
            //       child: Center(
            //           child: Icon(
            //         CupertinoIcons.arrow_right,
            //         color: colorController.whiteColor,
            //       )),
            //     ),
            //   ),
            // ),
          ],
        ),
        reusablaSizaBox(context, .01)
      ],
    ),
  );
}