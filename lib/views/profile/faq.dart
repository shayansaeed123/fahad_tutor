import 'package:cached_network_image/cached_network_image.dart';
import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/database/my_shared.dart';
import 'package:fahad_tutor/repo/tutor_repo.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusableloading.dart';
import 'package:fahad_tutor/res/reusableprofilewidget.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FAQ extends StatefulWidget {
  const FAQ({super.key});

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  TutorRepository repository = TutorRepository();
  bool isLoading = false;
  void faq()async{
    setState(() {
      isLoading = true;
    });
    await repository.Check_popup();
    setState(() {isLoading= false;});
  }
  @override
  void initState() {
    super.initState();
    faq();
    
  }
  @override
  Widget build(BuildContext context) {
    return 
    reusableprofileidget( context,
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .032),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // reusableText("FAQ's",color: colorController.blackColor,fontsize: 23,fontweight: FontWeight.bold),
                          Text(
                            "FAQ's",
                            style: TextStyle(
        color: colorController.blackColor,
        fontSize: 25,
        fontWeight: FontWeight.bold,
        fontFamily: 'tutorPhi'
        
      ),
                          ),
                          reusablaSizaBox(context, 0.020),
                         CachedNetworkImage(imageUrl: MySharedPrefrence().get_faqs(),
                         errorWidget: (context, url, error) => Container(),
                         fit: BoxFit.cover,
                         )
                        ],
                      ),
                      
                    ],
                  ),
                ),
                Center(child: reusableloadingrow(context, isLoading))
    );
  }
}