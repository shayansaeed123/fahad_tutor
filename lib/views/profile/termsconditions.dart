import 'package:cached_network_image/cached_network_image.dart';
import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/database/my_shared.dart';
import 'package:fahad_tutor/repo/tutor_repo.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusablebtn.dart';
import 'package:fahad_tutor/res/reusableloading.dart';
import 'package:fahad_tutor/res/reusableprofilewidget.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  TutorRepository repository = TutorRepository();
  bool isLoading = false;
  void faq()async{
      isLoading = true;
    await repository.Check_popup();
    isLoading = false;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    faq();
  }
  @override
  Widget build(BuildContext context) {
    return 
    reusableprofileidget(
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .032),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      reusableText("Terms & Conditions",color: colorController.blackColor,fontsize: 23,fontweight: FontWeight.bold),
                          reusablaSizaBox(context, 0.020),
                           CachedNetworkImage(
                            imageUrl: MySharedPrefrence().get_term_condition(),
                            placeholder: (context, url) => Center(child: reusableloadingrow(context, isLoading==true)),
                            errorWidget: (context, url, error) => Container(),
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.low,
                          ),
                          reusablaSizaBox(context, 0.030),
                          if(repository.is_term_accepted.value == '0')
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .069),
                            child: reusableBtn(context, 'Ok', (){}),
                          ),
                          
                    ],
                  )
                 
                ),
                Center(child: Container())
    );
  }
}