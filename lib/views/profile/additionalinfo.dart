import 'dart:convert';

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
import 'package:fahad_tutor/res/reusableradiobtn.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:fahad_tutor/res/reusablevisibility.dart';
import 'package:fahad_tutor/views/profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
    getAddtionalInfo();
    _furtherInfofocusNode = FocusNode();
    _furtherInfofocusNode.addListener(_onFocusChange);
    repository.check_msg();
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
    });
  }
  String _selectedValue = 'Tutor';
  String _selectedValue1 = 'Yes';
  String _selectedValue2 = 'none';
  bool isHomeWidgetVisible = false;
  String update_status = '';
  String source = '';
  bool visible = true;
  final TextEditingController _biography = TextEditingController();
  int _charCount = 0;
  TutorRepository repository = TutorRepository();

  void _updateCharCount() {
    setState(() {
      _charCount = _biography.text.length;
    });
  }

  List<String> selectedPlacements = [];
  List<dynamic> Placements = [];
  String PlacementName1 = '';
  String PlacementName2 = '';
  String PlacementName3 = '';
  String PlacementId1 = '';
  String PlacementId2 = '';
  String PlacementId3 = '';

void updateTutorPlacement() {
  selectedPlacements.clear();
  if (checkbox1) selectedPlacements.add(PlacementId1);
  if (checkbox2) selectedPlacements.add(PlacementId2);
  if (checkbox3) selectedPlacements.add(PlacementId3);
}
  bool checkbox1 = false;
  bool checkbox2 = false;
  bool checkbox3 = false;

  Future<void> updateAdditionalInfo() async {
  setState(() {
    isLoading = true;
  });
  try {
    final bio = _biography.text.toString();
    final response = await http.post(
      Uri.parse('${Utils.baseUrl}mobile_app/step_3_update.php'),
      body: {
        'code': '10',
        'success' : 1.toString(),
        'tutor_id': MySharedPrefrence().get_user_ID().toString(),
        'update_status': update_status.toString(),
        'home_address': reusabletextfieldcontroller.addressCon.text.toString(),
        'further_info': reusabletextfieldcontroller.furtherInfo.text.toString(),
        'date_of_birth': selectedTime.toString(),
        'father_profession': '',
        'olevel': oLevel.toString(),
        'alevel': aLevel.toString(),
        'currently_teaching': reusabletextfieldcontroller.accountnumber.text.toString(),
        'Teaching_ex': selectedCurrentTeaching.toString(),
        'DigitalPad': _selectedValue1.toString(),
        'onlineTeaching_experience': _selectedValue2.toString(),
        'online_Skill': '',
        'Biography': bio.toString(),
        'tutor_placement': jsonEncode(selectedPlacements),
        'source': '',
      }
    );
    print(bio);
    print('Request body: ${response.request}');
    print('$_selectedValue1+ $aLevel + $selectedTime + $selectedPlacements');
    if (response.statusCode == 200) {
      print('Response status: ${response.statusCode}');
      final Map<String, dynamic> responseData = json.decode(response.body);
      print('Response body: $responseData');
      String apiMessage = responseData['message'];
      print('Message: $apiMessage');
      if (responseData['success'] == 1) {
        setState(() {});
        print('Success message: $apiMessage');
        // Navigator.pop(context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Profile(),));
        Utils.snakbarSuccess(context, apiMessage);
      } else {
        Utils.snakbarFailed(context, apiMessage);
      }
    } else {
      print('Error: ${response.statusCode}');
    }
  } catch (e) {
    Utils.snakbar(context, 'Check your Internet Connection');
    print('Update API Error: $e');
  } finally {
    setState(() {
      isLoading = false;
    });
  }
}

Future<void> getAddtionalInfo() async {
  setState(() {
    isLoading = true;
  });
  try {
    final userId = MySharedPrefrence().get_user_ID().toString();
    print('Fetching data for user ID: $userId');
    final response = await http.get(
      Uri.parse('${Utils.baseUrl}mobile_app/step_3.php?code=10&tutor_id=$userId')
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      update_status = responseData['update_status'];
      Placements = responseData['placement_listing'];
      PlacementName1 = Placements[0]['placement_name'];
      PlacementName2 = Placements[1]['placement_name'];
      PlacementName3 = Placements[2]['placement_name'];
      PlacementId1 = Placements[0]['id'];
      PlacementId2 = Placements[1]['id'];
      PlacementId3 = Placements[2]['id'];
    } else {
      print('Error: ${response.statusCode}');
    }
  } catch (e) {
    print('Get API Error: $e');
  } finally {
    setState(() {
      isLoading = false;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return reusableprofileidget(context,
      Padding(padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .032),
                  child: 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          reusableText("Additional\nInformation",color: colorController.blackColor,fontsize: 25,fontweight: FontWeight.bold),
                          reusablaSizaBox(context, 0.020),
                          ValueListenableBuilder(valueListenable: repository.popup, builder: (context, value, child) {
              if(value == 1){
                return reusableVisiblityMesage(context, MySharedPrefrence().get_popup_text(), (){setState(() {visible=false;});}, visible);
                }else{return Container();}},),
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
                                    '1',
                                    '0',
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
                                  updateAdditionalInfo();
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