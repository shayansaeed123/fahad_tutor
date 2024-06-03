import 'package:dotted_border/dotted_border.dart';
import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/repo/tutor_repo.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusablebtn.dart';
import 'package:fahad_tutor/res/reusabledocuments.dart';
import 'package:fahad_tutor/res/reusableloading.dart';
import 'package:fahad_tutor/res/reusableprofilewidget.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:flutter/cupertino.dart';

class RegistrationCharges extends StatefulWidget {
  const RegistrationCharges({super.key});

  @override
  State<RegistrationCharges> createState() => _RegistrationChargesState();
}

class _RegistrationChargesState extends State<RegistrationCharges> {
  bool isLoading = false;
  TutorRepository repository = TutorRepository();
  Future<void> registerText() async {
    setState(() {
      isLoading = true;
    });
    await repository.Check_popup();
    setState(() {
      isLoading = false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    registerText();
  }
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
                          reusableText("Registration Charges Slip",color: colorController.blackColor,fontsize: 23,fontweight: FontWeight.bold),
                          reusablaSizaBox(context, 0.020),
                          reusableText(repository.Registration_text,color: colorController.blackColor,fontsize: 14),
                          reusablaSizaBox(context, 0.005),
                          Row(children: [reusableText('see ',fontsize: 13.5,fontweight: FontWeight.bold),reusableText('Bank Details',fontsize: 13.5,color: colorController.btnColor,fontweight: FontWeight.bold)],),
                          reusablaSizaBox(context, 0.020),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                reusableText('Add Slip', color: colorController.btnColor,fontsize: 16,fontweight: FontWeight.bold),
                DottedBorder(
                  color: colorController.blackColor,
                    strokeWidth: 2,
                    dashPattern: [6, 3],
                    radius: Radius.circular(15),
                    child:  reusableSelectImage2(context, (){}, '')
                ),
                reusablaSizaBox(context, .010),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * .16),
              child: reusableBtn(context, 'Update', (){}),
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