

import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/database/my_shared.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusablebtn.dart';
import 'package:fahad_tutor/res/reusabledailog.dart';
import 'package:fahad_tutor/res/reusablelisttile.dart';
import 'package:fahad_tutor/res/reusableloading.dart';
import 'package:fahad_tutor/res/reusableprofilewidget.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:fahad_tutor/res/reusabletutordetails.dart';
import 'package:fahad_tutor/res/rusablelink.dart';
import 'package:fahad_tutor/views/login/login.dart';
import 'package:fahad_tutor/views/profile/contactus.dart';
import 'package:fahad_tutor/views/profile/faq.dart';
import 'package:fahad_tutor/views/profile/feedback.dart';
import 'package:fahad_tutor/views/profile/resetpassword.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
                String formattedInfo = "";
  String formatInfo(String info) {
    return info.replaceAll(',', '\n');
  }
  void _launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not launch $emailUri';
    }
  }
  void _launchPhone(String phone) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phone,
    );
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch $phoneUri';
    }
  }
  Future<void> _launchGooglePlayStore() async {
  const url = 'https://play.google.com/store/apps/details?id=com.example.app'; // Replace with your app's URL
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
       
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
                      reusableText('${MySharedPrefrence().get_tutor_name()}',color: colorController.blackColor,fontsize: 14,),
                  ],
                )
              ],
            ),
            reusableText('User Details',color: colorController.blackColor,fontsize: 21,),
            
                      reusablaSizaBox(context, .01),
            reusablelisttile(context,(){
              reusableprofileInfoDialog(context,'${formatInfo(MySharedPrefrence().get_info())}',() => _launchEmail("info@fahadtutors.com"),);
            },'assets/images/basic_info_icon.png','Basic Info',),
            reusablelisttile(context,(){},'assets/images/qual_pref_icon.png','Qulification and Preferences',),
            reusablelisttile(context,(){},'assets/images/doc_attach_icon.png','Document Attachment',),
            reusablelisttile(context,(){},'assets/images/terms_and_conditions.png','Terms & Conditions',),
            reusablelisttile(context,(){},'assets/images/reg_charges_slip_icon.png','Registration Charges Slip',),
            reusablelisttile(context,(){},'assets/images/bank_details_icon.png','Bank Details',),
            reusablelisttile(context,(){},'assets/images/add_info_icon.png','Additional Information',),
            reusablelisttile(context,(){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPassword()));
            },'assets/images/reset_password.png','Change Password',),
             reusablaSizaBox(context, .05),

            reusableText('App Settings',color: colorController.blackColor,fontsize: 21,),
            
                      reusablaSizaBox(context, .01),
            reusablelisttile(context,(){},'assets/images/notification_icon.png','Notification',),
            reusablelisttile(context,(){
              Navigator.push(context, MaterialPageRoute(builder: (context) => FAQ(),));
            },'assets/images/faqs_icon.png',"FAQ's",),
            reusablelisttile(context,(){
              Navigator.push(context, MaterialPageRoute(builder: (context) => AppFeedback(),));
            },'assets/images/feedback.png','Feedback For App',),
            reusablelisttile(context,(){
              reusableAutoUpdate(context,(){
                launch('https://play.google.com/store/apps/details?id=com.fahadtutors');
              });
            },'assets/images/enable.png','Enable Auto Update',),
            reusablelisttile(context,(){
               Share.share('https://play.google.com/store/apps/details?id=com.fahadtutors');
            },'assets/images/reg_charges_slip_icon.png','Share App',),
            reusablelisttile(context,(){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUs(),));
            },'assets/images/contact_us_icon.png','Contact Us',),
            reusablelisttile(context,(){
              launch('https://fahadtutors.com/aboutus.php?gad_source=1&gclid=EAIaIQobChMIv_SZ6YSNhgMVMQsGAB1ymwKqEAAYASAFEgLvSPD_BwE');
            },'assets/images/about_us_icon.png','About Us',),
            reusablelisttile(context,(){},'assets/images/remove.png','Delete My Account',),
            reusablaSizaBox(context, .05),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                reusablelink(context, 'assets/images/fb_icon.png', (){launch('facebook.com/FahadTutorAcademy');}),
                reusablelink(context, 'assets/images/insta_icon.png', (){launch('instagram.com/fahadtutors');}),
                reusablelink(context, 'assets/images/web_icon.png', (){launch('fahadtutors.com');}),
                reusablelink(context, 'assets/images/email.png', (){_launchEmail("info@fahadtutors.com");}),
                reusablelink(context, 'assets/images/phone_icon.png', (){_launchPhone('03002391994');}),
                reusablelink(context, 'assets/images/yout.png', (){launch('https://youtube.com/@fahadtutorsfta?si=ntx5BBwfHIJHlTZ_');}),
              ]
            ),
            reusablaSizaBox(context, .05),
            reusableBtn(context, 'Logout',(){
              reusableMessagedialog(context, 'Logout', 'Are you sure?', 'Confirm', (){
                MySharedPrefrence().logout();
                Navigator.push(context,MaterialPageRoute(
            builder: (context) => WillPopScope( onWillPop: () async => false, child: Login())),);
              }, (){Navigator.pop(context);});
              // MySharedPrefrence().logout();
            }),
            reusablaSizaBox(context, .05),
          ],
        ),
      ),
    );
  }
}