import 'package:cached_network_image/cached_network_image.dart';
import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/database/my_shared.dart';
import 'package:fahad_tutor/repo/tutor_repo.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusableloading.dart';
import 'package:fahad_tutor/res/reusableprofilewidget.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:flutter/cupertino.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  bool isLoading = true;
 
  @override
  Widget build(BuildContext context) {
    return reusableprofileidget(
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .032),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                reusableText("Terms & Conditions",color: colorController.blackColor,fontsize: 23,fontweight: FontWeight.bold),
                reusablaSizaBox(context, 0.020),
                CachedNetworkImage(imageUrl: MySharedPrefrence().get_term_condition_image(),
               errorWidget: (context, url, error) => reusableloadingrow(context, isLoading),
               fit: BoxFit.cover,
               )
                // Image.network(repository.faqs_images,fit: BoxFit.cover,)
                // if (isLoading)
                //   Center(child: reusableloadingrow(context, isLoading))
                // else if (repository.term_condition_image.isNotEmpty)
                //   Image.network(repository.term_condition_image, fit: BoxFit.cover)
                // else
                //   Center(child: reusableText('Please Check Your Internet Connection',color: colorController.blackColor,fontsize: 16)),
              ],
            ),
            // reusableloadingrow(context, isLoading)
          ],
        ),
      )
    );
  }
}