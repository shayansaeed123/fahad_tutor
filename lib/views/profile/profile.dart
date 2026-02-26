import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/controller/text_field_controller.dart';
import 'package:fahad_tutor/database/my_shared.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusableappimage.dart';
import 'package:fahad_tutor/res/reusablebtn.dart';
import 'package:fahad_tutor/res/reusabledailog.dart';
import 'package:fahad_tutor/res/reusablelisttile.dart';
import 'package:fahad_tutor/res/reusableloading.dart';
import 'package:fahad_tutor/res/reusableprofilewidget.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:fahad_tutor/res/reusabletutordetails.dart';
import 'package:fahad_tutor/res/rusablelink.dart';
import 'package:fahad_tutor/views/dashboard/home.dart';
import 'package:fahad_tutor/views/dashboard/nav_bar.dart';
import 'package:fahad_tutor/views/login/login.dart';
import 'package:fahad_tutor/views/profile/accountdetails.dart';
import 'package:fahad_tutor/views/profile/additionalinfo.dart';
import 'package:fahad_tutor/views/profile/biography.dart';
import 'package:fahad_tutor/views/profile/contactus.dart';
import 'package:fahad_tutor/views/profile/documentsattach.dart';
import 'package:fahad_tutor/views/profile/faq.dart';
import 'package:fahad_tutor/views/profile/feedback.dart';
import 'package:fahad_tutor/views/online/tutor/onlineportal.dart';
import 'package:fahad_tutor/views/profile/preferences.dart';
import 'package:fahad_tutor/views/profile/profileimage.dart';
import 'package:fahad_tutor/views/profile/qualification.dart';
import 'package:fahad_tutor/views/profile/registrationcharges.dart';
import 'package:fahad_tutor/views/profile/registrationchargeselanguage.dart';
import 'package:fahad_tutor/views/profile/registrationchargesquran.dart';
import 'package:fahad_tutor/views/profile/resetpassword.dart';
import 'package:fahad_tutor/views/profile/termsconditions.dart';
import 'package:fahad_tutor/views/profile/trainingvideo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fahad_tutor/repo/tutor_repo.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TutorRepository repository = TutorRepository();
  bool isLoading = false;
  bool isToggled = false;
  int values = 0;
                String formattedInfo = "";
  String formatInfo(String info) {
    return info.replaceAll(',', '\n');
  }
  String formatAttention(String info) {
    return info.replaceAll('<><>', '\n');
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
  final Uri phoneUri = Uri.parse("tel:$phone");

  if (await canLaunchUrl(phoneUri)) {
    await launchUrl(phoneUri);
  } else {
    print("Could not launch $phoneUri");
  }
}
void loginClear(){
    reusabletextfieldcontroller.emailCon.clear();
    reusabletextfieldcontroller.loginPassCon.clear();
  }

  void deleteAccount()async{
    setState(() {
      isLoading = true;
    });
    await repository.deleteAccount(context);
    setState(() {isLoading= false;});
  }

  

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    repository.Check_popup();
    print('setstate');
    repository.check_msg();
    repository.check_delete_account();
    repository.documentsAttach();
    repository.basicTutorInfo(MySharedPrefrence().get_user_ID().toString());
  }
       
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => NavBar()),
      (route) => false, // All screens remove ho jayenge
    );
    return false;
  },
      child: Scaffold(
      backgroundColor: colorController.whiteColor,
      appBar: AppBar(elevation: 0,backgroundColor: Colors.transparent,
      leading: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
        child: InkWell(
          onTap: (){Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => NavBar()),(route) => false,);},
          child: Image.asset('assets/images/gradient_back.png',fit: BoxFit.contain,height: MediaQuery.of(context).size.height * 0.02,)),
      ),),
      body: Stack(
        children: [
          SafeArea(child: SingleChildScrollView(child: 
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
                                      MediaQuery.of(context).size.width * 0.13,
                          backgroundColor: Colors.white,
                          child: 
                            InkWell(
                              onTap: () {
                              },
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.28,
                                child: 
                                // MySharedPrefrence().get_profile_img() 
                                ValueListenableBuilder(valueListenable: repository.profile_image, builder: (context, value, child) {
                                  return value != 'https://www.fahadtutors.com/fta_admin/' ? CircleAvatar(
                                  radius:
                                      MediaQuery.of(context).size.width * 0.15,
                                      backgroundColor: colorController.blackColor,
                                  backgroundImage: NetworkImage(
                                    // MySharedPrefrence()
                                    //     .get_profile_img()
                                    //     .toString(),
                                    value.toString(),
                                  ),
                                ) : reusableappimage(context, .1, .1, 'assets/images/profile.png');
                                },)
                              ),
                            // ),
                          ),
                        ),
                        reusablaSizaBox(context, .015),
                        reusableText('${MySharedPrefrence().get_tutor_name()}',color: colorController.blackColor,fontsize: 14,),
                    ],
                  )
                ],
              ),
              reusablaSizaBox(context, .01),
              reusableText('User Details',color: colorController.blackColor,fontsize: 19,),
              reusablaSizaBox(context, .015),
              ValueListenableBuilder<int>(valueListenable: repository.basicInfo, builder: (context, basicInfo, child) {
                return reusablelisttile(context,(){
                print(repository.basicInfo);
                reusableprofileInfoDialog(context,'${formatInfo(MySharedPrefrence().get_info())}',() => _launchEmail("info@fahadtutors.com"),);
              },'assets/images/basic_info_icon.png','Basic Info',widget: Container(
                width: MediaQuery.of(context).size.width * .24,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if(basicInfo == 20)
                    // Image.asset('assets/images/accept.png',width: MediaQuery.of(context).size.width * .058,),
                    CircleAvatar(child: Center(child: Icon(Icons.check,color: colorController.whiteColor,size: 15,)),backgroundColor: colorController.greenColor,maxRadius: 11,), 
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ));
              },),
              ValueListenableBuilder(valueListenable: repository.qualification_pref, builder: (context, value, child) {
                return reusablelisttile(context,(){
               Navigator.push(context, MaterialPageRoute(builder: (context) => Qualification(),));
              },'assets/images/qual_pref_icon.png','Qulification',widget: Container(
                width: MediaQuery.of(context).size.width * .24,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if(value == '20')
                    // Image.asset('assets/images/accept.png',width: MediaQuery.of(context).size.width * .058,),
                    CircleAvatar(child: Center(child: Icon(Icons.check,color: colorController.whiteColor,size: 15,)),backgroundColor: colorController.greenColor,maxRadius: 11,), 
                    if(value == '21')
                    reusableText('(Pending)',color: colorController.greenColor,fontweight: FontWeight.bold),
                    if(value == '8')
                    Image.asset('assets/images/remove.png',width: MediaQuery.of(context).size.width * .058,),
                    if(value == '19')
                    Image.asset('assets/images/remove.png',width: MediaQuery.of(context).size.width * .058,),
                    
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ));
              },),

              ValueListenableBuilder(valueListenable: repository.qualification_pref, builder: (context, value, child) {
                return reusablelisttile(context,(){
               Navigator.push(context, MaterialPageRoute(builder: (context) => QualificationAndPreferences(),));
              },'assets/images/qual_pref_icon.png','Preferences',widget: Container(
                width: MediaQuery.of(context).size.width * .24,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if(value == '20')
                    // Image.asset('assets/images/accept.png',width: MediaQuery.of(context).size.width * .058,),
                    CircleAvatar(child: Center(child: Icon(Icons.check,color: colorController.whiteColor,size: 15,)),backgroundColor: colorController.greenColor,maxRadius: 11,), 
                    if(value == '21')
                    reusableText('(Pending)',color: colorController.greenColor,fontweight: FontWeight.bold),
                    if(value == '8')
                    Image.asset('assets/images/remove.png',width: MediaQuery.of(context).size.width * .058,),
                    if(value == '19')
                    Image.asset('assets/images/remove.png',width: MediaQuery.of(context).size.width * .058,),
                    
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ));
              },),


              ValueListenableBuilder(valueListenable: repository.docs_att, builder: (context, value, child) {
                return reusablelisttile(context,(){
                if(repository.qualification_pref.value == '8' || repository.qualification_pref.value == '19'){
                  reusableAnimationdialog(context, 'Restrict', 'Before accepting documents attachment, Fill all the steps sequentially');
                }else{
                 Navigator.push(context, MaterialPageRoute(builder: (context) => DocumentsAttach(),));
                }
              },'assets/images/doc_attach_icon.png','Document Attachment',widget: Container(
                width: MediaQuery.of(context).size.width * .24,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if(value == '20')
                    // Image.asset('assets/images/accept.png',width: MediaQuery.of(context).size.width * .058,),
                    CircleAvatar(child: Center(child: Icon(Icons.check,color: colorController.whiteColor,size: 15,)),backgroundColor: colorController.greenColor,maxRadius: 11,), 
                    if(value == '21')
                    reusableText('(Pending)',color: colorController.greenColor,fontweight: FontWeight.bold),
                    if(value == '8')
                    Image.asset('assets/images/remove.png',width: MediaQuery.of(context).size.width * .058,),
                    if(value == '19')
                    Image.asset('assets/images/remove.png',width: MediaQuery.of(context).size.width * .058,),
                      // CircleAvatar(child: Center(child: Icon(Icons.check,color: colorController.whiteColor,size: 17,)),backgroundColor: colorController.greenColor,maxRadius: 12,), 
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ));
              },),
              ValueListenableBuilder(valueListenable: repository.is_term_home, builder: (context, value, child) {
                return value == 1 ? ValueListenableBuilder(valueListenable: repository.is_term_accepted, builder: (context, value, child) {
                return reusablelisttile(context,(){
                if(repository.docs_att.value == '8' || repository.docs_att.value == '19'){
                  reusableAnimationdialog(context, 'Restrict', 'Before accepting terms and conditions, Fill all the steps sequentially');
                }else{
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TermsAndConditions(imageUrl: MySharedPrefrence().get_term_condition_image(), btn: repository.is_term_accepted.value,title: repository.term_condition_heading_home.value,term: 'term_condition',),));
                }
              },'assets/images/terms_and_conditions.png', repository.term_condition_heading_home.value,widget: Container(
                width: MediaQuery.of(context).size.width * .24,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if(value == '1')
                    // Image.asset('assets/images/accept.png',width: MediaQuery.of(context).size.width * .058,),
                    CircleAvatar(child: Center(child: Icon(Icons.check,color: colorController.whiteColor,size: 15,)),backgroundColor: colorController.greenColor,maxRadius: 11,), 
                    if(value == '0')
                    Image.asset('assets/images/remove.png',width: MediaQuery.of(context).size.width * .058,),
                      // CircleAvatar(child: Center(child: Icon(Icons.check,color: colorController.whiteColor,size: 17,)),backgroundColor: colorController.greenColor,maxRadius: 12,), 
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ));
              },) : Container();
              },),
              ValueListenableBuilder(valueListenable: repository.is_term_accepted_online_option, builder: (context, value, child) {
                return value == 1 ? ValueListenableBuilder(valueListenable: repository.is_term_accepted_online, builder: (context, value, child) {
                return reusablelisttile(context,(){
                if(repository.is_term_accepted.value == '8' || repository.is_term_accepted.value == '19'){
                  reusableAnimationdialog(context, 'Restrict', 'Before accepting terms and conditions, Fill all the steps sequentially');
                }else{
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TermsAndConditions(imageUrl: MySharedPrefrence().get_term_condition_image_online(),btn: repository.is_term_accepted_online.value,title: repository.term_condition_heading.value,term: 'term_condition_online',),));
                }
              },'assets/images/terms_and_conditions.png', repository.term_condition_heading.value,widget: Container(
                width: MediaQuery.of(context).size.width * .24,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if(value == '1')
                    // Image.asset('assets/images/accept.png',width: MediaQuery.of(context).size.width * .058,),
                    CircleAvatar(child: Center(child: Icon(Icons.check,color: colorController.whiteColor,size: 15,)),backgroundColor: colorController.greenColor,maxRadius: 11,), 
                    if(value == '0')
                    Image.asset('assets/images/remove.png',width: MediaQuery.of(context).size.width * .058,),
                      // CircleAvatar(child: Center(child: Icon(Icons.check,color: colorController.whiteColor,size: 17,)),backgroundColor: colorController.greenColor,maxRadius: 12,), 
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ));
              },) : Container();
              },),
              ValueListenableBuilder(valueListenable: repository.payment_recipt_option, builder: (context, value, child) {
                return value == 1 ? ValueListenableBuilder(valueListenable: repository.payment_recipt, builder: (context, value, child) {
                return reusablelisttile(context,(){
                  print(value);
                // if(value == '8' || value == '19'){

                // if(repository.is_term_accepted.value == '0'){
                //   reusableAnimationdialog(context, 'Restrict', 'Before accepting registration slip, Fill all the steps sequentially');
                // }else{
                   Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationCharges(),));
                // }
                 
              },'assets/images/reg_charges_slip_icon.png',repository.registration_slip.value,widget: Container(
                width: MediaQuery.of(context).size.width * .24,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if(value == '20')
                    // Image.asset('assets/images/accept.png',width: MediaQuery.of(context).size.width * .058,),
                    CircleAvatar(child: Center(child: Icon(Icons.check,color: colorController.whiteColor,size: 15,)),backgroundColor: colorController.greenColor,maxRadius: 11,), 
                    if(value == '21')
                    reusableText('(Pending)',color: colorController.greenColor,fontweight: FontWeight.bold),
                    if(value == '8')
                    Image.asset('assets/images/remove.png',width: MediaQuery.of(context).size.width * .058,),
                    if(value == '19')
                    Image.asset('assets/images/remove.png',width: MediaQuery.of(context).size.width * .058,),
                      // CircleAvatar(child: Center(child: Icon(Icons.check,color: colorController.whiteColor,size: 17,)),backgroundColor: colorController.greenColor,maxRadius: 12,), 
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ));
              },) : Container();
              },),

              ValueListenableBuilder(valueListenable: repository.payment_recipt_option_quran, builder: (context, value, child) {
                return value == 1 ? ValueListenableBuilder(valueListenable: repository.quran_payment_recipt, builder: (context, value, child) {
                return reusablelisttile(context,(){
                  print(value);
                // if(value == '8' || value == '19'){

                // if(repository.is_term_accepted.value == '0'){
                //   reusableAnimationdialog(context, 'Restrict', 'Before accepting registration slip, Fill all the steps sequentially');
                // }else{
                   Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationChargesQuran(),));
                // }
                 
              },'assets/images/reg_charges_slip_icon.png',repository.registration_slip_quran.value,widget: Container(
                width: MediaQuery.of(context).size.width * .24,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if(value == '20')
                    // Image.asset('assets/images/accept.png',width: MediaQuery.of(context).size.width * .058,),
                    CircleAvatar(child: Center(child: Icon(Icons.check,color: colorController.whiteColor,size: 15,)),backgroundColor: colorController.greenColor,maxRadius: 11,), 
                    if(value == '21')
                    reusableText('(Pending)',color: colorController.greenColor,fontweight: FontWeight.bold),
                    if(value == '8')
                    Image.asset('assets/images/remove.png',width: MediaQuery.of(context).size.width * .058,),
                    if(value == '19')
                    Image.asset('assets/images/remove.png',width: MediaQuery.of(context).size.width * .058,),
                      // CircleAvatar(child: Center(child: Icon(Icons.check,color: colorController.whiteColor,size: 17,)),backgroundColor: colorController.greenColor,maxRadius: 12,), 
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ));
              },) : Container();
              },),

              ValueListenableBuilder(valueListenable: repository.payment_recipt_option_english, builder: (context, value, child) {
                return value == 1 ? ValueListenableBuilder(valueListenable: repository.english_payment_recipt, builder: (context, value, child) {
                return reusablelisttile(context,(){
                  print(value);
                // if(value == '8' || value == '19'){

                // if(repository.is_term_accepted.value == '0'){
                //   reusableAnimationdialog(context, 'Restrict', 'Before accepting registration slip, Fill all the steps sequentially');
                // }else{
                   Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationChargesELanguage(),));
                // }
                 
              },'assets/images/reg_charges_slip_icon.png',repository.registration_slip_english.value,widget: Container(
                width: MediaQuery.of(context).size.width * .24,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if(value == '20')
                    // Image.asset('assets/images/accept.png',width: MediaQuery.of(context).size.width * .058,),
                    CircleAvatar(child: Center(child: Icon(Icons.check,color: colorController.whiteColor,size: 15,)),backgroundColor: colorController.greenColor,maxRadius: 11,), 
                    if(value == '21')
                    reusableText('(Pending)',color: colorController.greenColor,fontweight: FontWeight.bold),
                    if(value == '8')
                    Image.asset('assets/images/remove.png',width: MediaQuery.of(context).size.width * .058,),
                    if(value == '19')
                    Image.asset('assets/images/remove.png',width: MediaQuery.of(context).size.width * .058,),
                      // CircleAvatar(child: Center(child: Icon(Icons.check,color: colorController.whiteColor,size: 17,)),backgroundColor: colorController.greenColor,maxRadius: 12,), 
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ));
              },) : Container();
              },),

              ValueListenableBuilder(valueListenable: repository.bank_details, builder: (context, value, child) {
                return reusablelisttile(context,(){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>AccountDetails()));
              },'assets/images/bank_details_icon.png','Bank Details',widget: Container(
                width: MediaQuery.of(context).size.width * .24,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if(value == '20')
                    // Image.asset('assets/images/accept.png',width: MediaQuery.of(context).size.width * .058,),
                    CircleAvatar(child: Center(child: Icon(Icons.check,color: colorController.whiteColor,size: 15,)),backgroundColor: colorController.greenColor,maxRadius: 11,), 
                    if(value == '21')
                    reusableText('(Pending)',color: colorController.greenColor,fontweight: FontWeight.bold),
                    if(value == '8')
                    Image.asset('assets/images/remove.png',width: MediaQuery.of(context).size.width * .058,),
                    if(value == '19')
                    Image.asset('assets/images/remove.png',width: MediaQuery.of(context).size.width * .058,),
                      // CircleAvatar(child: Center(child: Icon(Icons.check,color: colorController.whiteColor,size: 17,)),backgroundColor: colorController.greenColor,maxRadius: 12,),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ));
              },),
              ValueListenableBuilder(valueListenable: repository.additional_info, builder: (context, value, child) {
                return reusablelisttile(context,(){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AdditionalInfo()));
              },'assets/images/add_info_icon.png','Additional Information',widget: Container(
                width: MediaQuery.of(context).size.width * .24,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if(value == '20')
                    // Image.asset('assets/images/accept.png',width: MediaQuery.of(context).size.width * .058,),
                    CircleAvatar(child: Center(child: Icon(Icons.check,color: colorController.whiteColor,size: 15,)),backgroundColor: colorController.greenColor,maxRadius: 11,), 
                    if(value == '21')
                    reusableText('(Pending)',color: colorController.greenColor,fontweight: FontWeight.bold),
                    if(value == '8')
                    Image.asset('assets/images/remove.png',width: MediaQuery.of(context).size.width * .058,),
                    if(value == '19')
                    Image.asset('assets/images/remove.png',width: MediaQuery.of(context).size.width * .058,),
                      // CircleAvatar(child: Center(child: Icon(Icons.check,color: colorController.whiteColor,size: 17,)),backgroundColor: colorController.greenColor,maxRadius: 12,), 
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ));
              },),

              ValueListenableBuilder(valueListenable: repository.additional_info, builder: (context, value, child) {
                return reusablelisttile(context,(){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Biography()));
              },'assets/images/biography.png','Biography',widget: Container(
                width: MediaQuery.of(context).size.width * .24,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if(value == '20')
                    // Image.asset('assets/images/accept.png',width: MediaQuery.of(context).size.width * .058,),
                    CircleAvatar(child: Center(child: Icon(Icons.check,color: colorController.whiteColor,size: 15,)),backgroundColor: colorController.greenColor,maxRadius: 11,), 
                    if(value == '21')
                    reusableText('(Pending)',color: colorController.greenColor,fontweight: FontWeight.bold),
                    if(value == '8')
                    Image.asset('assets/images/remove.png',width: MediaQuery.of(context).size.width * .058,),
                    if(value == '19')
                    Image.asset('assets/images/remove.png',width: MediaQuery.of(context).size.width * .058,),
                      // CircleAvatar(child: Center(child: Icon(Icons.check,color: colorController.whiteColor,size: 17,)),backgroundColor: colorController.greenColor,maxRadius: 12,), 
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ));
              },),


              ValueListenableBuilder(valueListenable: repository.additional_info, builder: (context, value, child) {
                return reusablelisttile(context,(){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Profileimage()));
              },'assets/images/profile.png','Profile Image',widget: Container(
                width: MediaQuery.of(context).size.width * .24,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if(value == '20')
                    // Image.asset('assets/images/accept.png',width: MediaQuery.of(context).size.width * .058,),
                    CircleAvatar(child: Center(child: Icon(Icons.check,color: colorController.whiteColor,size: 15,)),backgroundColor: colorController.greenColor,maxRadius: 11,), 
                    if(value == '21')
                    reusableText('(Pending)',color: colorController.greenColor,fontweight: FontWeight.bold),
                    if(value == '8')
                    Image.asset('assets/images/remove.png',width: MediaQuery.of(context).size.width * .058,),
                    if(value == '19')
                    Image.asset('assets/images/remove.png',width: MediaQuery.of(context).size.width * .058,),
                      // CircleAvatar(child: Center(child: Icon(Icons.check,color: colorController.whiteColor,size: 17,)),backgroundColor: colorController.greenColor,maxRadius: 12,), 
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ));
              },),

              reusablelisttile(context, (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Onlineportal()));
              }, 'assets/images/web_icon.png', 'Online Portal'),
              reusablelisttile(context,(){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPassword()));
              },'assets/images/reset_password.png','Change Password',borderWidth: 0.000001),
               reusablaSizaBox(context, .05),
              reusableText('App Settings',color: colorController.blackColor,fontsize: 19,),
              reusablaSizaBox(context, .01),
      //   reusablelisttile(context, (){}, 'assets/images/notification_icon.png', 'Notification',widget: Switch(
      //   value: isToggled, 
      //   activeTrackColor: colorController.btnColor,
      //   activeColor: colorController.whiteColor,
      //   inactiveTrackColor: colorController.grayTextColor,
      //   inactiveThumbColor: colorController.blackColor,
      //   trackOutlineColor: MaterialStatePropertyAll(colorController.blackColor),
      //   onChanged: (value) {
      //   setState(() {
      //     isToggled = value;
      //   });
      // },),),
              reusablelisttile(context,(){
                Navigator.push(context, MaterialPageRoute(builder: (context) => FAQ(),));
              },'assets/images/faqs_icon.png',"FAQ's",),
              ValueListenableBuilder(valueListenable: repository.attention_option, builder: (context, value, child) {
                if(value == 1){
                  return reusablelisttile(context,(){
                reusableAttention(context, MySharedPrefrence().get_attention_title(), formatAttention(MySharedPrefrence().get_attention_text()));
              },'assets/images/attention.png','Attention',);
                }else{
                  return Container();
                }
              },),
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
              ValueListenableBuilder(valueListenable: repository.traning_video, builder: (context, value, child) {
                if(value == 1){
                  return reusablelisttile(context,(){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TrainingVideos(),));
                  },'assets/images/training.png','Training Videos',);
                }else{
                  return SizedBox.shrink();
                }
              },),
              reusablelisttile(context,(){
                launch('https://www.whatsapp.com/channel/0029Vb6aNRi6xCSRi9FdB80T');
              },'assets/images/whatsapp.png','Join WhatsApp Channel',),
              ValueListenableBuilder(valueListenable: repository.delete_account, builder: (context, value, child) {
                if(value == 1){
                  return reusablelisttile(context,(){
                    reusableDeleteAccountDialog(context, (){deleteAccount();});
                  },'assets/images/remove.png','Delete My Account',borderWidth: 0.000001);
                }else{
                  return Container();
                }
              },),
              reusablaSizaBox(context, .05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  reusablelink(context, 'assets/images/fb_icon.png', (){launch('https://facebook.com/FahadTutorAcademy');}),
                  reusablelink(context, 'assets/images/insta_icon.png', (){launch('https://instagram.com/fahadtutors');}),
                  reusablelink(context, 'assets/images/web_icon.png', (){launch('https://fahadtutors.com');}),
                  reusablelink(context, 'assets/images/email.png', (){_launchEmail("info@fahadtutors.com");}),
                  reusablelink(context, 'assets/images/phone_icon.png', (){_launchPhone('03002391994');}),
                  reusablelink(context, 'assets/images/youtube.png', (){launch('https://youtube.com/@fahadtutorsfta?si=ntx5BBwfHIJHlTZ_');},),
                ]
              ),
              reusablaSizaBox(context, .05),
              reusableBtn(context, 'Logout',(){
                reusableMessagedialog(context, 'Logout', 'Are you sure?', 'Confirm', 'Cancel', (){ 
                  MySharedPrefrence().logout();
                  loginClear();
              //     Navigator.push(context,MaterialPageRoute(
              // builder: (context) => WillPopScope( onWillPop: () async => false, child: Login())),);
              Navigator.push(context, MaterialPageRoute(builder: (context) => Login(),));
                }, (){Navigator.pop(context);});
              }),
              reusablaSizaBox(context, .01),
              Center(
                                    heightFactor: 2.0,
                                    child: reusableText('V: 1.0.105',
                                                                fontsize: 7,
                                                                color: colorController.blueColor,
                                                                fontweight: FontWeight.bold),
                                  ),
                                  reusablaSizaBox(context, .05),
            ],
          ),
        )
          ,),),
          reusableloadingrow(context, isLoading)
        ],
      ),
        ),
    );
  // reusableprofileidget(context,
  //     Padding(
  //       padding: EdgeInsets.symmetric(
  //         horizontal: MediaQuery.of(context).size.width * .032),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           reusableText('Settings',color: colorController.blackColor,fontsize: 23,fontweight: FontWeight.bold),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Column(
  //                 children: [
  //                   CircleAvatar(
  //                       // radius: 50,
  //                       radius:
  //                                   MediaQuery.of(context).size.width * 0.13,
  //                       backgroundColor: Colors.white,
  //                       child: 
  //                         InkWell(
  //                           onTap: () {
  //                           },
  //                           child: SizedBox(
  //                             width: MediaQuery.of(context).size.width * 0.28,
  //                             child: 
  //                             // MySharedPrefrence().get_profile_img() 
  //                             ValueListenableBuilder(valueListenable: repository.profile_image, builder: (context, value, child) {
  //                               return value != 'https://www.fahadtutors.com/fta_admin/' ? CircleAvatar(
  //                               radius:
  //                                   MediaQuery.of(context).size.width * 0.15,
  //                                   backgroundColor: colorController.blackColor,
  //                               backgroundImage: NetworkImage(
  //                                 // MySharedPrefrence()
  //                                 //     .get_profile_img()
  //                                 //     .toString(),
  //                                 value.toString(),
  //                               ),
  //                             ) : reusableappimage(context, .1, .1, 'assets/images/profile.png');
  //                             },)
  //                           ),
  //                         // ),
  //                       ),
  //                     ),
  //                     reusablaSizaBox(context, .015),
  //                     reusableText('${MySharedPrefrence().get_tutor_name()}',color: colorController.blackColor,fontsize: 14,),
  //                 ],
  //               )
  //             ],
  //           ),
  //           reusablaSizaBox(context, .01),
  //           reusableText('User Details',color: colorController.blackColor,fontsize: 19,),
  //           reusablaSizaBox(context, .015),
  //           ValueListenableBuilder<int>(valueListenable: repository.basicInfo, builder: (context, basicInfo, child) {
  //             return reusablelisttile(context,(){
  //             print(repository.basicInfo);
  //             reusableprofileInfoDialog(context,'${formatInfo(MySharedPrefrence().get_info())}',() => _launchEmail("info@fahadtutors.com"),);
  //           },'assets/images/basic_info_icon.png','Basic Info',widget: Container(
  //             width: MediaQuery.of(context).size.width * .24,
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.end,
  //               children: [
  //                 if(basicInfo == 20)
  //                 // Image.asset('assets/images/accept.png',width: MediaQuery.of(context).size.width * .058,),
  //                 CircleAvatar(child: Center(child: Icon(Icons.check,color: colorController.whiteColor,size: 15,)),backgroundColor: colorController.greenColor,maxRadius: 11,), 
  //                 Icon(Icons.arrow_forward_ios)
  //               ],
  //             ),
  //           ));
  //           },),
  //           ValueListenableBuilder(valueListenable: repository.qualification_pref, builder: (context, value, child) {
  //             return reusablelisttile(context,(){
  //            Navigator.push(context, MaterialPageRoute(builder: (context) => QualificationAndPreferences(),));
  //           },'assets/images/qual_pref_icon.png','Qulification and Preferences',widget: Container(
  //             width: MediaQuery.of(context).size.width * .24,
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.end,
  //               children: [
  //                 if(value == '20')
  //                 // Image.asset('assets/images/accept.png',width: MediaQuery.of(context).size.width * .058,),
  //                 CircleAvatar(child: Center(child: Icon(Icons.check,color: colorController.whiteColor,size: 15,)),backgroundColor: colorController.greenColor,maxRadius: 11,), 
  //                 if(value == '21')
  //                 reusableText('(Pending)',color: colorController.greenColor,fontweight: FontWeight.bold),
  //                 if(value == '8')
  //                 Image.asset('assets/images/remove.png',width: MediaQuery.of(context).size.width * .058,),
  //                 if(value == '19')
  //                 Image.asset('assets/images/remove.png',width: MediaQuery.of(context).size.width * .058,),
                  
  //                 Icon(Icons.arrow_forward_ios)
  //               ],
  //             ),
  //           ));
  //           },),
  //           ValueListenableBuilder(valueListenable: repository.docs_att, builder: (context, value, child) {
  //             return reusablelisttile(context,(){
  //             if(repository.qualification_pref.value == '8' || repository.qualification_pref.value == '19'){
  //               reusableAnimationdialog(context, 'Restrict', 'Before accepting documents attachment, Fill all the steps sequentially');
  //             }else{
  //              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DocumentsAttach(),));
  //             }
  //           },'assets/images/doc_attach_icon.png','Document Attachment',widget: Container(
  //             width: MediaQuery.of(context).size.width * .24,
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.end,
  //               children: [
  //                 if(value == '20')
  //                 // Image.asset('assets/images/accept.png',width: MediaQuery.of(context).size.width * .058,),
  //                 CircleAvatar(child: Center(child: Icon(Icons.check,color: colorController.whiteColor,size: 15,)),backgroundColor: colorController.greenColor,maxRadius: 11,), 
  //                 if(value == '21')
  //                 reusableText('(Pending)',color: colorController.greenColor,fontweight: FontWeight.bold),
  //                 if(value == '8')
  //                 Image.asset('assets/images/remove.png',width: MediaQuery.of(context).size.width * .058,),
  //                 if(value == '19')
  //                 Image.asset('assets/images/remove.png',width: MediaQuery.of(context).size.width * .058,),
  //                   // CircleAvatar(child: Center(child: Icon(Icons.check,color: colorController.whiteColor,size: 17,)),backgroundColor: colorController.greenColor,maxRadius: 12,), 
  //                 Icon(Icons.arrow_forward_ios)
  //               ],
  //             ),
  //           ));
  //           },),
            // ValueListenableBuilder(valueListenable: repository.is_term_accepted, builder: (context, value, child) {
            //   return reusablelisttile(context,(){
            //   if(repository.docs_att.value == '8' || repository.docs_att.value == '19'){
            //     reusableAnimationdialog(context, 'Restrict', 'Before accepting terms and conditions, Fill all the steps sequentially');
            //   }else{
            //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TermsAndConditions(imageUrl: MySharedPrefrence().get_term_condition_image(), btn: repository.is_term_accepted.value,title: 'Terms & Conditions',term: 'term_condition',),));
            //   }
            // },'assets/images/terms_and_conditions.png','Terms & Conditions',widget: Container(
            //   width: MediaQuery.of(context).size.width * .24,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       if(value == '1')
            //       // Image.asset('assets/images/accept.png',width: MediaQuery.of(context).size.width * .058,),
            //       CircleAvatar(child: Center(child: Icon(Icons.check,color: colorController.whiteColor,size: 15,)),backgroundColor: colorController.greenColor,maxRadius: 11,), 
            //       if(value == '0')
            //       Image.asset('assets/images/remove.png',width: MediaQuery.of(context).size.width * .058,),
            //         // CircleAvatar(child: Center(child: Icon(Icons.check,color: colorController.whiteColor,size: 17,)),backgroundColor: colorController.greenColor,maxRadius: 12,), 
            //       Icon(Icons.arrow_forward_ios)
            //     ],
            //   ),
            // ));
            // },),
  //           ValueListenableBuilder(valueListenable: repository.is_term_accepted_online_option, builder: (context, value, child) {
  //             return value == 1 ? ValueListenableBuilder(valueListenable: repository.is_term_accepted_online_option, builder: (context, value, child) {
  //             return reusablelisttile(context,(){
  //             if(repository.is_term_accepted.value == '8' || repository.is_term_accepted.value == '19'){
  //               reusableAnimationdialog(context, 'Restrict', 'Before accepting terms and conditions, Fill all the steps sequentially');
  //             }else{
  //               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TermsAndConditions(imageUrl: MySharedPrefrence().get_term_condition_image_online(),btn: repository.is_term_accepted_online.value,title: 'Terms & Conditions (Online)',term: 'term_condition_online',),));
  //             }
  //           },'assets/images/terms_and_conditions.png','Terms & Conditions (Online)',widget: Container(
  //             width: MediaQuery.of(context).size.width * .24,
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.end,
  //               children: [
  //                 if(value == 1)
  //                 // Image.asset('assets/images/accept.png',width: MediaQuery.of(context).size.width * .058,),
  //                 CircleAvatar(child: Center(child: Icon(Icons.check,color: colorController.whiteColor,size: 15,)),backgroundColor: colorController.greenColor,maxRadius: 11,), 
  //                 if(value == 0)
  //                 Image.asset('assets/images/remove.png',width: MediaQuery.of(context).size.width * .058,),
  //                   // CircleAvatar(child: Center(child: Icon(Icons.check,color: colorController.whiteColor,size: 17,)),backgroundColor: colorController.greenColor,maxRadius: 12,), 
  //                 Icon(Icons.arrow_forward_ios)
  //               ],
  //             ),
  //           ));
  //           },) : Container();
  //           },),
  //           ValueListenableBuilder(valueListenable: repository.payment_recipt_option, builder: (context, value, child) {
  //             return value == 1 ? ValueListenableBuilder(valueListenable: repository.payment_recipt, builder: (context, value, child) {
  //             return reusablelisttile(context,(){
  //               print(value);
  //             // if(value == '8' || value == '19'){
  //             if(repository.is_term_accepted.value == '0'){
  //               reusableAnimationdialog(context, 'Restrict', 'Before accepting registration slip, Fill all the steps sequentially');
  //             }else{
  //                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegistrationCharges(),));
  //             }
  //           },'assets/images/reg_charges_slip_icon.png','Registration Charges Slip',widget: Container(
  //             width: MediaQuery.of(context).size.width * .24,
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.end,
  //               children: [
  //                 if(value == '20')
  //                 // Image.asset('assets/images/accept.png',width: MediaQuery.of(context).size.width * .058,),
  //                 CircleAvatar(child: Center(child: Icon(Icons.check,color: colorController.whiteColor,size: 15,)),backgroundColor: colorController.greenColor,maxRadius: 11,), 
  //                 if(value == '21')
  //                 reusableText('(Pending)',color: colorController.greenColor,fontweight: FontWeight.bold),
  //                 if(value == '8')
  //                 Image.asset('assets/images/remove.png',width: MediaQuery.of(context).size.width * .058,),
  //                 if(value == '19')
  //                 Image.asset('assets/images/remove.png',width: MediaQuery.of(context).size.width * .058,),
  //                   // CircleAvatar(child: Center(child: Icon(Icons.check,color: colorController.whiteColor,size: 17,)),backgroundColor: colorController.greenColor,maxRadius: 12,), 
  //                 Icon(Icons.arrow_forward_ios)
  //               ],
  //             ),
  //           ));
  //           },) : Container();
  //           },),
  //           ValueListenableBuilder(valueListenable: repository.bank_details, builder: (context, value, child) {
  //             return reusablelisttile(context,(){
  //              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AccountDetails()));
  //           },'assets/images/bank_details_icon.png','Bank Details',widget: Container(
  //             width: MediaQuery.of(context).size.width * .24,
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.end,
  //               children: [
  //                 if(value == '20')
  //                 // Image.asset('assets/images/accept.png',width: MediaQuery.of(context).size.width * .058,),
  //                 CircleAvatar(child: Center(child: Icon(Icons.check,color: colorController.whiteColor,size: 15,)),backgroundColor: colorController.greenColor,maxRadius: 11,), 
  //                 if(value == '21')
  //                 reusableText('(Pending)',color: colorController.greenColor,fontweight: FontWeight.bold),
  //                 if(value == '8')
  //                 Image.asset('assets/images/remove.png',width: MediaQuery.of(context).size.width * .058,),
  //                 if(value == '19')
  //                 Image.asset('assets/images/remove.png',width: MediaQuery.of(context).size.width * .058,),
  //                   // CircleAvatar(child: Center(child: Icon(Icons.check,color: colorController.whiteColor,size: 17,)),backgroundColor: colorController.greenColor,maxRadius: 12,),
  //                 Icon(Icons.arrow_forward_ios)
  //               ],
  //             ),
  //           ));
  //           },),
  //           ValueListenableBuilder(valueListenable: repository.additional_info, builder: (context, value, child) {
  //             return reusablelisttile(context,(){
  //             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AdditionalInfo()));
  //           },'assets/images/add_info_icon.png','Additional Information',widget: Container(
  //             width: MediaQuery.of(context).size.width * .24,
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.end,
  //               children: [
  //                 if(value == '20')
  //                 // Image.asset('assets/images/accept.png',width: MediaQuery.of(context).size.width * .058,),
  //                 CircleAvatar(child: Center(child: Icon(Icons.check,color: colorController.whiteColor,size: 15,)),backgroundColor: colorController.greenColor,maxRadius: 11,), 
  //                 if(value == '21')
  //                 reusableText('(Pending)',color: colorController.greenColor,fontweight: FontWeight.bold),
  //                 if(value == '8')
  //                 Image.asset('assets/images/remove.png',width: MediaQuery.of(context).size.width * .058,),
  //                 if(value == '19')
  //                 Image.asset('assets/images/remove.png',width: MediaQuery.of(context).size.width * .058,),
  //                   // CircleAvatar(child: Center(child: Icon(Icons.check,color: colorController.whiteColor,size: 17,)),backgroundColor: colorController.greenColor,maxRadius: 12,), 
  //                 Icon(Icons.arrow_forward_ios)
  //               ],
  //             ),
  //           ));
  //           },),
  //           reusablelisttile(context,(){
  //             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ResetPassword()));
  //           },'assets/images/reset_password.png','Change Password',borderWidth: 0.000001),
  //            reusablaSizaBox(context, .05),
  //           reusableText('App Settings',color: colorController.blackColor,fontsize: 19,),
  //           reusablaSizaBox(context, .01),
  // reusablelisttile(context, (){}, 'assets/images/notification_icon.png', 'Notification',widget: Switch(
  //     value: isToggled, 
  //     activeTrackColor: colorController.btnColor,
  //     activeColor: colorController.whiteColor,
  //     inactiveTrackColor: colorController.grayTextColor,
  //     inactiveThumbColor: colorController.blackColor,
  //     trackOutlineColor: MaterialStatePropertyAll(colorController.blackColor),
  //     onChanged: (value) {
  //     setState(() {
  //       isToggled = value;
  //     });
  //   },),),
  //           reusablelisttile(context,(){
  //             Navigator.push(context, MaterialPageRoute(builder: (context) => FAQ(),));
  //           },'assets/images/faqs_icon.png',"FAQ's",),
  //           ValueListenableBuilder(valueListenable: repository.attention_option, builder: (context, value, child) {
  //             if(value == 1){
  //               return reusablelisttile(context,(){
  //             reusableAttention(context, MySharedPrefrence().get_attention_title(), formatAttention(MySharedPrefrence().get_attention_text()));
  //           },'assets/images/attention.png','Attention',);
  //             }else{
  //               return Container();
  //             }
  //           },),
  //           reusablelisttile(context,(){
  //             Navigator.push(context, MaterialPageRoute(builder: (context) => AppFeedback(),));
  //           },'assets/images/feedback.png','Feedback For App',),
  //           reusablelisttile(context,(){
  //             reusableAutoUpdate(context,(){
  //               launch('https://play.google.com/store/apps/details?id=com.fahadtutors');
  //             });
  //           },'assets/images/enable.png','Enable Auto Update',),
  //           reusablelisttile(context,(){
  //              Share.share('https://play.google.com/store/apps/details?id=com.fahadtutors');
  //           },'assets/images/reg_charges_slip_icon.png','Share App',),
  //           reusablelisttile(context,(){
  //             Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUs(),));
  //           },'assets/images/contact_us_icon.png','Contact Us',),
  //           reusablelisttile(context,(){
  //             launch('https://fahadtutors.com/aboutus.php?gad_source=1&gclid=EAIaIQobChMIv_SZ6YSNhgMVMQsGAB1ymwKqEAAYASAFEgLvSPD_BwE');
  //           },'assets/images/about_us_icon.png','About Us',),
  //           ValueListenableBuilder(valueListenable: repository.delete_account, builder: (context, value, child) {
  //             if(value == 1){
  //               return reusablelisttile(context,(){
  //                 reusableDeleteAccountDialog(context, (){deleteAccount();});
  //               },'assets/images/remove.png','Delete My Account',borderWidth: 0.000001);
  //             }else{
  //               return Container();
  //             }
  //           },),
  //           reusablaSizaBox(context, .05),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               reusablelink(context, 'assets/images/fb_icon.png', (){launch('facebook.com/FahadTutorAcademy');}),
  //               reusablelink(context, 'assets/images/insta_icon.png', (){launch('instagram.com/fahadtutors');}),
  //               reusablelink(context, 'assets/images/web_icon.png', (){launch('fahadtutors.com');}),
  //               reusablelink(context, 'assets/images/email.png', (){_launchEmail("info@fahadtutors.com");}),
  //               reusablelink(context, 'assets/images/phone_icon.png', (){_launchPhone('03002391994');}),
  //               reusablelink(context, 'assets/images/youtube.png', (){launch('https://youtube.com/@fahadtutorsfta?si=ntx5BBwfHIJHlTZ_');},),
  //             ]
  //           ),
  //           reusablaSizaBox(context, .05),
  //           reusableBtn(context, 'Logout',(){
  //             reusableMessagedialog(context, 'Logout', 'Are you sure?', 'Confirm', 'Cancel', (){ 
  //               MySharedPrefrence().logout();
  //               loginClear();
  //               Navigator.push(context,MaterialPageRoute(
  //           builder: (context) => WillPopScope( onWillPop: () async => false, child: Login())),);
  //             }, (){Navigator.pop(context);});
  //           }),
  //           reusablaSizaBox(context, .05),
  //         ],
  //       ),
  //     ),
    //   reusableloadingrow(context, isLoading)
    // );
  }
}

