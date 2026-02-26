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
  DateTime? selectedCnicDate;
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
//   List<dynamic> newItemsExperience = [];
// List<dynamic> newItemsExperiencePhysical = [];
// String? selectedQuranExperiencePhysical;
// String? _rawQuranExperience; // ← jo API se aaye
// String? get selectedQuranExperience {
//   final valid = newItemsExperience
//       .map((e) => e['Experience_name'].toString())
//       .toSet();

//   return valid.contains(_rawQuranExperience) ? _rawQuranExperience : 'None';
// }
String? Zoom;
String? client;
List<Map<String, dynamic>> segments = [];
Set<String> selectedSegmentIds = {};
List<Map<String, String>> selectedSegmentMapList = [];
// String? laptop = '';
// List<dynamic> newItemsTime = [];
// List<Map<String, String>> selectedIdsTime = [];
// List<String> selectedNamesTime = [];
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
    // repository.fetchData('Languages_listing','Languages', newItemsLanguage, selectedIdsLanguage, updateSelectedNamesLanguage,(val)=> setState(() {isLoading = val;}));
    repository.fetchData('Experience_listing','Experience', newItemsAcademyExperience, [], (){},(val)=> setState(() {isLoading = val;}));
    repository.fetchData('Experience_listing','Experience', newItemsAcademyExperienceOnlie, [], (){},(val)=> setState(() {isLoading = val;}));
    // repository.fetchData('Preferred_Time','Preferred_Time', newItemsTime, selectedIdsTime, updateSelectedNamesTime,(val)=> setState(() {isLoading = val;}));
    // saveLanguagesData();
    fetchSegmentData();
  }
  Future<void> fetchSegmentData() async {
  String url = '${Utils.baseUrl}all_in.php?Segment_listing=1';
      final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final List<dynamic> listing = data['Segment_listing'];
    setState(() {
      segments = List<Map<String, dynamic>>.from(listing);
    });
  }
}

//   void updateSelectedNamesTime() {
//   selectedNamesTime = selectedIdsTime.map((selected) {
//     return (newItemsTime.firstWhere(
//       (item) => item['id'] == selected['id'],
//       orElse: () => {'name': 'Unknown'},
//     )['name'] as String);
//   }).toList();
//   // print('Selected Group Names: $selectedNamesGroup');
// }

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
        if (cnic_date.isNotEmpty) {selectedCnicDate = DateTime.parse(cnic_date);}
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
  String? _selectedValue1;
  String? _selectedValue2;
  bool isHomeWidgetVisible = true;
  String update_status = '';
  String source = '';
  bool visible = true;
  final TextEditingController _biography = TextEditingController();
  int _charCount = 0;
//   List<dynamic> newItemsLanguage = [];
// List<Map<String, String>> selectedIdsLanguage = [];
// List<String> selectedNamesLanguage = [];
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
  String cnic_date = '';
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

void updateTutorSegments() {
  selectedSegmentMapList = selectedSegmentIds.map((id) => {"id": id}).toList();
  print("Formatted Segment List: $selectedSegmentMapList");
}

  void updateTutorPlacement() {
  selectedPlacements.clear();
  if (checkbox1) selectedPlacements.add('1');
  if (checkbox2) selectedPlacements.add('2');
  if (checkbox3) selectedPlacements.add("3");
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
  // bool isBiographyValid = !checkbox2 || (_biography.text.length >= 500 && _biography.text.length <= 800);
  bool isBiographyValid = _biography.text.length >= 500 && _biography.text.length <= 800;

  bool isValidField(String? value) {
    return value != null && value.isNotEmpty && value != "0" && value.toLowerCase() != "null" && value != 'Select Experience';
  }

  if (
    reusabletextfieldcontroller.furtherInfo.text.isNotEmpty &&
    reusabletextfieldcontroller.addressCon.text.isNotEmpty &&
    selectedSegmentIds.isNotEmpty &&
    isValidField(client) &&
    isValidField(Zoom) &&
    _selectedValue1 != null &&
    _selectedValue2 != null &&
    isValidField(selectedTeachingExp) &&
    isValidField(oLevel) &&
    isValidField(aLevel) &&
    // selectedIdsLanguage.isNotEmpty &&
    selectedPlacements.isNotEmpty && 
    isBiographyValid
  ) {
    updateAdditionalInfo();
  } else {
    Utils.snakbar(
      context,
      reusabletextfieldcontroller.furtherInfo.text.isEmpty
        ? "Enter Further Information"
        : reusabletextfieldcontroller.addressCon.text.isEmpty
          ? "Enter Home Address"
          : selectedSegmentIds.isEmpty 
            ? "Select at least one segment"
            : selectedPlacements.isEmpty 
            ? "Select at least one Placment"
            : !isValidField(client)
              ? "Select International client"
              : !isValidField(Zoom)
                ? "Select Zoom proficiency"
                : _selectedValue1 == null 
                  ? "Select Digital pad"
                  : _selectedValue2 == null 
                    ? "Select Online Teaching Experience"
                      : !isValidField(selectedTeachingExp)
                        ? "Select Teaching Experience"
                        : !isValidField(oLevel)
                          ? "Select O-Level Qualification"
                          : !isValidField(aLevel)
                            ? "Select A-Level Qualification"
                            // : selectedIdsLanguage.isEmpty
                            //   ? "Select at least one language"
                              : !isBiographyValid
                                ? (_biography.text.length < 500
                                    ? 'Biography must be at least 500 characters'
                                    : 'Biography must not exceed 800 characters')
                                : "Fill all required fields",
    );
  }
  }

  void toggleSelection(String id, String name, String itemType) {
  setState(() {
    List<Map<String, String>> selectedIds;
    List<String> selectedNames;
    List<dynamic> newItems;
    Function updateSelectedNames;

    // switch (itemType) {
    //   case 'language_name':
    //     selectedIds = selectedIdsLanguage;
    //     selectedNames = selectedNamesLanguage;
    //     newItems = newItemsLanguage;
    //     updateSelectedNames = updateSelectedNamesLanguage;
    //     break;
    //   // case 'name':
    //   //   selectedIds = selectedIdsTime;
    //   //   selectedNames = selectedNamesTime;
    //   //   newItems = newItemsTime;
    //   //   updateSelectedNames = updateSelectedNamesTime;
    //   //   break;
    //   default:
    //     return;
    // }

    // if (selectedIds.any((element) => element['id'] == id)) {
    //   selectedIds.removeWhere((element) => element['id'] == id);
    //   selectedNames.remove(name);
    // } else {
    //   // // Check length constraint only for 'names' and 'degree_title'
    //   // if (itemType == 'names' || itemType == 'degree_title') {
    //   //   if (selectedIds.length < 2) {
    //   //     selectedIds.add({'id': id});
    //   //     selectedNames.add(name);
    //   //   } else {
    //   //     Utils.snakbar(context, 'Select only 2');
    //   //   }
    //   // } else if (itemType == 'course_name') {
    //   //   if (selectedIds.length < 6) {
    //   //     selectedIds.add({'id': id});
    //   //     selectedNames.add(name);
    //   //   } else {
    //   //     Utils.snakbar(context, 'Select only 6');
    //   //   }
    //   // } else {
    //     selectedIds.add({'id': id});
    //     selectedNames.add(name);
    //   // }
    // }

    // updateSelectedNames();
  });
}

// void updateSelectedNamesLanguage() {
//   selectedNamesLanguage = selectedIdsLanguage.map((selected) {
//     return (newItemsLanguage.firstWhere(
//       (item) => item['id'] == selected['id'],
//       orElse: () => {'language_name': 'Unknown'},
//     )['language_name'] as String);
//   }).toList();
//   // print('Selected Group Names: $selectedNamesGroup');
// }



// Future<void> saveLanguagesData() async {
//   try {
//     final response = await http.get(
//       Uri.parse('${Utils.baseUrl}step_2.php?code=10&tutor_id=${MySharedPrefrence().get_user_ID()}'),
//     );

//     if (response.statusCode == 200) {
//       if (response.body.isNotEmpty) {
//         final Map<String, dynamic> jsonResponse = json.decode(response.body);

//           selectedIdsLanguage = (jsonResponse['preferred_languages'] as List)
//               .map<Map<String, String>>((item) => {'id': item['id'].toString()})
//               .toList();
//           // selectedIdsTime = (jsonResponse['preferred_time_query'] as List)
//           //     .map<Map<String, String>>((item) => {'id': item['id'].toString()})
//           //     .toList();
          
//           updateSelectedNamesLanguage();
//           // updateSelectedNamesTime();
//         // });
//       } else {
//         throw Exception('Empty response body');
//       }
//     } else {
//       throw Exception('Failed to load country details');
//     }
//   } catch (e) {
//     print('gfksgdf$e');
//   }
// }

  Future<void> updateAdditionalInfo() async {
  setState(() {
    isLoading = true;
  });
  try {
    // List<Map<String, dynamic>> languages_id = selectedIdsLanguage.map((languages) {
    //     return {'preferred_languages_id': languages['id']};
    //   }).toList();
    //   String languagesjson = jsonEncode(languages_id);


      // List<Map<String, dynamic>> preferred_time_query = selectedIdsTime.map((time) {
      //   return {'Preferred_Time_id': time['id']};
      // }).toList();
      // String preferredTimejson = jsonEncode(preferred_time_query);
    final bio = _biography.text.toString();
    final response = await http.post(
      Uri.parse('${Utils.baseUrl}step_3_update.php'),
      body: {
        'code': '10',
        'success' : 1.toString(),
        'tutor_id': MySharedPrefrence().get_user_ID().toString(),
        'update_status': update_status.toString(),
        'home_address': reusabletextfieldcontroller.addressCon.text.toString(),
        'further_info': reusabletextfieldcontroller.furtherInfo.text.toString(),
        'date_of_birth': selectedTime.toString(),
        'Cnic_date': selectedCnicDate.toString(),
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
        // 'preferred_languages': languagesjson,
        'Zoom_Proficiency': Zoom.toString(),
        'International_client': client.toString(),
        'Segment_Tutors': jsonEncode(selectedSegmentMapList),
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
      Uri.parse('${Utils.baseUrl}step_3.php?code=10&tutor_id=$userId')
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
      cnic_date = responseData['Cnic_date'] ?? '';
      _selectedValue1 = responseData['DigitalPad'] ?? '0';
      _selectedValue2 = responseData['onlineTeaching_experience'] ?? '';
      Biography = responseData['Biography'] ?? '';
      placement = responseData['placements'] ?? [];
      Zoom = responseData['Zoom_Proficiency'] ?? [];
      client = responseData['International_client'] ?? [];
      // Remove duplicates using Set
      final savedSegments = List<Map<String, dynamic>>.from(responseData['Segment_Tutors'] ?? []);
      selectedSegmentIds = savedSegments.map((seg) => seg['id'].toString()).toSet();
      updateTutorSegments();
      print(savedSegments);
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
//       Uri.parse('${Utils.baseUrl}step_3.php?code=10&tutor_id=$userId')
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
                          SizedBox.shrink(),'Date of Birth'
                          ),
                          reusablaSizaBox(context, 0.020),
                          reusableDateofBirthField(
                            context, lastDate, selectedCnicDate, (DateTime timeofday){
                             setState(() {
                                            selectedCnicDate = timeofday;
                                            print('Cnic date $selectedCnicDate');
                                          });
                          },
                          SizedBox.shrink(),'Cnic Issue Date'
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
                  //                 reusablaSizaBox(context, 0.020),
                  // reusablequlification(context, 'Can Speak Languages', () {
                  //  repository.search(context, newItemsLanguage, selectedIdsLanguage, 'language_name',toggleSelection);
                  // }),
                  // reusablaSizaBox(context, .020),
                  // Container(
                  //   constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.3),
                  //   child: ListView.builder(
                  //     shrinkWrap: true,
                  //     physics: NeverScrollableScrollPhysics(),
                  //     itemCount: selectedNamesLanguage.length,
                  //     itemBuilder: (context, index) {
                  //       return Container(
                  //         margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .012),
                  //         padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .05, vertical: MediaQuery.of(context).size.height * .01),
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(15),
                  //           color: colorController.qualificationItemsColors,
                  //         ),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Expanded(
                  //               child: Text(
                  //                 selectedNamesLanguage[index],
                  //                 softWrap: true,
                  //                 overflow: TextOverflow.ellipsis,
                  //                 maxLines: 1,
                  //                 style: TextStyle(fontSize: 13, color: colorController.whiteColor),
                  //               ),
                  //             ),
                  //             InkWell(
                  //               onTap: () {
                  //                 setState(() {
                  //                   // Remove the selected item from the list
                  //                   selectedIdsLanguage.removeAt(index);
                  //                   selectedNamesLanguage.removeAt(index);
                  //                   // updateSelectedNames(); // Update the names here
                  //                   print('idddddddddddddd $selectedIdsLanguage');
                  //                 });
                  //               },
                  //               child: Icon(Icons.cancel_outlined, color: colorController.whiteColor,size: MediaQuery.of(context).size.width*.050,),
                  //             ),
                  //           ],
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                
                  Column(
    children: [
      reusablaSizaBox(context, 0.020),
      reusableText('For which segment do you want to get Register', fontsize: 19),
      Wrap(
        spacing: 12,
        children: segments.map((segment) {
          final name = segment['name'];
          final id = segment['id'];
          final isSelected = selectedSegmentIds.contains(id);
          print('hfhksdgk $id');

          return buildCheckboxWithTitle(
            name,
            isSelected,
            () {
              setState(() {
                if (isSelected) {
                  selectedSegmentIds.remove(id);
                } else {
                  selectedSegmentIds.add(id);
                }
                updateTutorSegments();
              });
            },
          );
        }).toList(),
      ),
    ],
  ),

                                  reusablaSizaBox(context, .020),
                                  reusableText('Tutors Placment', fontsize: 19),
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
                                Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // reusablaSizaBox(context, .020),
                  // reusablequlification(context, 'Preferred Time', () {
                  //   repository.search(context, newItemsTime, selectedIdsTime, 'name',toggleSelection);
                  // }),
                  // reusablaSizaBox(context, .020),
                  // Container(
                  //   constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.3),
                  //   child: ListView.builder(
                  //     shrinkWrap: true,
                  //     physics: NeverScrollableScrollPhysics(),
                  //     itemCount: selectedNamesTime.length,
                  //     itemBuilder: (context, index) {
                  //       return Container(
                  //         margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .012),
                  //         padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .05, vertical: MediaQuery.of(context).size.height * .01),
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(15),
                  //           color: colorController.qualificationItemsColors,
                  //         ),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Expanded(
                  //               child: Text(
                  //                 selectedNamesTime[index],
                  //                 softWrap: true,
                  //                 overflow: TextOverflow.ellipsis,
                  //                 maxLines: 1,
                  //                 style: TextStyle(fontSize: 13, color: colorController.whiteColor),
                  //               ),
                  //             ),
                  //             InkWell(
                  //               onTap: () {
                  //                 setState(() {
                  //                   // Remove the selected item from the list
                  //                   selectedNamesTime.removeAt(index);
                  //                   selectedNamesTime.removeAt(index);
                  //                   // updateSelectedNames(); // Update the names here
                  //                   print('idddddddddddddd $selectedNamesTime');
                  //                 });
                  //               },
                  //               child: Icon(Icons.cancel_outlined, color: colorController.whiteColor,size: MediaQuery.of(context).size.width*.050,),
                  //             ),
                  //           ],
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                  // reusablaSizaBox(context, .02),
                  // reusableExperienceDropdown(selectedQuranExperience!, newItemsExperience, (value){
                  //   setState(() {});
                  //   _rawQuranExperience = value;
                  // },'Online Teaching Experience '),
                  // reusablaSizaBox(context, .02),
                  // reusableExperienceDropdown(selectedQuranExperiencePhysical!, newItemsExperiencePhysical, (value){
                  //   setState(() {});
                  //   selectedQuranExperiencePhysical = value;
                  //   print(selectedQuranExperiencePhysical);
                  // },'Physical Teaching Experience '),
                  reusableText('Have you ever taught international client?',color: colorController.grayTextColor,fontsize: 17.0),
                  reusablaSizaBox(context, .01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: buildRadioButton('Yes', 'yes',client,(String? newValue){setState(() {client = newValue;});},)),
                      Expanded(child: buildRadioButton('No','no',client,(String? newValue){setState((){client = newValue;});})),
                    ],
                  ),           
                  reusablaSizaBox(context, .02),
                  reusableText('Zoom Proficiency',color: colorController.grayTextColor,fontsize: 17.0),
                  reusablaSizaBox(context, .01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: buildRadioButton('Beginner', 'Beginner',Zoom,(String? newValue){setState(() {Zoom = newValue;});},)),
                      Expanded(child: buildRadioButton('Intermediate','Intermediate',Zoom,(String? newValue){setState((){Zoom = newValue;});})),
                      Expanded(child: buildRadioButton('Advance','Advance',Zoom,(String? newValue){setState((){Zoom = newValue;});})),
                    ],
                  ),
                  reusablaSizaBox(context, .02),
                  // reusableText('Do you have a laptop',color: colorController.blackColor,fontsize: 17.0),
                  // reusablaSizaBox(context, .01),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Expanded(child: buildRadioButton('Yes', 'yes',laptop,(String? newValue){setState(() {laptop = newValue;});},)),
                  //     Expanded(child: buildRadioButton('No','no',laptop,(String? newValue){setState((){laptop = newValue;});})),
                  //   ],
                  // ),
                ],
              ),
                                onlineVisibility(
                                  context,
                                  // isHomeWidgetVisible,
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