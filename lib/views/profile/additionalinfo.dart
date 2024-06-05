import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/controller/text_field_controller.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusableTextField.dart';
import 'package:fahad_tutor/res/reusableloading.dart';
import 'package:fahad_tutor/res/reusableprofilewidget.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:flutter/cupertino.dart';

class AdditionalInfo extends StatefulWidget {
  const AdditionalInfo({super.key});

  @override
  State<AdditionalInfo> createState() => _AdditionalInfoState();
}

class _AdditionalInfoState extends State<AdditionalInfo> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return reusableprofileidget(
      Padding(padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .032),
                  child: 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          reusableText("Additional\nInformation",color: colorController.blackColor,fontsize: 25,fontweight: FontWeight.bold),
                          reusablaSizaBox(context, 0.020),
                          reusablemultilineTextField(reusabletextfieldcontroller.addressCon, 3, 'Home Address'),
                          reusablaSizaBox(context, 0.020),
                          //  reusableBtn(context, 'button', (){search();}),
                            
                    ],
                  ),
                ),
      reusableloadingrow(context, isLoading)
    );
  }
}