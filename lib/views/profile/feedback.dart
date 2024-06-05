
import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/controller/text_field_controller.dart';
import 'package:fahad_tutor/database/my_shared.dart';
import 'package:fahad_tutor/repo/tutor_repo.dart';
import 'package:fahad_tutor/repo/utils.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusableTextField.dart';
import 'package:fahad_tutor/res/reusablebtn.dart';
import 'package:fahad_tutor/res/reusableloading.dart';
import 'package:fahad_tutor/res/reusableprofilewidget.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppFeedback extends StatefulWidget {
  const AppFeedback({super.key});

  @override
  State<AppFeedback> createState() => _AppFeedbackState();
}

class _AppFeedbackState extends State<AppFeedback> {
  bool isLoading = false;
   TutorRepository repository = TutorRepository();
  void validate()async{
    if(reusabletextfieldcontroller.feedback.text.isNotEmpty){
      setState(() {isLoading = true;});
      await repository.feedback();
      Utils.snakbarSuccess(context, repository.message);
      feedbackClear();
      setState(() {isLoading=false;});
      Navigator.pop(context);
    }else{
      Utils.snakbar(
                    context,
                    reusabletextfieldcontroller.emailCon.text.isEmpty
                        ? "Feedback Is Missing"
                         : "Fill Correct Fields",
                  );
    }
  }
  void feedbackClear(){
    reusabletextfieldcontroller.feedback.clear();
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
            reusableText('Feedback',color: colorController.blackColor,fontsize: 23,fontweight: FontWeight.bold),
            reusablaSizaBox(context, 0.020),
            reusablemultilineTextField(reusabletextfieldcontroller.feedback, 5, 'Feedback For App'),
            reusablaSizaBox(context, 0.040),
            reusableBtn(context, 'Submit',(){validate();})
          ],
        ),
      ),
      reusableloadingrow(context, isLoading)
    );
  }
}