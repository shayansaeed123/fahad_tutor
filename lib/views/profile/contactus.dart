import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/controller/text_field_controller.dart';
import 'package:fahad_tutor/repo/utils.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusableTextField.dart';
import 'package:fahad_tutor/res/reusableloading.dart';
import 'package:fahad_tutor/res/reusableprofilewidget.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  bool isLoading = false;
  late WebViewController _controller;
  @override
  Widget build(BuildContext context) {
    return reusableprofileidget(context,
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .032),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          // primary: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              reusableText("Contact Us",color: colorController.blackColor,fontsize: 23,fontweight: FontWeight.bold),
              reusablaSizaBox(context, 0.020),
              Container(
                height: MediaQuery.of(context).size.height * 1.5,
                child: WebView(
                  initialUrl: 'https://fahadtutors.com/contact_app.php',
                  javascriptMode: JavascriptMode.unrestricted,
                  backgroundColor: colorController.whiteColor,
                  onWebViewCreated: (WebViewController webViewController){
                    _controller = webViewController;
                  },
                  onPageStarted: (String url){
                    Utils.snakbarSuccess(context, 'Page is Loading');
                    print('$url ');
                  },
                  onWebResourceError: (error) {
                    reusableloadingrow(context, isLoading);
                  },
                ),
              )
          //     reusableContactUs(context, 'Name', Icons.person, reusabletextfieldcontroller.contactUsName, 
          //     _namefocusNode, (){_namefocusNode.unfocus();FocusScope.of(context).requestFocus(_emailfocusNode);}),
          //     reusablaSizaBox(context, 0.020),
          //     reusableContactUs(context, 'Email', Icons.email, reusabletextfieldcontroller.contactUsName, 
          //     _emailfocusNode, (){_emailfocusNode.unfocus();FocusScope.of(context).requestFocus(_phonefocusNode);}),
          //     reusablaSizaBox(context, 0.020),
          //     reusableContactUs(context, 'Phone', Icons.phone_android, reusabletextfieldcontroller.contactUsName, 
          //     _phonefocusNode, (){_phonefocusNode.unfocus();FocusScope.of(context).requestFocus(_infofocusNode);}),
          //     reusablaSizaBox(context, 0.020),
          //     Row(mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       reusableText('Further Information',color: colorController.blackColor,fontsize: 16),
          //       Icon(Icons.message_outlined,color: colorController.blackColor,size: 20,),
          //     ],),
          //     TextField(
          //           maxLines: 5, 
          //           decoration: InputDecoration(
          //             hintText: 'Write your message and Questions here',
          //             border: OutlineInputBorder(
          //     borderRadius: BorderRadius.circular(10),
          //     borderSide: BorderSide(
          //         color: colorController.textfieldBorderColorBefore, width: .75)),
          // enabledBorder: OutlineInputBorder(
          //     borderRadius: BorderRadius.circular(10),
          //     borderSide: BorderSide(
          //         color: colorController.textfieldBorderColorBefore, width: .75)),
          // focusedBorder: OutlineInputBorder(
          //     borderRadius: BorderRadius.circular(10),
          //     borderSide: BorderSide(
          //         color: colorController.appliedTextColor, width: .75)),
          //           ),
          //     ),
          //     reusablaSizaBox(context, 0.030),
          //     Container(
          //       width: MediaQuery.of(context).size.width * .23,
          //       height: MediaQuery.of(context).size.height * .05,
          //       decoration: BoxDecoration(
          //         color: colorController.appliedTextColor,
          //         borderRadius: BorderRadius.circular(7),
          //       ),
          //       child: Center(child: reusableText('Submit', color: colorController.whiteColor,fontsize: 18,fontweight: FontWeight.bold)),
          //     ),
          //     Container(
          //       width: MediaQuery.of(context).size.width,
          //       // height: MediaQuery.of(context).size.height * .5,
          //       padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * .08,right: MediaQuery.of(context).size.width * .08,top: MediaQuery.of(context).size.height * .08,bottom: MediaQuery.of(context).size.height * .26),
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           reusablaSizaBox(context, .001),
          //           reusableText('Address', color: colorController.blackColor,fontsize: 18.5,fontweight: FontWeight.bold),
          //           reusablaSizaBox(context, .001),
          //           reusableText('Office 306 Bhayani Shopping Center Block M Northnazimabad Karachi', color: colorController.lightblackColor,fontsize: 17),
          //           reusablaSizaBox(context, .050),
          //           reusableText('Phone', color: colorController.blackColor,fontsize: 18.5,fontweight: FontWeight.bold),
          //           reusablaSizaBox(context, .001),
          //           reusableText('+92-300-2391994', color: colorController.appliedTextColor,fontsize: 17),
          //           reusablaSizaBox(context, .050),
          //           reusableText('Whatsapp', color: colorController.blackColor,fontsize: 18.5,fontweight: FontWeight.bold),
          //           reusablaSizaBox(context, .001),
          //           reusableText('+92-300-2391994', color: colorController.appliedTextColor,fontsize: 17),
          //           reusablaSizaBox(context, .050),
          //           reusableText('Email Address', color: colorController.blackColor,fontsize: 18.5,fontweight: FontWeight.bold),
          //           reusablaSizaBox(context, .001),
          //           reusableText('info@fahadtutors.com', color: colorController.appliedTextColor,fontsize: 17),
          //           reusablaSizaBox(context, .050),
          //           reusableText('100% Certified Tutors For', color: colorController.blackColor,fontsize: 18.5,fontweight: FontWeight.bold),
          //           reusablaSizaBox(context, .001),
          //           reusableText('- All Classes & Subjects', color: colorController.lightblackColor,fontsize: 17),
          //           reusablaSizaBox(context, .001),
          //           reusableText('- Online Quran', color: colorController.lightblackColor,fontsize: 17),
          //           reusablaSizaBox(context, .001),
          //           reusableText('- Test Preparation', color: colorController.lightblackColor,fontsize: 17),
          //           reusablaSizaBox(context, .001),
          //           reusableText('According to your requirements', color: colorController.lightblackColor,fontsize: 17),
                //   ],
                // ),
              // )
            ],
          ),
        ),
      ),
      reusableloadingrow(context, isLoading)
    );
  }
}