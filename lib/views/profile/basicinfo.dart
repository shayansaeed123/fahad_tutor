import 'dart:convert';
import 'dart:typed_data';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/controller/repo_provider.dart';
import 'package:fahad_tutor/controller/text_field_controller.dart';
import 'package:fahad_tutor/database/my_shared.dart';
import 'package:fahad_tutor/model/documentmodel.dart';
import 'package:fahad_tutor/repo/tutor_repo.dart';
import 'package:fahad_tutor/repo/utils.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusableTextField.dart';
import 'package:fahad_tutor/res/reusablebottomsheet.dart';
import 'package:fahad_tutor/res/reusablebtn.dart';
import 'package:fahad_tutor/res/reusabledocuments.dart';
import 'package:fahad_tutor/res/reusableloading.dart';
import 'package:fahad_tutor/res/reusableprofilewidget.dart';
import 'package:fahad_tutor/res/reusableradiobtn.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:fahad_tutor/res/reusablevisibility.dart';
import 'package:fahad_tutor/views/profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class BasicInfo extends ConsumerStatefulWidget {
  const BasicInfo({super.key});

  @override
  ConsumerState<BasicInfo> createState() => _BasicInfoState();
}

class _BasicInfoState extends ConsumerState<BasicInfo> {
  late TutorRepository repository;
  bool isLoading = false;
  DateTime? selectedTime;
  DateTime? selectedCnicDate;
  late DateTime lastDate = DateTime(1970, 1, 1);
  late FocusNode _gender;
  late FocusNode _mStatus;
  late FocusNode _email;
  late FocusNode _cnic;
  String? selectedCurrentTeaching;
  String? selectedTeachingExp;
  String? oLevel;
  String? aLevel;
  List<dynamic> newItemsAcademyExperience = [];
  List<dynamic> newItemsAcademyExperienceOnlie = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    repository = ref.read(tutorRepositoryProvider);
    _email = FocusNode();
    _email.addListener(_onFocusChange);
     _gender = FocusNode();
    _gender.addListener(_onFocusChange);
     _cnic = FocusNode();
    _cnic.addListener(_onFocusChange);
    _mStatus = FocusNode();
    _mStatus.addListener(_onFocusChange);
    repository.check_msg();
    getValues();
    getAddtionalInfo();
  }

  void getValues()async{
    await selectCity();
    await getAddtionalInfo();
    setState(() {
      // reusabletextfieldcontroller.gender.text = gender;
      // reusabletextfieldcontroller.cnic.text = cnic;
      // reusabletextfieldcontroller.email.text = email;
      reusabletextfieldcontroller.mStatus.text = mStatus;
      //  _biography.text = Biography;

      reusabletextfieldcontroller.gender.addListener(_updateTitle);
        reusabletextfieldcontroller.cnic.addListener(_updateTitle);
        reusabletextfieldcontroller.email.addListener(_updateTitle);
        reusabletextfieldcontroller.mStatus.addListener(_updateTitle);
        // _biography.addListener(_updateTitle);
        if (date_of_birth.isNotEmpty) {selectedTime = DateTime.parse(date_of_birth);}
        if (cnic_date.isNotEmpty) {selectedCnicDate = DateTime.parse(cnic_date);}
        checkbox1 = placement.any((p) => p['id'] == PlacementId1);
        checkbox2 = placement.any((p) => p['id'] == PlacementId2);
        checkbox3 = placement.any((p) => p['id'] == PlacementId3);
 
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _email.dispose();
    _email.removeListener(_onFocusChange);
    _gender.dispose();
    _gender.removeListener(_onFocusChange);
    _cnic.dispose();
    _cnic.removeListener(_onFocusChange);
    reusabletextfieldcontroller.gender.removeListener(_updateTitle);
    reusabletextfieldcontroller.cnic.removeListener(_updateTitle);
    reusabletextfieldcontroller.email.removeListener(_updateTitle);
    // _biography.removeListener(_updateTitle);
    // _biography.dispose();
  }
  void _onFocusChange() {
    setState(() {
    });
  }
  void _updateTitle() {
    if (mounted) {
      setState(() {
        // cnic = reusabletextfieldcontroller.cnic.text;
        //  gender = reusabletextfieldcontroller.gender.text;
        //  email = reusabletextfieldcontroller.email.text;
         mStatus = reusabletextfieldcontroller.mStatus.text;
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

  List<String> selectedPlacements = [];
  List<dynamic> Placements = [];
  List<dynamic> placement = [];
  // String gender = '';
  // String email ="";
  // String cnic ="";
  String mStatus ="";
  String date_of_birth = '';
  List<dynamic> cityList = [];
  dynamic cityLists;
  String cityName = '';
  String cityId = '';
  String cnic_date = '';
  bool isCityDropdownEnabled = true;
  String PlacementName1 = '';
  String PlacementName2 = '';
  String PlacementName3 = '';
  String PlacementId1 = '';
  String PlacementId2 = '';
  String PlacementId3 = '';
  // String? selectedPlacement; // This will store the selected placement ID



  void updateTutorPlacement() {
  selectedPlacements.clear();
  if (checkbox1) selectedPlacements.add('1');
  if (checkbox2) selectedPlacements.add('2');
  if (checkbox3) selectedPlacements.add("3");
}

  bool checkbox1 = false;
  bool checkbox2 = false;
  bool checkbox3 = false;

  void _validateForm() {
  // bool isBiographyValid = _biography.text.length >= 500 && _biography.text.length <= 800;

  bool isValidField(String? value) {
    return value != null && value.isNotEmpty && value != "0" && value.toLowerCase() != "null" && value != 'Select Experience';
  }

  if (
    reusabletextfieldcontroller.furtherInfo.text.isNotEmpty &&
    reusabletextfieldcontroller.addressCon.text.isNotEmpty &&
    // isValidField(client) &&
    // isValidField(Zoom) &&
    _selectedValue1 != null &&
    _selectedValue2 != null &&
    isValidField(selectedTeachingExp) &&
    isValidField(oLevel) &&
    isValidField(aLevel) &&
    selectedPlacements.isNotEmpty 
    // && isBiographyValid
  ) {
    updateAdditionalInfo();
  } else {
    Utils.snakbar(
      context,
      reusabletextfieldcontroller.furtherInfo.text.isEmpty
        ? "Enter Further Information"
        : reusabletextfieldcontroller.addressCon.text.isEmpty
          ? "Enter Home Address"
            : selectedPlacements.isEmpty 
            ? "Select at least one Placment"
            // : !isValidField(client)
            //   ? "Select International client"
            //   : !isValidField(Zoom)
            //     ? "Select Zoom proficiency"
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
                              // : !isBiographyValid
                              //   ? (_biography.text.length < 500
                              //       ? 'Biography must be at least 500 characters'
                              //       : 'Biography must not exceed 800 characters')
                                : "Fill all required fields",
    );
  }
  }

  

Future<void> selectCity() async {
    setState(() {
      isLoading = true;
    });
    try {
      
      final response = await http.post(
          Uri.parse('${Utils.baseUrl}city.php'),
          body: {
            'code': '10',
            'country_id': '1',
          });
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final Map<String, dynamic> jsonResponse = json.decode(response.body);
          cityList = jsonResponse['city_listing'];
          if (cityList.isNotEmpty) {
            setState(() {
              cityName = cityList[0]['c_name'];
              // countryId = countryList[0]['c_id'];
              print(cityName);
            });
          } else {
            throw Exception('City list is empty');
          }
        } else {
          throw Exception('Empty response body');
        }
        setState(() {
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load country details');
      }
    } catch (e) {
      print(' $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }



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

    // final bio = _biography.text.toString();
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
        // 'Biography': bio.toString(),
        'tutor_placement': jsonEncode(selectedPlacements),
        'source': '',
      }
    );
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
      Uri.parse('${Utils.baseUrl}basic_select.php?code=10&tutor_id=$userId')
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

      reusabletextfieldcontroller.email.text = responseData['email'] ?? '';
      reusabletextfieldcontroller.gender.text = responseData['gender'] ?? '';
      reusabletextfieldcontroller.cnic.text = responseData['cnic'] ?? '';
      mStatus = responseData['married_status'] ?? '';
      reusabletextfieldcontroller.name.text = responseData['teacher_name'] ?? '';
      reusabletextfieldcontroller.country.text = responseData['coutry_name'] ?? '';
      reusabletextfieldcontroller.father.text = responseData['father_name'] ?? '';
      reusabletextfieldcontroller.numbr.text = responseData['contact_number'] ?? '';
      reusabletextfieldcontroller.altnumbr.text = responseData['alternate_number'] ?? '';

      date_of_birth = responseData['date_of_birth'] ?? '';
      placement = responseData['placements'] ?? [];

      repository.cnic_b.value = responseData['cnic_back'] ?? '';
      repository.cnic_f.value = responseData['cnic_front'] ?? '';

      String savedCityId = responseData['city_id']?.toString() ?? '';

      if (savedCityId.isNotEmpty && cityList.isNotEmpty) {
          cityLists = cityList.firstWhere(
            (city) => city['c_id'].toString() == savedCityId,
            orElse: () => null,
          );
      }

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
    final state = ref.watch(documentsAttachProvider);
    final controller = ref.read(documentsAttachProvider.notifier);
    return reusableprofileidget(context,
      Padding(padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .032),
                  child: 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min, // Important!
                        children: [
                          reusableText("Basic\nInformation",color: colorController.blackColor,fontsize: 25,fontweight: FontWeight.bold),
                          reusablaSizaBox(context, 0.020),
                          ValueListenableBuilder(valueListenable: repository.popup, builder: (context, value, child) {
              if(value == 1){
                return reusableVisiblityMesage(context, MySharedPrefrence().get_popup_text(), (){setState(() {visible=false;});}, visible);
                }else{return Container();}},),
                reusablaSizaBox(context, 0.020),
                reusableReadOnlyTextField(context, reusabletextfieldcontroller.name, 'Name', colorController.blueColor),
                          reusablaSizaBox(context, 0.020),
                reusableReadOnlyTextField(context, reusabletextfieldcontroller.country, 'Country', colorController.blueColor),
                          reusablaSizaBox(context, 0.020),
                reusableReadOnlyTextField(context, reusabletextfieldcontroller.gender, 'Gender', colorController.blueColor),
                // reusableTextField(context,reusabletextfieldcontroller.gender, 'Gender',_gender.hasFocus
                //                       ? colorController.blueColor
                //                       : colorController
                //                           .textfieldBorderColorBefore,
                //                   _gender,
                //                   () {
                //                     _gender.unfocus();
                //                     FocusScope.of(context)
                //                         .requestFocus(_mStatus);
                //                   },),
                          reusablaSizaBox(context, 0.020),
                          AbsorbPointer(
  absorbing: !isCityDropdownEnabled,
  child: Opacity(
    opacity: isCityDropdownEnabled ? 1.0 : 0.5,
    child: Container(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.01),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1.5),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          // Expanded to ensure DropdownSearch takes full width
          Expanded(
            child: DropdownSearch<dynamic>(
              popupProps: PopupPropsMultiSelection.dialog(
                fit: FlexFit.loose,
                showSearchBox: true,
                dialogProps: DialogProps(
                  backgroundColor: colorController.whiteColor,
                  elevation: 10,
                ),
                searchFieldProps: TextFieldProps(
                  decoration: InputDecoration(
                    hintText: 'Search City',
                    hintStyle: TextStyle(fontSize: 11.5),
                    fillColor: colorController.whiteColor,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0.0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(11)),
                  ),
                ),
              ),
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  hintText: 'Select City',
                  hintStyle: TextStyle(fontSize: 11.5),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: MediaQuery.sizeOf(context).width * 0.02,right: MediaQuery.sizeOf(context).width * 0.02,top: MediaQuery.sizeOf(context).height * 0.013),
                ),
              ),
              items: cityList,
              itemAsString: (dynamic city) => city['c_name'].toString(),
              onChanged: isCityDropdownEnabled
                  ? (dynamic newValue) {
                      setState(() {
                        cityLists = newValue;
                        MySharedPrefrence().set_city_id(newValue['c_id'].toString());
                        // cityId = newValue['c_id'];
                        // Reset area selection
                      });
                      print('Selected city ID: ${newValue['c_id']}');
                      // print('Selected city ID: ${cityId}');
                      print('Selected city Name: ${newValue['c_name']}');
                    }
                  : null,
              selectedItem: cityLists,
            ),
          ),
          // Additional Icons to the right
          InkWell(
            onTap: (){
              setState(() {
                selectCity();
              });
            },
            child: Icon(Icons.sync, )),
        ],
      ),
    ),
  ),
),
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
                          reusableReadOnlyTextField(context, reusabletextfieldcontroller.father, 'Father Name', colorController.blueColor),
                          reusablaSizaBox(context, 0.020),
                          reusableTextField(context,reusabletextfieldcontroller.mStatus, 'Marital Status',_mStatus.hasFocus
                                      ? colorController.blueColor
                                      : colorController
                                          .textfieldBorderColorBefore,
                                  _mStatus,
                                  () {
                                    _mStatus.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_email);
                                  },),
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
                          reusablaSizaBox(context, 0.020),
                          // reusableTextField(context,reusabletextfieldcontroller.email, 'Email', _email.hasFocus
                          //             ? colorController.blueColor
                          //             : colorController
                          //                 .textfieldBorderColorBefore,
                          //         _email,
                          //         () {
                          //           _email.unfocus();
                          //           FocusScope.of(context)
                          //               .requestFocus(_cnic);
                          //         },),
                          reusableReadOnlyTextField(context, reusabletextfieldcontroller.email, 'Email', colorController.blueColor),
                                  reusablaSizaBox(context, 0.020),
                                  // reusableTextField(context,reusabletextfieldcontroller.cnic, 'CNIC Number', _cnic.hasFocus
                                  //     ? colorController.blueColor
                                  //     : colorController
                                  //         .textfieldBorderColorBefore,
                                  // _cnic,
                                  // () {
                                  //   _cnic.unfocus();
                                  //   FocusScope.of(context)
                                  //       .requestFocus(_cnic);
                                  // },),
                                  reusableReadOnlyTextField(context, reusabletextfieldcontroller.cnic, 'CNIC No', colorController.blueColor),
                                   reusablaSizaBox(context, 0.020),
                                   reusableReadOnlyTextField(context, reusabletextfieldcontroller.numbr, 'Contact Number', colorController.blueColor),
                                   reusablaSizaBox(context, 0.020),
                                   reusableReadOnlyTextField(context, reusabletextfieldcontroller.altnumbr, 'Alternate Number', colorController.blueColor),
                                   reusablaSizaBox(context, 0.020),
                                   reusableDocuments2(context, 'Add Image (Front)','Add Image (Back)', 'CNIC Image', 
                               state.cnicFront != null ? state.cnicFront!.path : repository.cnic_f.value.toString(),
                               state.cnicBack != null ? state.cnicBack!.path : repository.cnic_b.value.toString(), 
                               (){reuablebottomsheet(context, "Choose CNIC Front Image",(){
                                  // _pickImage(ImageSource.gallery,'front');
                                  controller.pickImage(context, 'front', ImageSource.gallery);
                              },(){
                                  // _pickImage(ImageSource.camera,'front');
                                  controller.pickImage(context, 'front', ImageSource.camera);
                              });},
                              (){reuablebottomsheet(context, "Choose CNIC Back Image",(){
                                  // _pickImage(ImageSource.gallery,'back');
                                  controller.pickImage(context, 'back', ImageSource.gallery);
                              },(){
                                  // _pickImage(ImageSource.camera,'back');
                                  controller.pickImage(context, 'back', ImageSource.camera);
                              });},
                               'assets/images/add_img_placeholder.png'),
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


}