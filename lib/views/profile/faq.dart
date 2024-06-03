

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
import 'package:cached_network/cached_network.dart';

class FAQ extends StatefulWidget {
  const FAQ({super.key});

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
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
                reusableText("FAQ's",color: colorController.blackColor,fontsize: 23,fontweight: FontWeight.bold),
                reusablaSizaBox(context, 0.020),
                // Image.network(repository.faqs_images,fit: BoxFit.cover,)
               CachedNetworkImage(imageUrl: MySharedPrefrence().get_faqs_images(),
               errorWidget: (context, url, error) => reusableloadingrow(context, isLoading),
               fit: BoxFit.cover,
               )
                // if (isLoading)
                //   Center(child: Container())
                // else if (repository.faqs_images.isNotEmpty)
                //   Image.network(repository.faqs_images, fit: BoxFit.cover)
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