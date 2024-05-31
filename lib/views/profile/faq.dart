

import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/repo/tutor_repo.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusableloading.dart';
import 'package:fahad_tutor/res/reusableprofilewidget.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:flutter/cupertino.dart';

class FAQ extends StatefulWidget {
  const FAQ({super.key});

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check();
  }
  TutorRepository repository = TutorRepository();
  void check()async{
    setState(() {
      isLoading = true;
    });
    await repository.Check_popup();
    setState(() {
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    print('img url ${repository.faqs_images}');
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
                Image.network(repository.faqs_images,fit: BoxFit.cover,)
              ],
            ),
            reusableloadingrow(context, isLoading)
          ],
        ),
      )
    );
  }
}