import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/controller/text_field_controller.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusableTextField.dart';
import 'package:fahad_tutor/res/reusablebtn.dart';
import 'package:fahad_tutor/res/reusableloading.dart';
import 'package:fahad_tutor/res/reusableprofilewidget.dart';
import 'package:fahad_tutor/res/reusableradiobtn.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:fahad_tutor/res/reusablevisibility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdditionalInfo extends StatefulWidget {
  const AdditionalInfo({super.key});

  @override
  State<AdditionalInfo> createState() => _AdditionalInfoState();
}

class _AdditionalInfoState extends State<AdditionalInfo> {
  bool isLoading = false;
  DateTime? selectedTime;
  late DateTime lastDate = DateTime(1995, 1, 1);
  late FocusNode _furtherInfofocusNode;
  String? selectedCurrentTeaching;
  String? selectedTeachingExp;
  String? oLevel;
  String? aLevel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _furtherInfofocusNode = FocusNode();
    _furtherInfofocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _furtherInfofocusNode.dispose();
    _furtherInfofocusNode.removeListener(_onFocusChange);
  }
  void _onFocusChange() {
    setState(() {
      // Redraw the UI when the focus changes
    });
  }
  String _selectedValue = 'Tutor';
  String _selectedValue1 = 'Yes';
  String _selectedValue2 = 'none';
  bool isHomeWidgetVisible = false;
  final TextEditingController _biography = TextEditingController();
  int _charCount = 0;

  void _updateCharCount() {
    setState(() {
      _charCount = _biography.text.length;
    });
  }

  List<String> selectedPlacements = [];

void updateTutorPlacement() {
  selectedPlacements.clear();
  if (checkbox1) selectedPlacements.add('Home');
  if (checkbox2) selectedPlacements.add('Online');
  if (checkbox3) selectedPlacements.add("At Tutor's Place");
}
  bool checkbox1 = false;
  bool checkbox2 = false;
  bool checkbox3 = false;

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
                          reusableDateofBirthField(context, lastDate, selectedTime, (DateTime timeofday){
                             setState(() {
                                            selectedTime = timeofday;
                                            print('time date $selectedTime');
                                          });
                          },
                          SizedBox.shrink(),
                          ),
                          reusablaSizaBox(context, 0.020),
                          reusableTextField(context, reusabletextfieldcontroller.furtherInfo, 'Further Information', _furtherInfofocusNode.hasFocus
                                      ? colorController.blueColor
                                      : colorController
                                          .textfieldBorderColorBefore,
                                  _furtherInfofocusNode,
                                  () {
                                    _furtherInfofocusNode.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_furtherInfofocusNode);
                                  },),
                                  reusablaSizaBox(context, 0.020),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      reusableDropdownfeild(context, selectedCurrentTeaching, (String? newValue){
                                    setState(() {
                                            selectedCurrentTeaching = newValue;
                                            print('Current teaching $selectedCurrentTeaching');
                                          });
                                  }, 'Currently Teaching', ['Yes','No']),
                                  reusableDropdownfeild(context, selectedTeachingExp, (String? newValue){
                                    setState(() {
                                            selectedTeachingExp = newValue;
                                            print('teaching experience $selectedTeachingExp');
                                          });
                                  }, 'Teaching Experience', ['1-2 years','2-3 years','5+ years'])
                                    ],
                                  ),
                                  reusablaSizaBox(context, 0.020),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      reusableDropdownfeild(context, oLevel, (String? newValue){
                                    setState(() {
                                            oLevel = newValue;
                                            print('O-Level Qualified  $oLevel');
                                          });
                                  }, 'O-Level Qualified', ['Yes','No']),
                                  reusableDropdownfeild(context, aLevel, (String? newValue){
                                    setState(() {
                                            aLevel = newValue;
                                            print('A-Level Qualified $aLevel');
                                          });
                                  }, 'A-Level Qualified', ['Yes','No'])
                                    ],
                                  ),
                                  reusablaSizaBox(context, .020),
                                  reusableText('Tutors Placment', fontsize: 21),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    buildCheckboxWithTitle('Home', checkbox1,(){
                                      setState(() {});
                                      reusableMessagedialog(context, 'Placement',
                    "You will have to visit at student's place", 'Confirm', () {
                      setState(() {});
                      checkbox1 = true;
                      updateTutorPlacement();
                      print(selectedPlacements);
                    Navigator.pop(context);
                    setState(() {});
                }, () {
                  setState(() {});
                  checkbox1 = false;
                  updateTutorPlacement();
                  print(selectedPlacements);
                  Navigator.pop(context);
                  setState(() {});
                });
                                    }),
                                    buildCheckboxWithTitle('Online', checkbox2,(){},),
                                  ],
                                ),
                                buildCheckboxWithTitle(
                                    "At Tutor's Place", checkbox3, (){},),
                                reusablaSizaBox(context, .02),
                                onlineVisibility(
                                  context,
                                  isHomeWidgetVisible,
                                  reusableRadioBtn(
                                    context,
                                    'Yes',
                                    'No',
                                    _selectedValue1,
                                    (String? value) {
                                    // onChanged function
                                    setState(() {
                                      _selectedValue1 = value!;
                                      print('digitalPad $_selectedValue1');
                                    });
                                  },
                                    'Yes',
                                    'No',
                                    .4,
                                  ),
                                  _selectedValue1,
                                  _selectedValue2,
                                  (String? value) {
                                    // onChanged function
                                    setState(() {
                                      _selectedValue2 = value!;
                                      print('Experience $_selectedValue2');
                                    });
                                  },
                                  _biography,
                                  _charCount,
                                ),
                                reusablaSizaBox(context, 0.020),
                                Padding(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * .10),
                                  child: reusableBtn(context, 'Update', () {
                                  
                                  }),
                                ),
                    ],
                  ),
                ),
      reusableloadingrow(context, isLoading)
    );
  }
  Widget buildCheckboxWithTitle(String title, bool value,Function ontap,){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          shape: ContinuousRectangleBorder(),
          overlayColor: MaterialStatePropertyAll(colorController.blueColor),
          activeColor: colorController.blueColor,
          side: BorderSide(color: colorController.blueColor, width: 1.5),
          value: value,
          onChanged: (newValue) {
            setState(() {
              if (title == 'Home') {
                // checkbox1 = newValue ?? false;
                ontap();
              } else if (title == 'Online') {
                checkbox2 = newValue ?? false;
                if (newValue == true) {
                  isHomeWidgetVisible = true;
                  updateTutorPlacement();
                   print(selectedPlacements);
                } else {
                  updateTutorPlacement();
                   print(selectedPlacements);
                  isHomeWidgetVisible = false;
                }
              } else if (title == "At Tutor's Place") {
                checkbox3 = newValue ?? false;
                updateTutorPlacement();
                 print(selectedPlacements);
              }
            });
          },
        ),
        reusableText(title, fontsize: 15),
      ],
    );
  }
}