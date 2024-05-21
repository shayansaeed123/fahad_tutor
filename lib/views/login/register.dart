import 'dart:async';
import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/controller/text_field_controller.dart';
import 'package:fahad_tutor/database/MySharedPrefrence.dart';
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

  late DateTime selectedTime = DateTime.now();
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
    // _passfocusNode = FocusNode();
    // _passfocusNode.addListener(_onFocusChange);
  }
  

  @override
  void dispose() {
    // _emailfocusNode.removeListener(_onFocusChange);
    // _emailfocusNode.dispose();
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
    if (cityName.isNotEmpty &&
        reusabletextfieldcontroller.teacherCon.text.isNotEmpty &&
        reusabletextfieldcontroller.fatherCon.text.isNotEmpty &&
        reusabletextfieldcontroller.passCon.text.isNotEmpty &&
        reusabletextfieldcontroller.rePassCon.text.isNotEmpty &&
        reusabletextfieldcontroller.passCon.text ==
            reusabletextfieldcontroller.rePassCon.text &&
        reusabletextfieldcontroller.passCon.text.length >= 8 &&
        reusabletextfieldcontroller.rePassCon.text.length <= 15 &&
        reusabletextfieldcontroller.contactCon.text.length == 11 &&
        reusabletextfieldcontroller.alterContactCon.text.length == 11 &&
        reusabletextfieldcontroller.contactCon.text.isNotEmpty &&
        reusabletextfieldcontroller.alterContactCon.text.isNotEmpty &&
        reusabletextfieldcontroller.cnicCon.text.length == 14 &&
        reusabletextfieldcontroller.religionCon.text.isNotEmpty &&
        areaName.isNotEmpty &&
        reusabletextfieldcontroller.addressCon.text.isNotEmpty) {
      // CheckUserContactExictOrNot();
      signInWithGoogle();
      // Navigator.push(context, MaterialPageRoute(builder: (context) => NavBar()));
    } else {
      Utils.snakbar(
        context,
        cityName.isEmpty
            ? 'City is Missing'
            : reusabletextfieldcontroller.teacherCon.text.isEmpty
                ? "Tutor name Is Missing"
                : reusabletextfieldcontroller.fatherCon.text.isEmpty
                    ? "Father/Husband name Is Missing"
                    : reusabletextfieldcontroller.contactCon.text.length != 11
                        ? "Check Phone Number  "
                        : reusabletextfieldcontroller
                                    .alterContactCon.text.length !=
                                11
                            ? "Check alter Phone Number  "
                            : reusabletextfieldcontroller.cnicCon.text.length !=
                                    14
                                ? "Check CNIC Number  "
                                : reusabletextfieldcontroller
                                        .passCon.text.isEmpty
                                    ? "Password Is Missing"
                                    : reusabletextfieldcontroller
                                            .rePassCon.text.isEmpty
                                        ? "Confirm Password Is Missing"
                                        : reusabletextfieldcontroller
                                                    .passCon.text !=
                                                reusabletextfieldcontroller
                                                    .rePassCon.text
                                            ? "Passwords is defferent"
                                            : reusabletextfieldcontroller
                                                        .passCon.text.length <
                                                    8
                                                ? "Password  Must be at least of 8 and maximum of 15 charracters"
                                                : reusabletextfieldcontroller
                                                        .religionCon
                                                        .text
                                                        .isEmpty
                                                    ? "Religion is Missing "
                                                    : areaName.isEmpty
                                                        ? 'Area is Missing'
                                                        : reusabletextfieldcontroller
                                                                .addressCon
                                                                .text
                                                                .isEmpty
                                                            ? "Address is Missing"
                                                            : "Fill Correct Fields",
      );
    }
  }

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
      MySharedPrefrence().setUserLoginStatus(true);
      MySharedPrefrence().set_user_email(user!.email);
      print(MySharedPrefrence().get_user_name());
      print(MySharedPrefrence().getUserLoginStatus());
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
      print(e);
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
            'city_id': cityId.toString(),
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
          Uri.parse('${Utils.baseUrl}mobile_app/acoount_check.php'),
          body: {
            'contact_number':
                reusabletextfieldcontroller.contactCon.text.toString(),
            'cnic': reusabletextfieldcontroller.cnicCon.text.toString(),
            'alternate_number':
                reusabletextfieldcontroller.alterContactCon.text.toString(),
            'email': MySharedPrefrence().get_user_email().toString(),
          });
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        String apiMessage = responseData['message'];
        String number = responseData['number'];
        if (responseData['success'] == '1') {
          print('response:' + response.body);
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: ((context) => NavBar())));
          Utils.snakbar(context, apiMessage);
          // reusableMessagedialog(
          //   context,
          //   apiMessage,
          //   'OK',
          //   () async{
          //     setState(() {
          //       isLoading = false;
          //     });
          //                 Future<void> _signOut() async {
          try {
            await _googleSignIn.signOut();
            await _auth.signOut();
            print('User signed out');
          } catch (e) {
            print(e);
          }
          // }
          //   },
          // );
        } else {
          Utils.snakbar(context, apiMessage);
          // reusableMessagedialog(
          //   context,
          //   apiMessage,
          //   'OK',
          //   ()async {
          //     setState(() {
          //       isLoading = false;
          //     });
          try {
            await _googleSignIn.signOut();
            await _auth.signOut();
            print('User signed out');
          } catch (e) {
            print(e);
          }
          Navigator.pop(context);
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

  Future<void> signUpApi() async {
    setState(() {
      isLoading = true;
    });
    try {
      updateTutorPlacement(); // Ensure the selected placements are updated
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
            'password': reusabletextfieldcontroller.passCon.text.toString(),
            'city_id': cityId.toString(),
            'area_id': areaId.toString(),
            'home_address':reusabletextfieldcontroller.addressCon.text.toString(),
            'date_of_birth': selectedTime.toString(),
            'DigitalPad':reusabletextfieldcontroller.alterContactCon.text.toString(),
            'onlineTeaching_experience': MySharedPrefrence().get_user_email().toString(),
            'online_Skill':reusabletextfieldcontroller.contactCon.text.toString(),
            'Biography': _biography.text.toString(),
            // 'tutor_placement': ,
          });
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        String apiMessage = responseData['message'];
        String number = responseData['number'];
        if (responseData['success'] == '1') {
          print('response:' + response.body);
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: ((context) => NavBar())));
          Utils.snakbar(context, apiMessage);
          // reusableMessagedialog(
          //   context,
          //   apiMessage,
          //   'OK',
          //   () async{
          //     setState(() {
          //       isLoading = false;
          //     });
          //                 Future<void> _signOut() async {
          try {
            await _googleSignIn.signOut();
            await _auth.signOut();
            print('User signed out');
          } catch (e) {
            print(e);
          }
          // }
          //   },
          // );
        } else {
          Utils.snakbar(context, apiMessage);
          // reusableMessagedialog(
          //   context,
          //   apiMessage,
          //   'OK',
          //   ()async {
          //     setState(() {
          //       isLoading = false;
          //     });
          try {
            await _googleSignIn.signOut();
            await _auth.signOut();
            print('User signed out');
          } catch (e) {
            print(e);
          }
          Navigator.pop(context);
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

// List<DropdownMenuItem<String>> _buildCountryDropdownItems(List<dynamic> countryList) {
//   Set<String> uniqueValues = {}; // To store unique values
//   List<DropdownMenuItem<String>> items = [];

//   for (dynamic country in countryList) {
//     String value = '${country['c_id']}'; // Use only the ID as value
//     if (!uniqueValues.contains(value)) {
//       uniqueValues.add(value);
//       items.add(DropdownMenuItem(
//         value: value,
//         child: Text(country['c_name']),
//       ));
//     }
//   }
//   return items;
// }

// void _onCountryChanged(dynamic newValue) {
//   setState(() {
//     countryLists = newValue;
//     countryId = newValue.toString();
//   });
//   selectCity(countryId); // Call selectCity function here
// }

  dynamic countryLists;
  dynamic cityLists;
  dynamic areaLists;
  bool isCityDropdownEnabled = false;
  bool isAreaDropdownEnabled = false;

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
                                  height:
                                      MediaQuery.of(context).size.height * .055,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey,
                                        width: 1.5), // Border color
                                    borderRadius: BorderRadius.circular(10.0),
                                    // Border radius
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
                                          hintText: 'Search Country',
                                          fillColor: colorController.whiteColor,
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
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
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
                                      });
                                      selectCity();
                                    },
                                    selectedItem: countryLists,
                                  ),
                                  //                   child: DropdownButton<dynamic>(
                                  //                     value: countryLists,
                                  //                     onChanged: (dynamic newValue) {
                                  // setState(() {
                                  //   countryLists = newValue;
                                  //   countryId = newValue.toString();
                                  //   isCityDropdownEnabled = true;
                                  // });
                                  // selectCity(); // Call selectCity function here
                                  // },
                                  //                     // (dynamic newValue) {
                                  //                     //   setState(() {
                                  //                     //     countryLists = newValue;
                                  //                     //     countryId = newValue['c_id'].toString(); // Assuming 'c_id' is the key for the country ID
                                  //                     //         isCityDropdownEnabled = true;
                                  //                     //   });
                                  //                     //   // selectCity(countryId.toString());
                                  //                     //   print('Selected class ID: ${newValue['c_id']}');
                                  //                     //   print('Selected class Name: ${newValue['c_name']}');
                                  //                     //   print('object $countryId');
                                  //                     //   // selectCity();
                                  //                     // },
                                  //                     hint: reusableText(
                                  //                       'Select Country',
                                  //                       color: colorController.grayTextColor,
                                  //                       fontsize: 14,
                                  //                     ),
                                  //                     items: countryList.map((dynamic country) {
                                  //                       return DropdownMenuItem<dynamic>(
                                  //                           value: country['c_id'].toString(),
                                  //                           child: Container(
                                  //                               width:
                                  //                                   MediaQuery.of(context).size.width * .81,
                                  //                               child: reusableText(country['c_name'],
                                  //                                   color: colorController.grayTextColor,
                                  //                                   fontsize: 14)));
                                  //                     }).toList(),
                                  //                     style: TextStyle(
                                  //                         color: Colors.black), // Dropdown text color
                                  //                     icon: Icon(Icons.arrow_drop_down), // Dropdown icon
                                  //                     underline: Container(), // Remove underline
                                  //                   ),
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
                                          fillColor: colorController.whiteColor,
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
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                      ),
                                    ),
                                    items: cityList,
                                    itemAsString: (dynamic city) =>
                                        city['c_name'].toString(),
                                    onChanged: isCityDropdownEnabled
                                        ? (dynamic newValue) {
                                            setState(() {
                                              cityLists = newValue;
                                              cityId =
                                                  newValue['c_id'].toString();
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
                                  //                   child: DropdownButton<dynamic>(
                                  //                     value: cityLists,
                                  //                     onChanged: isCityDropdownEnabled ? (dynamic newValue) {
                                  //     setState(() {
                                  // cityLists = newValue;
                                  // cityId = newValue['c_id'].toString();
                                  // isAreaDropdownEnabled = true;
                                  //     });
                                  // print('Selected city ID: ${newValue['c_id']}');
                                  // print('Selected city Name: ${newValue['c_name']}');
                                  //     selectArea();
                                  //   } : null,
                                  //                     // onChanged: (dynamic newValue) {
                                  // setState(() {
                                  //   cityLists = newValue;
                                  //   cityId = newValue['c_id'].toString();
                                  // });
                                  //                     //   print('Selected class ID: ${newValue['c_id']}');
                                  //                     //   print('Selected class Name: ${newValue['c_name']}');
                                  //                     //   // print('object $cityId');
                                  //                     // },
                                  //                     hint: reusableText('Select City',
                                  //                         color: colorController.grayTextColor,
                                  //                         fontsize: 14),
                                  //                     items: cityList.map((dynamic city) {
                                  //                       return DropdownMenuItem<dynamic>(
                                  //                           value: city,
                                  //                           child: Container(
                                  //                               width:
                                  //                                   MediaQuery.of(context).size.width * .81,
                                  //                               child: reusableText(city['c_name'],
                                  //                                   color: colorController.grayTextColor,
                                  //                                   fontsize: 14)));
                                  //                     }).toList(),
                                  //                     style: TextStyle(
                                  //                         color: Colors.black), // Dropdown text color
                                  //                     icon: Icon(Icons.arrow_drop_down), // Dropdown icon
                                  //                     underline: Container(), // Remove underline
                                  //                     elevation: 0,
                                  //                   ),
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
                                    reusabletextfieldcontroller.passCon,
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
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * .055,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: colorController.grayTextColor,
                                          width: 1.5),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: InkWell(
                                      onTap: () async {
                                        final DateTime? timeofday =
                                            await showDatePicker(
                                          context: context,
                                          firstDate: lastDate,
                                          lastDate: selectedTime,
                                          initialDate: selectedTime,
                                          initialEntryMode:
                                              DatePickerEntryMode.calendar,
                                          builder: (BuildContext context,
                                              Widget? child) {
                                            return Theme(
                                              data: ThemeData.dark().copyWith(
                                                  // primaryColor: colorController.btnColor,
                                                  colorScheme:
                                                      ColorScheme.light(
                                                    primary: colorController
                                                        .btnColor, // Header background color
                                                    onPrimary: colorController
                                                        .whiteColor, // Header text color
                                                    onSurface: colorController
                                                        .btnColor, // Body text color
                                                  ),
                                                  dialogBackgroundColor: Colors
                                                      .white, // Background color
                                                  bannerTheme:
                                                      MaterialBannerThemeData(
                                                          backgroundColor:
                                                              colorController
                                                                  .btnColor)),
                                              child: child!,
                                            );
                                          },
                                        );
                                        if (timeofday != null) {
                                          setState(() {
                                            selectedTime = timeofday;
                                            print('time date $selectedTime');
                                          });
                                        }
                                      },
                                      child: ListTile(
                                        enabled: false,
                                        trailing:
                                            Icon(Icons.date_range_outlined),
                                        title: Text(
                                          selectedTime == DateTime.now()
                                              ? 'Select Date'
                                              : '${DateFormat('yyyy-MM-dd').format(selectedTime)}',
                                          style: TextStyle(
                                              color:
                                                  colorController.grayTextColor,
                                              fontSize: 14),
                                        ),
                                      )),
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
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
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
                                  //                   child: DropdownButton<dynamic>(
                                  //                     value: areaLists,
                                  //                     onChanged: isAreaDropdownEnabled ? (dynamic newValue) {
                                  //     setState(() {
                                  // areaLists = newValue;
                                  // areaId = newValue['c_id'].toString();
                                  //     });
                                  //     print('Selected Area ID: ${newValue['id']}');
                                  //     print('Selected Area Name: ${newValue['area_name']}');
                                  //   } : null,
                                  //                     hint: reusableText('Select Area',
                                  //                         color: colorController.grayTextColor,
                                  //                         fontsize: 14),
                                  //                     items: areaList.map((dynamic area) {
                                  //                       return DropdownMenuItem<dynamic>(
                                  //                         value: area,
                                  //                         child: Container(
                                  //                             width:
                                  //                                 MediaQuery.of(context).size.width * .81,
                                  //                             child: reusableText(area['area_name'].toString(),
                                  //                                 color: colorController.grayTextColor,
                                  //                                 fontsize: 14)),
                                  //                         // Display 'Select value' if value is null
                                  //                       );
                                  //                     }).toList(),
                                  //                     style: TextStyle(
                                  //                         color: Colors.black), // Dropdown text color
                                  //                     icon: Icon(Icons.arrow_drop_down), // Dropdown icon
                                  //                     underline: Container(), // Remove underline
                                  //                     elevation: 0,
                                  //                   ),
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
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .01),
                                      width: MediaQuery.of(context).size.width *
                                          .43,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .055,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey,
                                            width: 1.5), // Border color
                                        borderRadius: BorderRadius.circular(
                                            10.0), // Border radius
                                      ),
                                      child: DropdownButton<String>(
                                        dropdownColor:
                                            colorController.whiteColor,
                                        value: _selectedGender,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            _selectedGender = newValue;
                                            print('gender $_selectedGender');
                                          });
                                        },
                                        hint: reusableText('Gender',
                                            color:
                                                colorController.grayTextColor,
                                            fontsize: 14),
                                        items: <String>[
                                          'Male',
                                          'Female',
                                        ].map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .3,
                                                child: reusableText(value,
                                                    color: colorController
                                                        .grayTextColor,
                                                    fontsize: 14)),
                                            // Display 'Select value' if value is null
                                          );
                                        }).toList(),
                                        style: TextStyle(
                                            color: Colors
                                                .black), // Dropdown text color
                                        icon: Icon(Icons
                                            .arrow_drop_down), // Dropdown icon
                                        underline:
                                            Container(), // Remove underline
                                        // elevation: 0,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .01),
                                      width: MediaQuery.of(context).size.width *
                                          .42,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .055,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey,
                                            width: 1.5), // Border color
                                        borderRadius: BorderRadius.circular(
                                            10.0), // Border radius
                                      ),
                                      child: DropdownButton<String>(
                                        dropdownColor:
                                            colorController.whiteColor,
                                        value: _selectedStatus,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            _selectedStatus = newValue;
                                            print('Status : $_selectedStatus');
                                          });
                                        },
                                        hint: reusableText('Marital Status',
                                            color:
                                                colorController.grayTextColor,
                                            fontsize: 14),
                                        items: <String>[
                                          'Married',
                                          'Single',
                                          'Widowed',
                                        ].map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .3,
                                                child: reusableText(value,
                                                    color: colorController
                                                        .grayTextColor,
                                                    fontsize: 14)),
                                            // Display 'Select value' if value is null
                                          );
                                        }).toList(),
                                        style: TextStyle(
                                            color: Colors
                                                .black), // Dropdown text color
                                        icon: Icon(Icons
                                            .arrow_drop_down), // Dropdown icon
                                        underline:
                                            Container(), // Remove underline
                                        // elevation: 0,
                                      ),
                                    ),
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
                                      reusableMessagedialog(context, 'Placment',
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
                                    });
                                  },
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
                                  reusabletextfieldcontroller.passCon,
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
                } else {
                  updateTutorPlacement();
                  isHomeWidgetVisible = false;
                }
              } else if (title == "At Tutor's Place") {
                checkbox3 = newValue ?? false;
                updateTutorPlacement();
              }
            });
          },
        ),
        reusableText(title, fontsize: 15),
      ],
    );
  }
}
