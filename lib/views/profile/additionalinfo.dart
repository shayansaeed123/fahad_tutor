import 'dart:convert';
import 'dart:typed_data';

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
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class AdditionalInfo extends StatefulWidget {
  const AdditionalInfo({super.key});

  @override
  State<AdditionalInfo> createState() => _AdditionalInfoState();
}

class _AdditionalInfoState extends State<AdditionalInfo> {
  bool isLoading = false;
  DateTime? selectedTime;
  late DateTime lastDate = DateTime(1970, 1, 1);
  late FocusNode _homeAddress;
  late FocusNode _furtherInfofocusNode;
  String? selectedCurrentTeaching;
  String? selectedTeachingExp;
  String? oLevel;
  String? aLevel;
  List<dynamic> newItemsAcademyExperience = [];
  List<dynamic> newItemsAcademyExperienceOnlie = [];
  TextEditingController home = TextEditingController();
  TextEditingController furtherInfo = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _furtherInfofocusNode = FocusNode();
    _furtherInfofocusNode.addListener(_onFocusChange);
     _homeAddress = FocusNode();
    _homeAddress.addListener(_onFocusChange);
    _biography.addListener(_updateCharCount);
    repository.check_msg();
    getValues();
    getAddtionalInfo();
    repository.fetchData('Languages_listing','Languages', newItemsLanguage, selectedIdsLanguage, updateSelectedNamesLanguage,(val)=> setState(() {isLoading = val;}));
    repository.fetchData('Experience_listing','Experience', newItemsAcademyExperience, [], (){},(val)=> setState(() {isLoading = val;}));
    repository.fetchData('Experience_listing','Experience', newItemsAcademyExperienceOnlie, [], (){},(val)=> setState(() {isLoading = val;}));
    saveLanguagesData();
  }

  void getValues()async{
    await getAddtionalInfo();
    setState(() {
      reusabletextfieldcontroller.addressCon.text = home_address;
      reusabletextfieldcontroller.furtherInfo.text = further_information;
       _biography.text = Biography;

      reusabletextfieldcontroller.addressCon.addListener(_updateTitle);
        reusabletextfieldcontroller.furtherInfo.addListener(_updateTitle);
        _biography.addListener(_updateTitle);
        if (date_of_birth.isNotEmpty) {selectedTime = DateTime.parse(date_of_birth);}
        checkbox1 = placement.any((p) => p['id'] == PlacementId1);
        checkbox2 = placement.any((p) => p['id'] == PlacementId2);
        checkbox3 = placement.any((p) => p['id'] == PlacementId3);
    // setState(() {
    //   selectedPlacement = placement.any((p) => p['id'] == PlacementId1)
    //       ? PlacementId1
    //       : placement.any((p) => p['id'] == PlacementId2)
    //           ? PlacementId2
    //           : PlacementId3;
    //   updateTutorPlacement(); // Update selected placements
    //   isHomeWidgetVisible = selectedPlacement == PlacementId2; // Adjust visibility based on selected placement
    // });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _furtherInfofocusNode.dispose();
    _furtherInfofocusNode.removeListener(_onFocusChange);
    _homeAddress.dispose();
    _homeAddress.removeListener(_onFocusChange);
    reusabletextfieldcontroller.addressCon.removeListener(_updateTitle);
    reusabletextfieldcontroller.furtherInfo.removeListener(_updateTitle);
    _biography.removeListener(_updateTitle);
    _biography.dispose();
  }
  void _onFocusChange() {
    setState(() {
    });
  }
  void _updateTitle() {
    if (mounted) {
      setState(() {
        home_address = reusabletextfieldcontroller.addressCon.text;
         further_information = reusabletextfieldcontroller.furtherInfo.text;
         Biography = _biography.text;
      });
    }
  }
  String _selectedValue = 'Tutor';
  String _selectedValue1 = '';
  String _selectedValue2 = '';
  bool isHomeWidgetVisible = false;
  String update_status = '';
  String source = '';
  bool visible = true;
  final TextEditingController _biography = TextEditingController();
  int _charCount = 0;
  List<dynamic> newItemsLanguage = [];
List<Map<String, String>> selectedIdsLanguage = [];
List<String> selectedNamesLanguage = [];
  TutorRepository repository = TutorRepository();

  void _updateCharCount() {
    setState(() {
      _charCount = _biography.text.length;
    });
  }

  List<String> selectedPlacements = [];
  List<dynamic> Placements = [];
  List<dynamic> placement = [];
  String home_address = '';
  String date_of_birth = '';
  String further_information = '';
  String currently_teaching = '';
  String Teaching_experience = '';
  String _oLevel = '';
  String _alevel = '';
  String onlineTeaching_experience = '';
  String Biography = '';
  String PlacementName1 = '';
  String PlacementName2 = '';
  String PlacementName3 = '';
  String PlacementId1 = '';
  String PlacementId2 = '';
  String PlacementId3 = '';
  // String? selectedPlacement; // This will store the selected placement ID

void updateTutorPlacement() {
  selectedPlacements.clear();
  if (checkbox1) selectedPlacements.add(PlacementId1);
  if (checkbox2) selectedPlacements.add(PlacementId2);
  if (checkbox3) selectedPlacements.add(PlacementId3);
}

 // Update the selected placements based on the radio button selection
  // void updateTutorPlacement() {
  //   selectedPlacements.clear();
  //   if (selectedPlacement == PlacementId1) selectedPlacements.add(PlacementId1);
  //   if (selectedPlacement == PlacementId2) selectedPlacements.add(PlacementId2);
  //   if (selectedPlacement == PlacementId3) selectedPlacements.add(PlacementId3);
  // }
  bool checkbox1 = false;
  bool checkbox2 = false;
  bool checkbox3 = false;

  void _validateForm() {
  bool isBiographyValid = !checkbox2 || (_biography.text.length >= 500 && _biography.text.length <= 800);

  if (
    isBiographyValid && reusabletextfieldcontroller.furtherInfo.text.isNotEmpty &&
    reusabletextfieldcontroller.addressCon.text.isNotEmpty
  ) {
    updateAdditionalInfo();
    // Navigator.push(context, MaterialPageRoute(builder: (context) => NavBar()));
  } else {
    Utils.snakbar(
      context,
      !isBiographyValid
          ? (_biography.text.length < 500
              ? 'Biography must be at least 500 characters'
              : 'Biography must not exceed 800 characters') :
              reusabletextfieldcontroller.furtherInfo.text.isEmpty
                            ? "Enter Further Information" :
                            reusabletextfieldcontroller.addressCon.text.isEmpty
                            ? "Enter Home Address" 
                                                                          : "Fill correct fields",
    );
  }
  }

  void toggleSelection(String id, String name, String itemType) {
  setState(() {
    List<Map<String, String>> selectedIds;
    List<String> selectedNames;
    List<dynamic> newItems;
    Function updateSelectedNames;

    switch (itemType) {
      case 'language_name':
        selectedIds = selectedIdsLanguage;
        selectedNames = selectedNamesLanguage;
        newItems = newItemsLanguage;
        updateSelectedNames = updateSelectedNamesLanguage;
        break;
      default:
        return;
    }

    if (selectedIds.any((element) => element['id'] == id)) {
      selectedIds.removeWhere((element) => element['id'] == id);
      selectedNames.remove(name);
    } else {
      // // Check length constraint only for 'names' and 'degree_title'
      // if (itemType == 'names' || itemType == 'degree_title') {
      //   if (selectedIds.length < 2) {
      //     selectedIds.add({'id': id});
      //     selectedNames.add(name);
      //   } else {
      //     Utils.snakbar(context, 'Select only 2');
      //   }
      // } else if (itemType == 'course_name') {
      //   if (selectedIds.length < 6) {
      //     selectedIds.add({'id': id});
      //     selectedNames.add(name);
      //   } else {
      //     Utils.snakbar(context, 'Select only 6');
      //   }
      // } else {
        selectedIds.add({'id': id});
        selectedNames.add(name);
      // }
    }

    updateSelectedNames();
  });
}

void updateSelectedNamesLanguage() {
  selectedNamesLanguage = selectedIdsLanguage.map((selected) {
    return (newItemsLanguage.firstWhere(
      (item) => item['id'] == selected['id'],
      orElse: () => {'language_name': 'Unknown'},
    )['language_name'] as String);
  }).toList();
  // print('Selected Group Names: $selectedNamesGroup');
}
Future<void> saveLanguagesData() async {
  try {
    final response = await http.get(
      Uri.parse('${MySharedPrefrence().get_baseUrl()}step_2.php?code=10&tutor_id=${MySharedPrefrence().get_user_ID()}'),
    );

    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

          selectedIdsLanguage = (jsonResponse['preferred_languages'] as List)
              .map<Map<String, String>>((item) => {'id': item['id'].toString()})
              .toList();
          
          updateSelectedNamesLanguage();
        // });
      } else {
        throw Exception('Empty response body');
      }
    } else {
      throw Exception('Failed to load country details');
    }
  } catch (e) {
    print('gfksgdf$e');
  }
}

  Future<void> updateAdditionalInfo() async {
  setState(() {
    isLoading = true;
  });
  try {
    List<Map<String, dynamic>> languages_id = selectedIdsLanguage.map((languages) {
        return {'preferred_languages_id': languages['id']};
      }).toList();
      String languagesjson = jsonEncode(languages_id);
    final bio = _biography.text.toString();
    final response = await http.post(
      Uri.parse('${MySharedPrefrence().get_baseUrl()}step_3_update.php'),
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
        'currently_teaching': selectedCurrentTeaching.toString(),
        'Teaching_ex': selectedTeachingExp.toString(),
        'DigitalPad': _selectedValue1.toString(),
        'onlineTeaching_experience': _selectedValue2.toString(),
        'online_Skill': '',
        'Biography': bio.toString(),
        'tutor_placement': jsonEncode(selectedPlacements),
        'source': '',
        'preferred_languages': languagesjson,
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
      Uri.parse('${MySharedPrefrence().get_baseUrl()}step_3.php?code=10&tutor_id=$userId')
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      // Assign values with null checks
      update_status = responseData['update_status'] ?? '';
      Placements = responseData['placement_listing'] ?? [];
      PlacementName1 = Placements.isNotEmpty ? Placements[0]['placement_name'] ?? '' : '';
      PlacementName2 = Placements.length > 1 ? Placements[1]['placement_name'] ?? '' : '';
      PlacementName3 = Placements.length > 2 ? Placements[2]['placement_name'] ?? '' : '';
      PlacementId1 = Placements.isNotEmpty ? Placements[0]['id'] ?? '' : '';
      PlacementId2 = Placements.length > 1 ? Placements[1]['id'] ?? '' : '';
      PlacementId3 = Placements.length > 2 ? Placements[2]['id'] ?? '' : '';

      // Handle placement selection logic
      setState(() {
        checkbox1 = placement.any((p) => p['id'] == PlacementId1);
        checkbox2 = placement.any((p) => p['id'] == PlacementId2);
        checkbox3 = placement.any((p) => p['id'] == PlacementId3);
        updateTutorPlacement(); // Ensure selectedPlacements is updated
        isHomeWidgetVisible = checkbox2; // Ensure this state is correctly set
        print('heloo $selectedPlacements');
      });

      // Assign other fields with null-safe operators
      home_address = responseData['home_address'] ?? '';
      further_information = responseData['further_information'] ?? '';
      onlineTeaching_experience = responseData['onlineTeaching_experience'] ?? '';
      
      setState(() {
        currently_teaching = responseData['currently_teaching'] ?? ''; // Default to an empty string
        selectedCurrentTeaching = currently_teaching.isEmpty ? null : currently_teaching;
        if (currently_teaching == '0') {
          selectedCurrentTeaching = 'No';
        } else {
          selectedCurrentTeaching = 'Yes';
        }
      });

      Teaching_experience = responseData['Teaching_experience'] ?? ''; // Default to an empty string
      selectedTeachingExp = Teaching_experience.isEmpty ? null : Teaching_experience;

      _oLevel = responseData['oLevel'] ?? ''; // Default to an empty string
      oLevel = _oLevel.isEmpty ? null : _oLevel;

      _alevel = responseData['alevel'] ?? ''; // Default to an empty string
      aLevel = _alevel.isEmpty ? null : _alevel;

      date_of_birth = responseData['date_of_birth'] ?? '';
      _selectedValue1 = responseData['DigitalPad'] ?? '0';
      _selectedValue2 = responseData['onlineTeaching_experience'] ?? '';
      Biography = responseData['Biography'] ?? '';
      placement = responseData['placements'] ?? [];
      
      print(placement);
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

// Future<void> getAddtionalInfo() async {
//   setState(() {
//     isLoading = true;
//   });
//   try {
//     final userId = MySharedPrefrence().get_user_ID().toString();
//     print('Fetching data for user ID: $userId');
//     final response = await http.get(
//       Uri.parse('${MySharedPrefrence().get_baseUrl()}step_3.php?code=10&tutor_id=$userId')
//     );
//     if (response.statusCode == 200) {
//       final Map<String, dynamic> responseData = json.decode(response.body);
//       update_status = responseData['update_status'];
//       Placements = responseData['placement_listing'];
//       PlacementName1 = Placements[0]['placement_name'];
//       PlacementName2 = Placements[1]['placement_name'];
//       PlacementName3 = Placements[2]['placement_name'];
//       PlacementId1 = Placements[0]['id'];
//       PlacementId2 = Placements[1]['id'];
//       PlacementId3 = Placements[2]['id'];
      

//       setState(() {
//           checkbox1 = placement.any((p) => p['id'] == PlacementId1);
//           checkbox2 = placement.any((p) => p['id'] == PlacementId2);
//           checkbox3 = placement.any((p) => p['id'] == PlacementId3);
//           updateTutorPlacement(); // Ensure selectedPlacements is updated
//           isHomeWidgetVisible = checkbox2; // Ensure this state is correctly set
//           print('heloo $selectedPlacements');
//         });
//       // print(responseData);
//       home_address = responseData['home_address'];
//       further_information = responseData['further_information'];
//       onlineTeaching_experience = responseData['onlineTeaching_experience'];
//       // currently_teaching = responseData['currently_teaching'];
//       setState(() {
//           currently_teaching = responseData['currently_teaching'] ?? ''; // Use empty string if null
//           selectedCurrentTeaching = currently_teaching.isEmpty ? null : currently_teaching;
//           print('Fetched currently_teaching: $selectedCurrentTeaching');
//           if(currently_teaching == '0'){
//             selectedCurrentTeaching = 'No';
//           }else{
//             selectedCurrentTeaching = 'Yes';
//           }
//         });
//       // Teaching_experience = responseData['Teaching_experience'];
//       Teaching_experience = responseData['Teaching_experience'] ?? ''; // Use empty string if null
//           selectedTeachingExp = Teaching_experience.isEmpty ? null : Teaching_experience;
//       // _oLevel = responseData['oLevel'];
//       _oLevel = responseData['oLevel'] ?? ''; // Use empty string if null
//           oLevel = _oLevel.isEmpty ? null : _oLevel;
//           _alevel = responseData['alevel'] ?? ''; // Use empty string if null
//           aLevel = _alevel.isEmpty ? null : _alevel;
//       // _alevel = responseData['alevel'];
//       date_of_birth = responseData['date_of_birth'] ?? '';
//       _selectedValue1 = responseData['DigitalPad'];
//       _selectedValue2 = responseData['onlineTeaching_experience'];
//       Biography = responseData['Biography'];
//       placement = responseData['placements'];
//       print(placement);
//     } else {
//       print('Error: ${response.statusCode}');
//     }
//   } catch (e) {
//     print('Get API Error: $e');
//   } finally {
//     setState(() {
//       isLoading = false;
//     });
//   }
// }

  @override
  Widget build(BuildContext context) {
    return reusableprofileidget(context,
      Padding(padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .032),
                  child: 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min, // Important!
                        children: [
                          reusableText("Additional\nInformation",color: colorController.blackColor,fontsize: 25,fontweight: FontWeight.bold),
                          reusablaSizaBox(context, 0.020),
                          ValueListenableBuilder(valueListenable: repository.popup, builder: (context, value, child) {
              if(value == 1){
                return reusableVisiblityMesage(context, MySharedPrefrence().get_popup_text(), (){setState(() {visible=false;});}, visible);
                }else{return Container();}},),
                reusablaSizaBox(context, 0.020),
                          reusableTextField(context,reusabletextfieldcontroller.addressCon, 'Home Address',_homeAddress.hasFocus
                                      ? colorController.blueColor
                                      : colorController
                                          .textfieldBorderColorBefore,
                                  _homeAddress,
                                  () {
                                    _homeAddress.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_furtherInfofocusNode);
                                  },),
                          reusablaSizaBox(context, 0.020),
                          reusableDateofBirthField(
                            context, lastDate, selectedTime, (DateTime timeofday){
                             setState(() {
                                            selectedTime = timeofday;
                                            print('time date $selectedTime');
                                          });
                          },
                          SizedBox.shrink(),
                          ),
                          reusablaSizaBox(context, 0.020),
                          reusableTextField(context,reusabletextfieldcontroller.furtherInfo, 'Further Information', _furtherInfofocusNode.hasFocus
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
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //   children: [
                                      // Flexible(child: 
                                      reusableDropdownAdditional(context,
                                  //     selectedCurrentTeaching, (String? newValue){
                                  //   setState(() {
                                  //           selectedCurrentTeaching = newValue;
                                  //           print('Current teaching $selectedCurrentTeaching');
                                  //         });
                                  // },
                                  selectedCurrentTeaching,
          (String? newValue) {
            setState(() {
              selectedCurrentTeaching = newValue;

                // Set currently_teaching to 1 or 0 based on the selected value
      if (newValue == 'Yes') {
        selectedCurrentTeaching = '1'; // Store '1' for Yes
      } else if (newValue == 'No') {
        selectedCurrentTeaching = '0'; // Store '0' for No
      } else {
        selectedCurrentTeaching = ''; // Handle empty or invalid selection
      }
              // Update currently_teaching if necessary
              currently_teaching = newValue ?? ''; // Update to 'null' if no value is selected
              print('Updated selectedCurrentTeaching: $selectedCurrentTeaching');
                print('Updated currently_teaching: $currently_teaching');
            });
          },
                                  'Currently Teaching', ['Yes','No']),
                                  // ),
                                  // SizedBox(height: MediaQuery.of(context).size.width * 0.04,),
                                  // Flexible(child: reusableDropdownAdditional(context,selectedTeachingExp, (String? newValue){
                                  //   setState(() {
                                  //           selectedTeachingExp = newValue;
                                  //           print('teaching experience $selectedTeachingExp');
                                  //         });
                                  // },'Teaching Experience', ['1-2 years','2-3 years','5+ years']),),
                                  //   ],
                                  // ),
                                  reusablaSizaBox(context, 0.020),
                                  reusableExperienceDropdown(selectedTeachingExp, newItemsAcademyExperience, (val){selectedTeachingExp = val;}, 'Academy Physical Experience'),
                                  reusablaSizaBox(context, 0.020),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(child: reusableDropdownAdditional(context, oLevel, (String? newValue){
                                    setState(() {
                                            oLevel = newValue;
                                            print('O-Level Qualified  $oLevel');
                                          });
                                  }, 'O-Level Qualified', ['Yes','No']),),
                                  SizedBox(height: MediaQuery.of(context).size.width * 0.04,),
                                  Flexible(child: reusableDropdownAdditional(context, aLevel, (String? newValue){
                                    setState(() {
                                            aLevel = newValue;
                                            print('A-Level Qualified $aLevel');
                                          });
                                  },'A-Level Qualified', ['Yes','No']))
                                    ],
                                  ),
                                  reusablaSizaBox(context, 0.020),
                  reusablequlification(context, 'Speak Languages', () {
                   repository.search(context, newItemsLanguage, selectedIdsLanguage, 'language_name',toggleSelection);
                  }),
                  reusablaSizaBox(context, .020),
                  Container(
                    constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.3),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: selectedNamesLanguage.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .012),
                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .05, vertical: MediaQuery.of(context).size.height * .01),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: colorController.qualificationItemsColors,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  selectedNamesLanguage[index],
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 13, color: colorController.whiteColor),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    // Remove the selected item from the list
                                    selectedIdsLanguage.removeAt(index);
                                    selectedNamesLanguage.removeAt(index);
                                    // updateSelectedNames(); // Update the names here
                                    print('idddddddddddddd $selectedIdsLanguage');
                                  });
                                },
                                child: Icon(Icons.cancel_outlined, color: colorController.whiteColor,size: MediaQuery.of(context).size.width*.050,),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                                  reusablaSizaBox(context, .020),
                                  reusableText('Tutors Placment', fontsize: 21),
                                Row(
                                  mainAxisAlignment: MySharedPrefrence().get_city_id() == '1' || MySharedPrefrence().get_city_id() == '2' || 
                                    MySharedPrefrence().get_city_id() == '3' || MySharedPrefrence().get_city_id() == '4' ? MainAxisAlignment.spaceEvenly :
                                      MainAxisAlignment.center,
                                  children: [
                                       MySharedPrefrence().get_city_id() == '1' || MySharedPrefrence().get_city_id() == '2'
                                       || MySharedPrefrence().get_city_id() == '3' || MySharedPrefrence().get_city_id() == '4' ?
                                       buildCheckboxWithTitle('Home', checkbox1,(){
                                      setState(() {});
                                      reusableMessagedialog(context, 'Placement',
                    "You will have to visit at student's place", 'Confirm', 'Cancel',() {
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
                                    }) : SizedBox.shrink(),
                                    buildCheckboxWithTitle('Online', checkbox2,(){
                                      setState(() { 
                                        checkbox2 = !checkbox2;
                                        updateTutorPlacement();
                                        isHomeWidgetVisible = checkbox2; // Update visibility state
                                        print(selectedPlacements);
                                      });
                                    },),

        //         buildRadioWithTitle('Home', PlacementId1, (newValue) {
        //   setState(() {
        //     selectedPlacement = newValue as String?;
        //     updateTutorPlacement();
        //     isHomeWidgetVisible = selectedPlacement == PlacementId2; // Update visibility if needed
        //     print(selectedPlacements);
        //   });
        // }),
        // buildRadioWithTitle('Online', PlacementId2, (newValue) {
        //   setState(() {
        //     selectedPlacement = newValue as String?;
        //     updateTutorPlacement();
        //     isHomeWidgetVisible = selectedPlacement == PlacementId2;
        //     print(selectedPlacements);
        //   });
        // }),
                                  ],
                                ),
                                MySharedPrefrence().get_city_id() == '1' || MySharedPrefrence().get_city_id() == '2'
                                || MySharedPrefrence().get_city_id() == '3' || MySharedPrefrence().get_city_id() == '4' ?
                                buildCheckboxWithTitle(
                                    "At Tutor's Place", checkbox3, (){
                                      setState(() {
                                        checkbox3 = !checkbox3;
                                        updateTutorPlacement();
                                        print(selectedPlacements);
                                      });
                                    },) : SizedBox.shrink(),

        //                          buildRadioWithTitle("At Tutor's Place", PlacementId3, (newValue) {
        //   setState(() {
        //     selectedPlacement = newValue as String?;
        //     updateTutorPlacement();
        //     isHomeWidgetVisible = selectedPlacement == PlacementId2;
        //     print(selectedPlacements);
        //   });
        // }),
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
                                  // _selectedValue1,
                                  _selectedValue2,
                                  newItemsAcademyExperienceOnlie,
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
                                  // updateAdditionalInfo();
                                  _validateForm();
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
            ontap();
            // setState(() {
            //   if (title == 'Home') {
            //     checkbox1 = newValue ?? false;
            //     ontap();
            //   } else if (title == 'Online') {
            //     checkbox2 = value ?? false;
            //     if (value == true) {
            //       isHomeWidgetVisible = true;
            //       updateTutorPlacement();
            //        print(selectedPlacements);
            //     } else {
            //       updateTutorPlacement();
            //        print(selectedPlacements);
            //       isHomeWidgetVisible = false;
            //     }
            //   } else if (title == "At Tutor's Place") {
            //     checkbox3 = value ?? false;
            //     updateTutorPlacement();
            //      print(selectedPlacements);
            //   }
            // });
          },
        ),
        reusableText(title, fontsize: 15),
      ],
    );
  }
// // Function to create radio buttons with titles
//   Widget buildRadioWithTitle(String title, String value, Function onChanged) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Radio<String>(
//           value: value,
//           groupValue: selectedPlacement,
//           onChanged: (newValue) {
//             onChanged(newValue);
//           },
//           fillColor: MaterialStateColor.resolveWith(
//                               (states) => colorController.blueColor),
//               // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//             // visualDensity: VisualDensity.compact,
//             activeColor: MaterialStateColor.resolveWith(
//                               (states) => colorController.blueColor),
//         ),
//         Text(title),
//       ],
//     );
//   }
}