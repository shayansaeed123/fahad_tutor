import 'dart:async';
import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/controller/text_field_controller.dart';
import 'package:fahad_tutor/database/my_shared.dart';
import 'package:fahad_tutor/repo/utils.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusableTextField.dart';
import 'package:fahad_tutor/res/reusablebtn.dart';
import 'package:fahad_tutor/res/reusableloading.dart';
import 'package:fahad_tutor/res/reusablepassfield.dart';
import 'package:fahad_tutor/res/reusableradiobtn.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:fahad_tutor/res/reusablevalidator.dart';
import 'package:fahad_tutor/res/reusablevisibility.dart';
import 'package:fahad_tutor/views/dashboard/home.dart';
import 'package:fahad_tutor/views/dashboard/nav_bar.dart';
import 'package:fahad_tutor/views/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class Rigister extends StatefulWidget {
  const Rigister({super.key});

  @override
  State<Rigister> createState() => _RigisterState();
}

class _RigisterState extends State<Rigister> {
  // TextEditingController _selectDateCon = TextEditingController();
  String _selectedValue = 'Tutor';
  String _selectedValue1 = 'Yes';
  String? _selectedValue2 = 'none';
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
  if (checkbox1) selectedPlacements.add('1');
  if (checkbox2) selectedPlacements.add('2');
  if (checkbox3) selectedPlacements.add("3");
}


  String? _selectedCountry;
  String? _selectedCity;
  String? _selectedGender;
  String? _selectedStatus;
  late bool isLoading;

  late FocusNode _teacherfocusNode;
  late FocusNode _fatherfocusNode;
  late FocusNode _contactfocusNode;
  late FocusNode _alterContactfocusNode;
  late FocusNode _cnicfocusNode;
  late FocusNode _passfocusNode;
  late FocusNode _rePassfocusNode;
  late FocusNode _religionfocusNode;
  late FocusNode _homefocusNode;

  DateTime? selectedTime;
  late DateTime lastDate = DateTime(1995, 1, 1);

  final _formkey = GlobalKey<FormState>();
  bool checkbox1 = false;
  bool checkbox2 = false;
  bool checkbox3 = false;
  bool pass = true;
  bool repass = true;

  List<dynamic> countryList = [];
  List<dynamic> cityList = [];
  List<dynamic> areaList = [];
  String countryName = '';
  String cityName = '';
  String countryId = '';
  String cityId = '';
  String areaName = '';
  String areaId = '';
  
  @override
  void initState() {
    super.initState();
    selectCountry();
    _biography.addListener(_updateCharCount);
    _teacherfocusNode = FocusNode();
    _teacherfocusNode.addListener(_onFocusChange);
    _fatherfocusNode = FocusNode();
    _fatherfocusNode.addListener(_onFocusChange);
    _contactfocusNode = FocusNode();
    _contactfocusNode.addListener(_onFocusChange);
    _alterContactfocusNode = FocusNode();
    _alterContactfocusNode.addListener(_onFocusChange);
    _cnicfocusNode = FocusNode();
    _cnicfocusNode.addListener(_onFocusChange);
    _passfocusNode = FocusNode();
    _passfocusNode.addListener(_onFocusChange);
    _rePassfocusNode = FocusNode();
    _rePassfocusNode.addListener(_onFocusChange);
    _religionfocusNode = FocusNode();
    _religionfocusNode.addListener(_onFocusChange);
    _homefocusNode = FocusNode();
    _homefocusNode.addListener(_onFocusChange);
  }
  

  @override
  void dispose() {
    _teacherfocusNode.dispose();
    _teacherfocusNode.removeListener(_onFocusChange);
    _fatherfocusNode.dispose();
    _fatherfocusNode.removeListener(_onFocusChange);
    _contactfocusNode.dispose();
    _contactfocusNode.removeListener(_onFocusChange);
    _alterContactfocusNode.dispose();
    _alterContactfocusNode.removeListener(_onFocusChange);
    _cnicfocusNode.dispose();
    _cnicfocusNode.removeListener(_onFocusChange);
    _passfocusNode.dispose();
    _passfocusNode.removeListener(_onFocusChange);
    _rePassfocusNode.dispose();
    _rePassfocusNode.removeListener(_onFocusChange);
    _religionfocusNode.dispose();
    _religionfocusNode.removeListener(_onFocusChange);
    _homefocusNode.dispose();
    _homefocusNode.removeListener(_onFocusChange);
    _biography.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      // Redraw the UI when the focus changes
    });
  }

  void _validateForm() {
  bool isBiographyValid = !checkbox2 || (_biography.text.length >= 500 && _biography.text.length <= 800);

  if (
    isBiographyValid &&
    cityName.isNotEmpty &&
    reusabletextfieldcontroller.teacherCon.text.isNotEmpty &&
    reusabletextfieldcontroller.fatherCon.text.isNotEmpty &&
    reusabletextfieldcontroller.registerPassCon.text.isNotEmpty &&
    reusabletextfieldcontroller.rePassCon.text.isNotEmpty &&
    reusabletextfieldcontroller.registerPassCon.text == reusabletextfieldcontroller.rePassCon.text &&
    reusabletextfieldcontroller.registerPassCon.text.length >= 8 &&
    reusabletextfieldcontroller.registerPassCon.text.length <= 15 &&
    reusabletextfieldcontroller.contactCon.text.length == 11 &&
    reusabletextfieldcontroller.alterContactCon.text.length == 11 &&
    reusabletextfieldcontroller.contactCon.text.isNotEmpty &&
    reusabletextfieldcontroller.alterContactCon.text.isNotEmpty &&
    reusabletextfieldcontroller.cnicCon.text.length == 14 &&
    reusabletextfieldcontroller.religionCon.text.isNotEmpty &&
    areaName.isNotEmpty &&
    reusabletextfieldcontroller.addressCon.text.isNotEmpty &&
    _selectedGender != null && 
    _selectedStatus != null &&
    (checkbox1 || checkbox2 || checkbox3)
  ) {
    signInWithGoogle();
    // Navigator.push(context, MaterialPageRoute(builder: (context) => NavBar()));
  } else {
    Utils.snakbar(
      context,
      !isBiographyValid
          ? (_biography.text.length < 500
              ? 'Biography must be at least 500 characters'
              : 'Biography must not exceed 800 characters')
          : cityName.isEmpty
              ? 'City is Missing'
              : reusabletextfieldcontroller.teacherCon.text.isEmpty
                  ? "Tutor name is missing"
                  : reusabletextfieldcontroller.fatherCon.text.isEmpty
                      ? "Father/Husband name is missing"
                      : reusabletextfieldcontroller.contactCon.text.length != 11
                          ? "Check phone number"
                          : reusabletextfieldcontroller.alterContactCon.text.length != 11
                              ? "Check alternate phone number"
                              : reusabletextfieldcontroller.cnicCon.text.length != 14
                                  ? "Check CNIC number"
                                  : reusabletextfieldcontroller.registerPassCon.text.isEmpty
                                      ? "Password is missing"
                                      : reusabletextfieldcontroller.rePassCon.text.isEmpty
                                          ? "Confirm password is missing"
                                          : reusabletextfieldcontroller.registerPassCon.text != reusabletextfieldcontroller.rePassCon.text
                                              ? "Passwords do not match"
                                              : reusabletextfieldcontroller.registerPassCon.text.length < 8
                                                  ? "Password must be between 8 and 15 characters"
                                                  : reusabletextfieldcontroller.religionCon.text.isEmpty
                                                      ? "Religion is missing"
                                                      : areaName.isEmpty
                                                          ? 'Area is missing'
                                                          : reusabletextfieldcontroller.addressCon.text.isEmpty
                                                              ? "Address is missing"
                                                              : _selectedGender == null
                                                                  ? 'Gender is missing'
                                                                  : _selectedStatus == null
                                                                      ? 'Status is missing'
                                                                      : !(checkbox1 || checkbox2 || checkbox3)
                                                                          ? 'Please select at least one placement'
                                                                          : "Fill correct fields",
    );
  }
}


  // void _validateForm() {

  //   // Check if online checkbox is selected, then validate biography length
  // if (checkbox2 && (_biography.text.length < 500 || _biography.text.length > 800)) {
  //   Utils.snakbar(context, _biography.text.length < 500
  //       ? 'Biography must be at least 500 characters'
  //       : 'Biography must not exceed 800 characters');
  //   return;
  // }

  //   if (
  //     cityName.isNotEmpty &&
  //       reusabletextfieldcontroller.teacherCon.text.isNotEmpty &&
  //       reusabletextfieldcontroller.fatherCon.text.isNotEmpty &&
  //       reusabletextfieldcontroller.registerPassCon.text.isNotEmpty &&
  //       reusabletextfieldcontroller.rePassCon.text.isNotEmpty &&
  //       reusabletextfieldcontroller.registerPassCon.text ==
  //           reusabletextfieldcontroller.rePassCon.text &&
  //       reusabletextfieldcontroller.registerPassCon.text.length >= 8 &&
  //       reusabletextfieldcontroller.rePassCon.text.length <= 15 &&
  //       reusabletextfieldcontroller.contactCon.text.length == 11 &&
  //       reusabletextfieldcontroller.alterContactCon.text.length == 11 &&
  //       reusabletextfieldcontroller.contactCon.text.isNotEmpty &&
  //       reusabletextfieldcontroller.alterContactCon.text.isNotEmpty &&
  //       reusabletextfieldcontroller.cnicCon.text.length == 14 &&
  //       reusabletextfieldcontroller.religionCon.text.isNotEmpty &&
  //       areaName.isNotEmpty &&
  //       reusabletextfieldcontroller.addressCon.text.isNotEmpty && 
  //       _selectedGender != null && _selectedStatus != null &&
  //       checkbox1 || checkbox2 || checkbox3 
  //     ) {
  //     signInWithGoogle();
  //     // Navigator.push(context, MaterialPageRoute(builder: (context) => NavBar()));
  //   } else {
  //     Utils.snakbar(
  //       context,
  //       cityName.isEmpty
  //           ? 'City is Missing'
  //           : reusabletextfieldcontroller.teacherCon.text.isEmpty
  //               ? "Tutor name Is Missing"
  //               : reusabletextfieldcontroller.fatherCon.text.isEmpty
  //                   ? "Father/Husband name Is Missing"
  //                   : reusabletextfieldcontroller.contactCon.text.length != 11
  //                       ? "Check Phone Number  "
  //                       : reusabletextfieldcontroller
  //                                   .alterContactCon.text.length !=
  //                               11
  //                           ? "Check alter Phone Number  "
  //                           : reusabletextfieldcontroller.cnicCon.text.length !=
  //                                   14
  //                               ? "Check CNIC Number  "
  //                               : reusabletextfieldcontroller
  //                                       .registerPassCon.text.isEmpty
  //                                   ? "Password Is Missing"
  //                                   : reusabletextfieldcontroller
  //                                           .rePassCon.text.isEmpty
  //                                       ? "Confirm Password Is Missing"
  //                                       : reusabletextfieldcontroller
  //                                                   .registerPassCon.text !=
  //                                               reusabletextfieldcontroller
  //                                                   .rePassCon.text
  //                                           ? "Passwords is defferent"
  //                                           : reusabletextfieldcontroller
  //                                                       .registerPassCon.text.length <
  //                                                   8
  //                                               ? "Password  Must be at least of 8 and maximum of 15 charracters"
  //                                               : reusabletextfieldcontroller
  //                                                       .religionCon
  //                                                       .text
  //                                                       .isEmpty
  //                                                   ? "Religion is Missing "
  //                                                   : areaName!.isEmpty
  //                                                       ? 'Area is Missing'
  //                                                       : reusabletextfieldcontroller
  //                                                               .addressCon
  //                                                               .text
  //                                                               .isEmpty
  //                                                           ? "Address is Missing" 
  //                                                           : _selectedGender == null ? 'Gender is missing' 
  //                                                           : _selectedStatus == null ? 'Status is Missing' 
  //                                                           : 
  //                                                           !(checkbox1 || checkbox2 || checkbox3) ? 'Please select at least one Placement' 
  //                                                           : "Fill Correct Fields",
  //     );
  //   }
  // }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  signInWithGoogle() async {
    setState(() {
      isLoading = true;
    });
    try {
      setState(() {
        isLoading = false;
      });
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;
      if (user != null) {
        final String? email = user.email;
        print('User email: $email');
        // You can now use the email variable
      }
      MySharedPrefrence().set_user_name(user!.displayName);
      // MySharedPrefrence().setUserLoginStatus(true);
      MySharedPrefrence().set_user_email(user.email);
      print(MySharedPrefrence().get_user_name());
      // print(MySharedPrefrence().getUserLoginStatus());
      print(MySharedPrefrence().get_user_email());
      checkAccount();
      // Navigator.push(context,
      //                       MaterialPageRoute(
      //                         builder: (context) => WillPopScope(
      //                             onWillPop: () async => false,
      //                             child: HomePage()),
      //                       ));
    } catch (e) {
      print('Error $e');
      // reusabledialog(context, "Login Failed",
      //       "An error occurred while trying to log in.", "Ok", () {});
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> selectCountry() async {
    setState(() {
      isLoading = true;
    });

    try {
      
      final response = await http.get(
        Uri.parse('${Utils.baseUrl}mobile_app/country.php?code=10'),
      );
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final Map<String, dynamic> jsonResponse = json.decode(response.body);
          countryList = jsonResponse['country_listing'];
          if (countryList.isNotEmpty) {
            setState(() {
              countryName = countryList[0]['c_name'];
              // countryId = countryList[0]['c_id'];
              print(countryName);
              print(countryList);
            });
          } else {
            throw Exception('Country list is empty');
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
      print(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> selectCity() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.post(
          Uri.parse('${Utils.baseUrl}mobile_app/city.php'),
          body: {
            'code': '10',
            'country_id': countryId.toString(),
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
              print(countryList);
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
      print('$e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> selectArea() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.post(
          Uri.parse('${Utils.baseUrl}mobile_app/area.php'),
          body: {
            'code': '10',
            'city_id': MySharedPrefrence().get_city_id().toString(),
            // cityId.toString(),
          });
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final Map<String, dynamic> jsonResponse = json.decode(response.body);
          areaList = jsonResponse['area_listing'];
          if (areaList.isNotEmpty) {
            setState(() {
              areaName = areaList[0]['area_name'];
              // countryId = countryList[0]['c_id'];
              print(areaName);
              print(areaList);
            });
          } else {
            throw Exception('Area list is empty');
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
      print(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> checkAccount() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.post(
          Uri.parse('https://fahadtutors.com/mobile_app/acoount_check.php'),
          body: {
            'contact_number':reusabletextfieldcontroller.contactCon.text.toString(),
            'cnic': reusabletextfieldcontroller.cnicCon.text.toString(),
            'alternate_number':reusabletextfieldcontroller.alterContactCon.text.toString(),
            'email': MySharedPrefrence().get_user_email().toString(),
          });
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        String apiMessage = responseData['message'];
        // String number = responseData['number'];
        if (responseData['success'] == 1) {
          print('response:' + response.body);
          // Navigator.pop(context);
          try {
            await _googleSignIn.signOut();
            await _auth.signOut();
            print('User signed out');
          } catch (e) {
            print(e);
          }
          setState(() {
            signUpApi();
          });
          // }
          //   },
          // );
        } else {
          InkWell(
            onTap: (){
              Utils.launchWhatsApp(context);
            },
            child: Utils.snakbarFailed(context, 'check ${ apiMessage}'),
          );
          try {
            await _googleSignIn.signOut();
            await _auth.signOut();
            print('User signed out');
          } catch (e) {
            print(e);
          }
          Navigator.pop(context);
        }
      } else {
        print('Error2: ' + response.statusCode.toString());
      }
    } catch (e) {
      print('heloooo $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> signUpApi() async {
    setState(() {
      isLoading = true;
    });
    try {
      updateTutorPlacement(); // Ensure the selected placements are updated
      final bio = _biography.text.toString();
      print('check email ${MySharedPrefrence().get_user_email()}');
      print('bio ${bio.toString()}');
      final response = await http.post(
          Uri.parse('${Utils.baseUrl}mobile_app/sign_up.php'),
          body: {
            'contact_number':reusabletextfieldcontroller.contactCon.text.toString(),
            'cnic': reusabletextfieldcontroller.cnicCon.text.toString(),
            'alternate_number':reusabletextfieldcontroller.alterContactCon.text.toString(),
            'teacher_name': reusabletextfieldcontroller.teacherCon.text.toString(),
            'father_name':reusabletextfieldcontroller.fatherCon.text.toString(),
            'married_status': _selectedStatus.toString(),
            'tutreligion':reusabletextfieldcontroller.religionCon.text.toString(),
            'email': MySharedPrefrence().get_user_email().toString(),
            'gender': _selectedGender.toString(),
            'password': reusabletextfieldcontroller.registerPassCon.text.toString(),
            'city_id': MySharedPrefrence().get_city_id().toString(),
            // cityId.toString(),
            'area_id': areaId.toString(),
            'home_address':reusabletextfieldcontroller.addressCon.text.toString(),
            'date_of_birth': selectedTime.toString(),
            'DigitalPad':_selectedValue1.toString(),
            'onlineTeaching_experience': _selectedValue2.toString(),
            'online_Skill':'',
            'Biography': bio.toString(),
            'tutor_placement': jsonEncode(selectedPlacements),
          });
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        String apiMessage = responseData['message'];
        // String number = responseData['number'];
        if (responseData['success'] == 1) {
          print('response:' + response.body);
          Navigator.pop(context);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: ((context) => Login())));
          Utils.snakbarSuccess(context, apiMessage);
        } else {
          InkWell(
            onTap: (){
              Utils.launchWhatsApp(context);
            },
            child: Utils.snakbarFailed(context, apiMessage),
          );
          Navigator.push(
              context, MaterialPageRoute(builder: ((context) => Rigister())));
          //   },
          // );
        }
      } else {
        print('Error2: ' + response.statusCode.toString());
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  dynamic countryLists;
  dynamic cityLists;
  dynamic areaLists;
  bool isCityDropdownEnabled = false;
  bool isAreaDropdownEnabled = false;

  List<dynamic> selectedCountries = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorController.whiteColor,
      body: Stack(
        children: [
          SafeArea(
              child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * .05),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.03),
                          child: Image.asset(
                            'assets/images/logo_1.png',
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.contain,
                            width: MediaQuery.of(context).size.width * .25,
                            height: MediaQuery.of(context).size.height * .10,
                          ),
                        ),
                      ],
                    ),
                    reusablaSizaBox(context, .025),
                    reusableText('Create Account,',
                        fontsize: 26, fontweight: FontWeight.bold),
                    reusablaSizaBox(context, .01),
                    reusableText(
                      'Sign up to get started!',
                      color: colorController.textfieldBorderColorBefore,
                      fontsize: 18,
                    ),
                    reusablaSizaBox(context, .01),
                    reusableRadioBtn(
                      context,
                      'Student', // Value of the first radio button
                      'Tutor', // Value of the second radio button
                      _selectedValue, // Current selected value
                      (String? value) {
                        // onChanged function
                        setState(() {
                          _selectedValue = value!;
                        });
                      },
                      'Student', // Name of the first radio button
                      'Tutor', // Name of the second r
                      .4,
                    ),
                    _selectedValue == 'Tutor'
                        ? Form(
                            key: _formkey,
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          .01),
                                  width: MediaQuery.of(context).size.width,
                                  // height:
                                  //     MediaQuery.of(context).size.height * .055,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey,
                                        width: 1.5), // Border color
                                    borderRadius: BorderRadius.circular(10.0),
                                    // Border radius
                                  ),
                                  child: 
                                  DropdownSearch<dynamic>(
                                    popupProps: PopupPropsMultiSelection.dialog(
                                      fit: FlexFit.loose,
                                      showSearchBox: true,
                                      dialogProps: DialogProps(
                                        backgroundColor:
                                            colorController.whiteColor,
                                        elevation: 10,
                                      ),
                                      searchFieldProps: TextFieldProps(
                                        decoration: InputDecoration(
                                          hintText: 'Search Country',
                                          hintStyle: TextStyle(fontSize:  11.5),
                                          fillColor: colorController.whiteColor,
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 0.0),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(11),
                                          ),
                                        ),
                                      ),
                                    ),
                                    dropdownDecoratorProps:
                                        DropDownDecoratorProps(
                                      dropdownSearchDecoration: InputDecoration(
                                        hintText: 'Select Country',
                                        hintStyle: TextStyle(fontSize:  11.5),
                                        border: InputBorder.none,
                                        // contentPadding: EdgeInsets.symmetric(
                                        //     horizontal: 16, vertical: 8),
                                      ),
                                    ),
                                    items: countryList,
                                    itemAsString: (dynamic country) =>
                                        country['c_name'].toString(),
                                    onChanged: (dynamic newValue) {
                                      setState(() {
                                        countryLists = newValue;
                                        countryId = newValue['c_id'].toString();
                                        isCityDropdownEnabled = true;
                                        isAreaDropdownEnabled = false;
                                      });
                                      selectCity();
                                    },
                                    selectedItem: countryLists,
                                  ),
                                ),
                                reusablaSizaBox(context, .015),
                                AbsorbPointer(
                                  absorbing: !isCityDropdownEnabled,
                                  child: Opacity(
                                    opacity: isCityDropdownEnabled ? 1.0 : 0.5,
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context).size.width *
                                              .01),
                                      width: MediaQuery.of(context).size.width,
                                      // height:
                                      //     MediaQuery.of(context).size.height * .055,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey,
                                            width: 1.5), // Border color
                                        borderRadius: BorderRadius.circular(
                                            10.0), // Border radius
                                      ),
                                      child: DropdownSearch<dynamic>(
                                        popupProps: PopupPropsMultiSelection.dialog(
                                          fit: FlexFit.loose,
                                          showSearchBox: true,
                                          dialogProps: DialogProps(
                                            backgroundColor:
                                                colorController.whiteColor,
                                            elevation: 10,
                                          ),
                                          searchFieldProps: TextFieldProps(
                                            decoration: InputDecoration(
                                              hintText: 'Search City',
                                              hintStyle: TextStyle(fontSize:  11.5),
                                              fillColor: colorController.whiteColor,
                                              contentPadding: EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 0.0),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(11),
                                              ),
                                            ),
                                          ),
                                        ),
                                        dropdownDecoratorProps:
                                            DropDownDecoratorProps(
                                          dropdownSearchDecoration: InputDecoration(
                                            hintText: 'Select City',
                                            hintStyle: TextStyle(fontSize:  11.5),
                                            border: InputBorder.none,
                                            // contentPadding: EdgeInsets.symmetric(
                                            //     horizontal: 16, vertical: 8),
                                          ),
                                        ),
                                        items: cityList,
                                        itemAsString: (dynamic city) =>
                                            city['c_name'].toString(),
                                        onChanged: isCityDropdownEnabled
                                            ? (dynamic newValue) {
                                                setState(() {
                                                  cityLists = newValue;
                                                  // cityId = newValue['c_id'].toString();
                                                  MySharedPrefrence().set_city_id(newValue['c_id'].toString());
                                                  isAreaDropdownEnabled = true;
                                                });
                                                print(
                                                    'Selected city ID: ${newValue['c_id']}');
                                                print(
                                                    'Selected city Name: ${newValue['c_name']}');
                                                selectArea();
                                              }
                                            : null,
                                        selectedItem: cityLists,
                                      ),
                                    ),
                                  ),
                                ),
                                reusablaSizaBox(context, .015),
                                reusableTextField(
                                  context,
                                  reusabletextfieldcontroller.teacherCon,
                                  'Teacher Name',
                                  _teacherfocusNode.hasFocus
                                      ? colorController.blueColor
                                      : colorController
                                          .textfieldBorderColorBefore,
                                  _teacherfocusNode,
                                  () {
                                    _teacherfocusNode.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_fatherfocusNode);
                                  },
                                  // true,
                                  // 'Name is requried',
                                  keyboardType: TextInputType.text,
                                ),
                                reusablaSizaBox(context, .015),
                                reusableTextField(
                                  context,
                                  reusabletextfieldcontroller.fatherCon,
                                  'Father/Husband Name',
                                  _fatherfocusNode.hasFocus
                                      ? colorController.blueColor
                                      : colorController
                                          .textfieldBorderColorBefore,
                                  _fatherfocusNode,
                                  () {
                                    _fatherfocusNode.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_contactfocusNode);
                                  },
                                  // true,
                                  // 'Father name is requried',
                                  keyboardType: TextInputType.text,
                                ),
                                reusablaSizaBox(context, .015),
                                reusableContactField(
                                  context,
                                  reusabletextfieldcontroller.contactCon,
                                  'Contact No',
                                  _contactfocusNode.hasFocus
                                      ? colorController.blueColor
                                      : colorController
                                          .textfieldBorderColorBefore,
                                  _contactfocusNode,
                                  () {
                                    _contactfocusNode.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_alterContactfocusNode);
                                  },
                                  11,
                                  // true,
                                  // 'Contact No is requried',
                                  // 'Number must start with 03 and be 11 digits long',
                                  keyboardType: TextInputType.phone,
                                ),
                                reusablaSizaBox(context, .015),
                                reusableContactField(
                                  context,
                                  reusabletextfieldcontroller.alterContactCon,
                                  'Alternate Contact No',
                                  _alterContactfocusNode.hasFocus
                                      ? colorController.blueColor
                                      : colorController
                                          .textfieldBorderColorBefore,
                                  _alterContactfocusNode,
                                  () {
                                    _alterContactfocusNode.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_cnicfocusNode);
                                  },
                                  11,
                                  // true,
                                  // 'Alternate No is requried',
                                  // 'Number must start with 03 and be 11 digits long',
                                  keyboardType: TextInputType.phone,
                                ),
                                reusablaSizaBox(context, .015),
                                reusableContactField(
                                  context,
                                  reusabletextfieldcontroller.cnicCon,
                                  'CNIC',
                                  _cnicfocusNode.hasFocus
                                      ? colorController.blueColor
                                      : colorController
                                          .textfieldBorderColorBefore,
                                  _cnicfocusNode,
                                  () {
                                    _cnicfocusNode.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_passfocusNode);
                                  },
                                  14,
                                  // true,
                                  // 'CNIC No is requried',
                                  keyboardType: TextInputType.number,
                                ),
                                reusablaSizaBox(context, .015),
                                reusablePassField(
                                    context,
                                    reusabletextfieldcontroller.registerPassCon,
                                    'Password',
                                    _passfocusNode.hasFocus
                                        ? colorController.blueColor
                                        : colorController
                                            .textfieldBorderColorBefore,
                                    _passfocusNode,
                                    () {
                                      _passfocusNode.unfocus();
                                      FocusScope.of(context)
                                          .requestFocus(_rePassfocusNode);
                                    },
                                    // true,
                                    // 'Password is requried',
                                    pass,
                                    () {
                                      setState(() {
                                        pass = !pass;
                                      });
                                    }),
                                reusablaSizaBox(context, .015),
                                reusablePassField(
                                    context,
                                    reusabletextfieldcontroller.rePassCon,
                                    'Re Enter Password',
                                    _rePassfocusNode.hasFocus
                                        ? colorController.blueColor
                                        : colorController
                                            .textfieldBorderColorBefore,
                                    _rePassfocusNode,
                                    () {
                                      _rePassfocusNode.unfocus();
                                      FocusScope.of(context)
                                          .requestFocus(_religionfocusNode);
                                    },
                                    //  true,
                                    // 'Password is requried',
                                    repass,
                                    () {
                                      setState(() {
                                        repass = !repass;
                                      });
                                    }),
                                reusablaSizaBox(context, .015),
                                reusableTextField(
                                  context,
                                  reusabletextfieldcontroller.religionCon,
                                  'Religion',
                                  _religionfocusNode.hasFocus
                                      ? colorController.blueColor
                                      : colorController
                                          .textfieldBorderColorBefore,
                                  _religionfocusNode,
                                  () {
                                    _religionfocusNode.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_homefocusNode);
                                  },
                                  // true,
                                  // 'Religion is requried',
                                  keyboardType: TextInputType.text,
                                ),
                                reusablaSizaBox(context, .015),
                                reusableDateofBirthField(context, lastDate, selectedTime, (DateTime timeofday){
                                  setState(() {
                                            selectedTime = timeofday;
                                            print('time date $selectedTime');
                                          });
                                }, Icon(Icons.calendar_month_outlined)),
                                reusablaSizaBox(context, .015),
                                AbsorbPointer(
                                  absorbing: !isAreaDropdownEnabled,
                                  child: Opacity(
                                    opacity: isAreaDropdownEnabled ? 1.0 : 0.5,
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context).size.width *
                                              .01),
                                      width: MediaQuery.of(context).size.width,
                                      // height:
                                      //     MediaQuery.of(context).size.height * .055,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey,
                                            width: 1.5), // Border color
                                        borderRadius: BorderRadius.circular(
                                            10.0), // Border radius
                                      ),
                                    
                                      child: DropdownSearch<dynamic>(
                                        popupProps: PopupPropsMultiSelection.dialog(
                                          fit: FlexFit.loose,
                                          showSearchBox: true,
                                          dialogProps: DialogProps(
                                            backgroundColor:
                                                colorController.whiteColor,
                                            elevation: 10,
                                          ),
                                          searchFieldProps: TextFieldProps(
                                            decoration: InputDecoration(
                                              hintText: 'Search Area',
                                              fillColor: colorController.whiteColor,
                                              contentPadding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 0.0),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(11),
                                              ),
                                            ),
                                          ),
                                        ),
                                        dropdownDecoratorProps:
                                            DropDownDecoratorProps(
                                          dropdownSearchDecoration: InputDecoration(
                                            hintText: 'Select Area',
                                            hintStyle: TextStyle(fontSize: 11.5),
                                            border: InputBorder.none,
                                            // contentPadding: EdgeInsets.symmetric(
                                            //     horizontal: 16, vertical: 8),
                                          ),
                                        ),
                                        items: areaList,
                                        itemAsString: (dynamic area) =>
                                            area['area_name'].toString(),
                                        onChanged: isAreaDropdownEnabled
                                            ? (dynamic newValue) {
                                                setState(() {
                                                  areaLists = newValue;
                                                  areaId =
                                                      newValue['id'].toString();
                                                });
                                                print(
                                                    'Selected Area ID: ${newValue['id']}');
                                                print(
                                                    'Selected Area Name: ${newValue['area_name']}');
                                              }
                                            : null,
                                        selectedItem: areaLists,
                                         ),
                                    ),
                                  ),
                                ),
                                reusablaSizaBox(context, .015),
                                reusableTextField(
                                  context,
                                  reusabletextfieldcontroller.addressCon,
                                  'Home Address',
                                  _homefocusNode.hasFocus
                                      ? colorController.blueColor
                                      : colorController
                                          .textfieldBorderColorBefore,
                                  _homefocusNode,
                                  () {
                                    _homefocusNode.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_homefocusNode);
                                  },
                                  // true,
                                  // 'Address is requried',
                                  keyboardType: TextInputType.text,
                                ),
                                reusablaSizaBox(context, .015),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    reusableDropdownfeild(context, _selectedGender, (String? newValue){
                                      setState(() {
                                            _selectedGender = newValue;
                                            print('gender $_selectedGender');
                                          });
                                    }, 'Gender', ['Male', 'Female', ]),
                                    reusableDropdownfeild(context, _selectedStatus, (String? newValue){
                                      setState(() {
                                            _selectedStatus = newValue;
                                            print('Status $_selectedStatus');
                                          });
                                    }, 'Marital Status', ['Married',
                                          'Single',
                                          'Widowed',])
                                  ],
                                ),
                                reusablaSizaBox(context, .03),
                                reusableText('Tutors Placment', fontsize: 21),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
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
                                  // _selectedValue1,
                                  _selectedValue2,
                                  (String? newValue) {
                                    setState(() {
                                      _selectedValue2 = newValue;
                                      print('Experience $_selectedValue2');
                                      });
                                    },
                                  // (String? value) {
                                  //   // onChanged function
                                  //   setState(() {
                                  //     _selectedValue2 = value!;
                                  //     print('Experience $_selectedValue2');
                                  //   });
                                  // },
                                  _biography,
                                  _charCount,
                                ),
                                reusablaSizaBox(context, .02),
                                reusableBtn(context, 'Register', () {
                                  _validateForm();
                                }),
                                reusablaSizaBox(context, .02),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    reusableText('Already have an account? ',
                                        fontsize: 13),
                                    InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Login(),
                                              ));
                                        },
                                        child: reusableText('Login',
                                            color: colorController.blueColor,
                                            fontsize: 13,
                                            fontweight: FontWeight.bold)),
                                  ],
                                ),
                                reusablaSizaBox(context, .04),
                              ],
                            ),
                          )
                        : Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        .01),
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * .055,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey,
                                      width: 1.5), // Border color
                                  borderRadius: BorderRadius.circular(10.0),
                                  // Border radius
                                ),
                                child: DropdownButton<String>(
                                  value: _selectedCountry,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedCountry = newValue;
                                    });
                                  },
                                  hint: reusableText('Select Country',
                                      color: colorController.grayTextColor,
                                      fontsize: 14),
                                  items: <String>[
                                    'Option 1',
                                    'Option 2',
                                    'Option 3',
                                    'Option 4'
                                  ].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .81,
                                          child: reusableText(value,
                                              color:
                                                  colorController.grayTextColor,
                                              fontsize: 14)),
                                      // Display 'Select value' if value is null
                                    );
                                  }).toList(),
                                  style: TextStyle(
                                      color:
                                          Colors.black), // Dropdown text color
                                  icon: Icon(
                                      Icons.arrow_drop_down), // Dropdown icon
                                  underline: Container(), // Remove underline
                                  // elevation: 0,
                                ),
                              ),
                              reusablaSizaBox(context, .015),
                              Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        .01),
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * .055,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey,
                                      width: 1.5), // Border color
                                  borderRadius: BorderRadius.circular(
                                      10.0), // Border radius
                                ),
                                child: DropdownButton<String>(
                                  value: _selectedCity,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedCity = newValue;
                                    });
                                  },
                                  hint: reusableText('Select City',
                                      color: colorController.grayTextColor,
                                      fontsize: 14),
                                  items: <String>[
                                    'Option 1',
                                    'Option 2',
                                    'Option 3',
                                    'Option 4',
                                  ].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .81,
                                          child: reusableText(value,
                                              color:
                                                  colorController.grayTextColor,
                                              fontsize: 14)),
                                      // Display 'Select value' if value is null
                                    );
                                  }).toList(),
                                  style: TextStyle(
                                      color:
                                          Colors.black), // Dropdown text color
                                  icon: Icon(
                                      Icons.arrow_drop_down), // Dropdown icon
                                  underline: Container(), // Remove underline
                                  elevation: 0,
                                ),
                              ),
                              reusablaSizaBox(context, .015),
                              reusableTextField(
                                context,
                                reusabletextfieldcontroller.teacherCon,
                                'Name',
                                _teacherfocusNode.hasFocus
                                    ? colorController.blueColor
                                    : colorController
                                        .textfieldBorderColorBefore,
                                _teacherfocusNode,
                                () {
                                  _teacherfocusNode.unfocus();
                                  FocusScope.of(context)
                                      .requestFocus(_contactfocusNode);
                                },
                                // true,
                                // 'Name is requried',
                                keyboardType: TextInputType.text,
                              ),
                              reusablaSizaBox(context, .015),
                              reusableTextField(
                                context,
                                reusabletextfieldcontroller.contactCon,
                                'Contact No',
                                _contactfocusNode.hasFocus
                                    ? colorController.blueColor
                                    : colorController
                                        .textfieldBorderColorBefore,
                                _contactfocusNode,
                                () {
                                  _contactfocusNode.unfocus();
                                  FocusScope.of(context)
                                      .requestFocus(_passfocusNode);
                                },
                                // true,
                                // 'Contact No is requried',
                                keyboardType: TextInputType.phone,
                              ),
                              reusablaSizaBox(context, .015),
                              reusablePassField(
                                  context,
                                  reusabletextfieldcontroller.registerPassCon,
                                  'Password',
                                  _passfocusNode.hasFocus
                                      ? colorController.blueColor
                                      : colorController
                                          .textfieldBorderColorBefore,
                                  _passfocusNode,
                                  () {
                                    _passfocusNode.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_passfocusNode);
                                  },
                                  // true,'Password is requried' ,
                                  pass,
                                  () {
                                    setState(() {
                                      pass = !pass;
                                    });
                                  }),
                              reusablaSizaBox(context, .02),
                              reusableBtn(context, 'Register', () {
                                checkAccount();
                              }),
                              reusablaSizaBox(context, .02),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  reusableText('Already have an account? ',
                                      fontsize: 13),
                                  InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Login(),
                                            ));
                                      },
                                      child: reusableText('Login',
                                          color: colorController.blueColor,
                                          fontsize: 13,
                                          fontweight: FontWeight.bold)),
                                ],
                              ),
                              reusablaSizaBox(context, .04)
                            ],
                          ),
                  ]),
            ),
          )),
          if (isLoading == true) reusableloadingrow(context, isLoading),
        ],
      ),
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

class ListItem {
  final String value;
  bool selected;

  ListItem({required this.value, this.selected = false});
}

