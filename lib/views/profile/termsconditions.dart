import 'package:fahad_tutor/controller/color_controller.dart';
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
    print('img url ${repository.term_condition_image}');
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
                if (isLoading)
                  Center(child: reusableloadingrow(context, isLoading))
                else if (repository.term_condition_image.isNotEmpty)
                  Image.network(repository.term_condition_image, fit: BoxFit.cover)
                else
                  Center(child: reusableText('Please Check Your Internet Connection',color: colorController.blackColor,fontsize: 16)),
              ],
            ),
            // reusableloadingrow(context, isLoading)
          ],
        ),
      )
    );
  }
}