

import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusablebtn.dart';
import 'package:fahad_tutor/res/reusabledailog.dart';
import 'package:fahad_tutor/res/reusablelisttile.dart';
import 'package:fahad_tutor/res/reusableprofilewidget.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:fahad_tutor/res/rusablelink.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return reusableprofileidget(
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .032),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            reusableText('Settings',color: colorController.blackColor,fontsize: 23,fontweight: FontWeight.bold),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                        // radius: 50,
                        radius:
                                    MediaQuery.of(context).size.width * 0.15,
                        backgroundColor: Colors.white,
                        child: 
                        // Padding(
                        //   padding: EdgeInsets.all(1),
                          // child: 
                          InkWell(
                            onTap: () {
                            },
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.28,
                              
                              child: CircleAvatar(
                                radius:
                                    MediaQuery.of(context).size.width * 0.15,
                                    backgroundColor: colorController.blackColor,
                                // backgroundImage: NetworkImage(
                                //   // MySharedPrefrence()
                                //   //     .get_user_image()
                                //   //     .toString(),
                                // ),
                              ),
                            ),
                          // ),
                        ),
                      ),
                      reusableText('user name',color: colorController.blackColor,fontsize: 14,),
                  ],
                )
              ],
            ),
            reusableText('User Details',color: colorController.blackColor,fontsize: 21,),
            
                      reusablaSizaBox(context, .01),
            reusablelisttile(context,(){
              reusableprofileInfoDialog(context);
            },'assets/images/basic_info_icon.png','Basic Info',),
            reusablelisttile(context,(){},'assets/images/qual_pref_icon.png','Qulification and Preferences',),
            reusablelisttile(context,(){},'assets/images/doc_attach_icon.png','Document Attachment',),
            reusablelisttile(context,(){},'assets/images/terms_and_conditions.png','Terms & Conditions',),
            reusablelisttile(context,(){},'assets/images/reg_charges_slip_icon.png','Registration Charges Slip',),
            reusablelisttile(context,(){},'assets/images/bank_details_icon.png','Bank Details',),
            reusablelisttile(context,(){},'assets/images/add_info_icon.png','Additional Information',),
            reusablelisttile(context,(){},'assets/images/reset_password.png','Change Password',),
             reusablaSizaBox(context, .05),

            reusableText('App Settings',color: colorController.blackColor,fontsize: 21,),
            
                      reusablaSizaBox(context, .01),
            reusablelisttile(context,(){},'assets/images/notification_icon.png','Notification',),
            reusablelisttile(context,(){},'assets/images/faqs_icon.png',"FAQ's",),
            reusablelisttile(context,(){},'assets/images/feedback.png','Feedback For App',),
            reusablelisttile(context,(){},'assets/images/enable.png','Enable Auto Update',),
            reusablelisttile(context,(){},'assets/images/reg_charges_slip_icon.png','Share App',),
            reusablelisttile(context,(){},'assets/images/contact_us_icon.png','Contact Us',),
            reusablelisttile(context,(){},'assets/images/about_us_icon.png','About Us',),
            reusablelisttile(context,(){},'assets/images/remove.png','Delete My Account',),
            reusablaSizaBox(context, .05),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                reusablelink(context, 'assets/images/fb_icon.png', (){}),
                reusablelink(context, 'assets/images/insta_icon.png', (){}),
                reusablelink(context, 'assets/images/web_icon.png', (){}),
                reusablelink(context, 'assets/images/email.png', (){}),
                reusablelink(context, 'assets/images/phone_icon.png', (){}),
                reusablelink(context, 'assets/images/yout.png', (){}),
              ]
            ),
            reusablaSizaBox(context, .05),
            reusableBtn(context, 'Logout'),
            reusablaSizaBox(context, .05),
          ],
        ),
      ),
    );
  }
}