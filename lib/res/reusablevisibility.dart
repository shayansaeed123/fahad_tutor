

import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusableradiobtn.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

Widget reusableVisiblityMesage(BuildContext context,String text,Function ontap,bool visible){
  return Visibility(
    visible: visible,
    child: Container(
      width: MediaQuery.of(context).size.width * 1,
      // height: MediaQuery.of(context).size.height * .057,
      padding: EdgeInsets.symmetric(vertical:  MediaQuery.of(context).size.height * .014),
      decoration: BoxDecoration(
          color: colorController.btnColor,
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal:  MediaQuery.of(context).size.width * .036),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: reusableText(text,color: colorController.whiteColor,fontsize: 14)),
            InkWell(
              onTap: (){
                ontap();
              },
              child: Icon(Icons.cancel,color: colorController.whiteColor,size: 30,)),
          ],
        ),
      )
    ),
  );
}

Widget reusableVisiblityWarning(BuildContext context,String text,Function ontap,bool visible){
  return Visibility(
    visible: visible,
    child: Container(
      width: MediaQuery.of(context).size.width * 1,
      // height: MediaQuery.of(context).size.height * .057,
      padding: EdgeInsets.symmetric(vertical:  MediaQuery.of(context).size.height * .007),
      decoration: BoxDecoration(
          color: colorController.redColor,
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal:  MediaQuery.of(context).size.width * .036),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            reusableText(text,color: colorController.whiteColor,fontsize: 14),
            InkWell(
              onTap: (){
                ontap();
              },
              child: Icon(Icons.cancel,color: colorController.whiteColor,size: 30,)),
          ],
        ),
      )
    ),
  );
}

onlineVisibility(BuildContext context,bool isHomeWidgetVisible,Widget widget, String? _selectedValue1,String? _selectedValue2,Function(String?) onChanged,TextEditingController controller,
int count,
//  Widget widget2
 ){
  return Visibility(
            visible: isHomeWidgetVisible,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                reusableText('Do you have Digital Pad?',color: colorController.grayTextColor,fontsize: 20,),
                widget,
                reusableText('Teaching Experience',color: colorController.grayTextColor,fontsize: 18.5),
                // Container(
                //   padding: EdgeInsets.all(0),
                //   width: MediaQuery.of(context).size.width,
                //   child: 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: buildRadioButton('None', 'none',_selectedValue2,onChanged)),
                Expanded(child: buildRadioButton('1-2 years', '1-2',_selectedValue2,onChanged)),
                Expanded(child: buildRadioButton('3-4 years', '3-4',_selectedValue2,onChanged)),
                Expanded(child: buildRadioButton('5+ years', '5+',_selectedValue2,onChanged)),
                      // Expanded(
                      //   // width: MediaQuery.of(context).size.width * .2,
                      //   // height: MediaQuery.of(context).size.height * 0.08,
                      //   child: 
                      //   RadioListTile(
                      //     value: 'none',
                      //     groupValue: _selectedValue2,
                      //     onChanged: onChanged,
                      //     activeColor: MaterialStateColor.resolveWith(
                      //         (states) => colorController.blueColor),
                      //   ),
                      // ),
                      // Expanded(
                      //   // width: MediaQuery.of(context).size.width * .2,
                      //   // height: MediaQuery.of(context).size.height * 0.08,
                      // child: 
                      // RadioListTile(
                      //   value: '1-2',
                      //   groupValue: _selectedValue2,
                      //   onChanged: onChanged,
                      //   activeColor: MaterialStateColor.resolveWith(
                      //       (states) => colorController.blueColor),
                        
                      // ),
                      //               ),
                      // Expanded(
                      //   // width: MediaQuery.of(context).size.width * .2,
                      //   // height: MediaQuery.of(context).size.height * 0.08,
                      // child: 
                      // RadioListTile(
                      //   value: '3-4',
                      //   groupValue: _selectedValue2,
                      //   onChanged: onChanged,
                      //   activeColor: MaterialStateColor.resolveWith(
                      //       (states) => colorController.blueColor),
                      // ),
                      // ),
                      // Expanded(
                      //   // width: MediaQuery.of(context).size.width * .2,
                      //   // height: MediaQuery.of(context).size.height * 0.08,
                      // child: 
                      // RadioListTile(
                      //   value: '5+',
                      //   groupValue: _selectedValue2,
                      //   onChanged: onChanged,
                      //   activeColor: MaterialStateColor.resolveWith(
                      //       (states) => colorController.blueColor),
                      // ),
                      // ),
                    ],
                  ),
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //   reusableText('None',fontsize: 14,),
                //   reusableText('1-2 years', fontsize: 14),
                //   reusableText('3-4 Years', fontsize: 14),
                //   reusableText('5+ Years', fontsize: 14,),
                // ],),
                reusablaSizaBox(context, .01),
                TextField(
                  controller: controller,
                  maxLines: 10, // Set the maximum number of lines
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    label: reusableText('Biography'),
                    labelStyle: TextStyle(color: colorController.grayTextColor),
                    border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: colorController.textfieldBorderColorBefore, width: 1.5)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: colorController.textfieldBorderColorBefore, width: 1.5)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: 
                count > 800 ? colorController.redColor : 
                colorController.textfieldBorderColorAfter, 
                width: 1.5)),
                  ),
            ),
            Row(mainAxisAlignment:MainAxisAlignment.end,children: [reusableText('$count/800',color: count > 800 ? colorController.redColor : colorController.blackColor)],)
              ],
            ),
          );
}

Widget buildRadioButton(String title, String value,String? groupValue,Function(String?) onChanged) {
    return 
    // Flexible(
    //   child: 
      Row(
        children: [
          Radio<String>(
            value: value,
            groupValue: groupValue,
            fillColor: MaterialStateColor.resolveWith(
                            (states) => colorController.blueColor),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
          activeColor: MaterialStateColor.resolveWith(
                            (states) => colorController.blueColor),
            onChanged: onChanged,
          ),
          Flexible(child: Text(title, overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 12),)),
        ],
      // ),
    );
  }

