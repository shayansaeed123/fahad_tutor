import 'dart:async';
import 'dart:convert';

import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusableTextField.dart';
import 'package:fahad_tutor/res/reusablebtn.dart';
import 'package:fahad_tutor/res/reusableloading.dart';
import 'package:fahad_tutor/res/reusableradiobtn.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:fahad_tutor/views/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class Rigister extends StatefulWidget {
  const Rigister({super.key});

  @override
  State<Rigister> createState() => _RigisterState();
}

class _RigisterState extends State<Rigister> {
  TextEditingController _teacherCon = TextEditingController();
  TextEditingController _fatherCon = TextEditingController();
  TextEditingController _contactCon = TextEditingController();
  TextEditingController _alterContactCon = TextEditingController();
  TextEditingController _cnicCon = TextEditingController();
  TextEditingController _passCon = TextEditingController();
  TextEditingController _rePassCon = TextEditingController();
  TextEditingController _religionCon = TextEditingController();

  // TextEditingController _selectDateCon = TextEditingController();
  String _selectedValue = 'Tutor';
  String? _selectedCountry;
  String? _selectedCity;
  String? _selectedArea;
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
  bool checkbox1 = false;
  bool checkbox2 = false;
  bool checkbox3 = false;

  List<dynamic> countryList = [];
  List<dynamic> cityList = [];
  List<dynamic> areaList=[];
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
    checkAccount();
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
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      // Redraw the UI when the focus changes
    });
  }

  Future<void> selectCountry() async {
    setState(() {
        isLoading = true;
      });

    try{
      final response = await http.get(
      Uri.parse('https://fahadtutors.com/mobile_app/country.php?code=10'),
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
    }catch(e){
      print(e);
    }finally{
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> selectCity() async {
    setState(() {
        isLoading = true;
      });
    try{
      final response = await http.post(
      Uri.parse('https://fahadtutors.com/mobile_app/city.php'),
      body: {
        'code': '10',
        'country_id': countryId.toString(),
      }
    );
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
    }catch(e){
      print(e);
    }finally{
      setState(() {isLoading = false;});
    }
  }

  Future<void> selectArea() async {
    setState(() {
      isLoading = true;
    });
    try{
      final response = await http.post(
      Uri.parse('https://fahadtutors.com/mobile_app/area.php'),
      body: {
        'code': '10',
        'city_id': cityId.toString(),
      }
    );
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
    }catch(e){
      print(e);
    }finally{
      setState(() {isLoading = false;});
    }
  }

  Future<Map<String, dynamic>> checkAccount()async{
    setState(() {
      isLoading = true;
    });
    // try{
      final response = await http.post(
      Uri.parse('https://fahadtutors.com/mobile_app/acoount_check.php'),
      body: {
        'contact_number': _contactCon.text.toString(),
        'cnic': _cnicCon.text.toString(),
        'alternate_number': _alterContactCon.text.toString(),
        'email': _teacherCon.text.toString(),
      }
    );
    if (response.statusCode == 200) {
      // if (response.body.isNotEmpty) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        // areaList = jsonResponse['area_listing'];
        // if (areaList.isNotEmpty) {
          setState(() {
            // areaName = areaList[0]['area_name'];
            // countryId = countryList[0]['c_id'];
            print(jsonResponse);
            print(jsonResponse);
          });
          
          return jsonResponse;
        // } else {
        //   throw Exception('Area list is empty');
        // }
      // } else {
      //   throw Exception('Empty response body');
      // }
      
    } else {
      
      throw Exception('Failed to load country details');
    }
    // }catch(e){
    //   print(e);
    // }finally{
    //   setState(() {isLoading = false;});
    // }
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
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                  'Tutor', // Name of the second radio button
                ),
                _selectedValue == 'Tutor'
                    ? Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * .01),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * .055,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey, width: 1.5), // Border color
                              borderRadius: BorderRadius.circular(10.0),
                              // Border radius
                            ),
                            child: DropdownButton<dynamic>(
                              value: countryLists,
                              onChanged: (dynamic newValue) {
            setState(() {
              countryLists = newValue;
              countryId = newValue.toString();
              isCityDropdownEnabled = true;
            });
            selectCity(); // Call selectCity function here
          },
                              // (dynamic newValue) {
                              //   setState(() {
                              //     countryLists = newValue;
                              //     countryId = newValue['c_id'].toString(); // Assuming 'c_id' is the key for the country ID
                              //         isCityDropdownEnabled = true;
                              //   });
                              //   // selectCity(countryId.toString());
                              //   print('Selected class ID: ${newValue['c_id']}');
                              //   print('Selected class Name: ${newValue['c_name']}');
                              //   print('object $countryId');
                              //   // selectCity();
                              // },
                              hint: reusableText(
                                'Select Country',
                                color: colorController.grayTextColor,
                                fontsize: 14,
                              ),
                              items: countryList.map((dynamic country) {
                                return DropdownMenuItem<dynamic>(
                                    value: country['c_id'].toString(),
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width * .81,
                                        child: reusableText(country['c_name'],
                                            color: colorController.grayTextColor,
                                            fontsize: 14)));
                              }).toList(),
                              style: TextStyle(
                                  color: Colors.black), // Dropdown text color
                              icon: Icon(Icons.arrow_drop_down), // Dropdown icon
                              underline: Container(), // Remove underline
                            ),
                          ),
                          reusablaSizaBox(context, .015),
                          Container(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * .01),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * .055,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey, width: 1.5), // Border color
                              borderRadius:
                                  BorderRadius.circular(10.0), // Border radius
                            ),
                            child: DropdownButton<dynamic>(
                              value: cityLists,
                              onChanged: isCityDropdownEnabled ? (dynamic newValue) {
              setState(() {
          cityLists = newValue;
          cityId = newValue['c_id'].toString();
          isAreaDropdownEnabled = true;
              });
              print('Selected city ID: ${newValue['c_id']}');
              print('Selected city Name: ${newValue['c_name']}');
              selectArea();
            } : null,
                              // onChanged: (dynamic newValue) {
                              //   setState(() {
                              //     cityLists = newValue;
                              //     cityId = newValue['c_id'].toString();
                              //   });
                              //   print('Selected class ID: ${newValue['c_id']}');
                              //   print('Selected class Name: ${newValue['c_name']}');
                              //   // print('object $cityId');
                              // },
                              hint: reusableText('Select City',
                                  color: colorController.grayTextColor,
                                  fontsize: 14),
                              items: cityList.map((dynamic city) {
                                return DropdownMenuItem<dynamic>(
                                    value: city,
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width * .81,
                                        child: reusableText(city['c_name'],
                                            color: colorController.grayTextColor,
                                            fontsize: 14)));
                              }).toList(),
                              style: TextStyle(
                                  color: Colors.black), // Dropdown text color
                              icon: Icon(Icons.arrow_drop_down), // Dropdown icon
                              underline: Container(), // Remove underline
                              elevation: 0,
                            ),
                          ),
                          reusablaSizaBox(context, .015),
                          reusableTextField(
                            context,
                            _teacherCon,
                            'Teacher Name',
                            _teacherfocusNode.hasFocus
                                ? colorController.blueColor
                                : colorController.textfieldBorderColorBefore,
                            _teacherfocusNode,
                            () {
                              _teacherfocusNode.unfocus();
                              FocusScope.of(context).requestFocus(_fatherfocusNode);
                            },
                            keyboardType: TextInputType.text,
                          ),
                          reusablaSizaBox(context, .015),
                          reusableTextField(
                            context,
                            _fatherCon,
                            'Father/Husband Name',
                            _fatherfocusNode.hasFocus
                                ? colorController.blueColor
                                : colorController.textfieldBorderColorBefore,
                            _fatherfocusNode,
                            () {
                              _fatherfocusNode.unfocus();
                              FocusScope.of(context)
                                  .requestFocus(_contactfocusNode);
                            },
                            keyboardType: TextInputType.text,
                          ),
                          reusablaSizaBox(context, .015),
                          reusableTextField(
                            context,
                            _contactCon,
                            'Contact No',
                            _contactfocusNode.hasFocus
                                ? colorController.blueColor
                                : colorController.textfieldBorderColorBefore,
                            _contactfocusNode,
                            () {
                              _contactfocusNode.unfocus();
                              FocusScope.of(context)
                                  .requestFocus(_alterContactfocusNode);
                            },
                            keyboardType: TextInputType.phone,
                          ),
                          reusablaSizaBox(context, .015),
                          reusableTextField(
                            context,
                            _alterContactCon,
                            'Alternate Contact No',
                            _alterContactfocusNode.hasFocus
                                ? colorController.blueColor
                                : colorController.textfieldBorderColorBefore,
                            _alterContactfocusNode,
                            () {
                              _alterContactfocusNode.unfocus();
                              FocusScope.of(context).requestFocus(_cnicfocusNode);
                            },
                            keyboardType: TextInputType.phone,
                          ),
                          reusablaSizaBox(context, .015),
                          reusableTextField(
                            context,
                            _cnicCon,
                            'CNIC',
                            _cnicfocusNode.hasFocus
                                ? colorController.blueColor
                                : colorController.textfieldBorderColorBefore,
                            _cnicfocusNode,
                            () {
                              _cnicfocusNode.unfocus();
                              FocusScope.of(context).requestFocus(_passfocusNode);
                            },
                            keyboardType: TextInputType.number,
                          ),
                          reusablaSizaBox(context, .015),
                          reusableTextField(
                              context,
                              _passCon,
                              'Password',
                              _passfocusNode.hasFocus
                                  ? colorController.blueColor
                                  : colorController.textfieldBorderColorBefore,
                              _passfocusNode, () {
                            _passfocusNode.unfocus();
                            FocusScope.of(context).requestFocus(_rePassfocusNode);
                          }, keyboardType: TextInputType.text, obscureText: true),
                          reusablaSizaBox(context, .015),
                          reusableTextField(
                              context,
                              _rePassCon,
                              'Re Enter Password',
                              _rePassfocusNode.hasFocus
                                  ? colorController.blueColor
                                  : colorController.textfieldBorderColorBefore,
                              _rePassfocusNode, () {
                            _rePassfocusNode.unfocus();
                            FocusScope.of(context).requestFocus(_religionfocusNode);
                          }, keyboardType: TextInputType.text, obscureText: true),
                          reusablaSizaBox(context, .015),
                          reusableTextField(
                            context,
                            _religionCon,
                            'Religion',
                            _religionfocusNode.hasFocus
                                ? colorController.blueColor
                                : colorController.textfieldBorderColorBefore,
                            _religionfocusNode,
                            () {
                              _religionfocusNode.unfocus();
                              FocusScope.of(context).requestFocus(_homefocusNode);
                            },
                            keyboardType: TextInputType.text,
                          ),
                          reusablaSizaBox(context, .015),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * .055,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: colorController.grayTextColor,
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(10)),
                            child: InkWell(
                                onTap: () async {
                                  final DateTime? timeofday = await showDatePicker(
                                      context: context,
                                      firstDate: selectedTime,
                                      lastDate: selectedTime,
                                      initialEntryMode:
                                          DatePickerEntryMode.calendar);
                                  if (timeofday != null) {
                                    setState(() {
                                      selectedTime = timeofday;
                                    });
                                  }
                                },
                                child: ListTile(
                                  enabled: false,
                                  trailing: Icon(Icons.date_range_outlined),
                                  title: Text(
                                    selectedTime == DateTime.now()
                                        ? 'Select Date'
                                        : '${DateFormat('yyyy-MM-dd').format(selectedTime)}',
                                    style: TextStyle(
                                        color: colorController.grayTextColor,
                                        fontSize: 14),
                                  ),
                                )),
                          ),
                          reusablaSizaBox(context, .015),
                          Container(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * .01),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * .055,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey, width: 1.5), // Border color
                              borderRadius:
                                  BorderRadius.circular(10.0), // Border radius
                            ),
                            child: DropdownButton<dynamic>(
                              value: areaLists,
                              onChanged: isAreaDropdownEnabled ? (dynamic newValue) {
              setState(() {
          areaLists = newValue;
          areaId = newValue['c_id'].toString();
              });
              print('Selected Area ID: ${newValue['id']}');
              print('Selected Area Name: ${newValue['area_name']}');
            } : null,
                              hint: reusableText('Select Area',
                                  color: colorController.grayTextColor,
                                  fontsize: 14),
                              items: areaList.map((dynamic area) {
                                return DropdownMenuItem<dynamic>(
                                  value: area,
                                  child: Container(
                                      width:
                                          MediaQuery.of(context).size.width * .81,
                                      child: reusableText(area['area_name'].toString(),
                                          color: colorController.grayTextColor,
                                          fontsize: 14)),
                                  // Display 'Select value' if value is null
                                );
                              }).toList(),
                              style: TextStyle(
                                  color: Colors.black), // Dropdown text color
                              icon: Icon(Icons.arrow_drop_down), // Dropdown icon
                              underline: Container(), // Remove underline
                              elevation: 0,
                            ),
                          ),
                          reusablaSizaBox(context, .015),
                          reusableTextField(
                            context,
                            _religionCon,
                            'Home Address',
                            _homefocusNode.hasFocus
                                ? colorController.blueColor
                                : colorController.textfieldBorderColorBefore,
                            _homefocusNode,
                            () {
                              _homefocusNode.unfocus();
                              FocusScope.of(context).requestFocus(_homefocusNode);
                            },
                            keyboardType: TextInputType.text,
                          ),
                          reusablaSizaBox(context, .015),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width * .01),
                                width: MediaQuery.of(context).size.width * .43,
                                height: MediaQuery.of(context).size.height * .055,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey,
                                      width: 1.5), // Border color
                                  borderRadius:
                                      BorderRadius.circular(10.0), // Border radius
                                ),
                                child: DropdownButton<String>(
                                  value: _selectedArea,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedArea = newValue;
                                    });
                                  },
                                  hint: reusableText('Gender',
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
                                          width: MediaQuery.of(context).size.width *
                                              .3,
                                          child: reusableText(value,
                                              color: colorController.grayTextColor,
                                              fontsize: 14)),
                                      // Display 'Select value' if value is null
                                    );
                                  }).toList(),
                                  style: TextStyle(
                                      color: Colors.black), // Dropdown text color
                                  icon:
                                      Icon(Icons.arrow_drop_down), // Dropdown icon
                                  underline: Container(), // Remove underline
                                  elevation: 0,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width * .01),
                                width: MediaQuery.of(context).size.width * .42,
                                height: MediaQuery.of(context).size.height * .055,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey,
                                      width: 1.5), // Border color
                                  borderRadius:
                                      BorderRadius.circular(10.0), // Border radius
                                ),
                                child: DropdownButton<String>(
                                  value: _selectedArea,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedArea = newValue;
                                    });
                                  },
                                  hint: reusableText('Marital Status',
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
                                          width: MediaQuery.of(context).size.width *
                                              .3,
                                          child: reusableText(value,
                                              color: colorController.grayTextColor,
                                              fontsize: 14)),
                                      // Display 'Select value' if value is null
                                    );
                                  }).toList(),
                                  style: TextStyle(
                                      color: Colors.black), // Dropdown text color
                                  icon:
                                      Icon(Icons.arrow_drop_down), // Dropdown icon
                                  underline: Container(), // Remove underline
                                  elevation: 0,
                                ),
                              ),
                            ],
                          ),
                          reusablaSizaBox(context, .03),
                          reusableText('Tutors Placment', fontsize: 21),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buildCheckboxWithTitle('Home', checkbox1),
                              buildCheckboxWithTitle('Online', checkbox2),
                            ],
                          ),
                          buildCheckboxWithTitle("At Tutor's Place", checkbox3),
                          reusablaSizaBox(context, .02),
                          reusableBtn(context, 'Register'),
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
                      )
                    : Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * .01),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * .055,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey, width: 1.5), // Border color
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
                                      width:
                                          MediaQuery.of(context).size.width * .81,
                                      child: reusableText(value,
                                          color: colorController.grayTextColor,
                                          fontsize: 14)),
                                  // Display 'Select value' if value is null
                                );
                              }).toList(),
                              style: TextStyle(
                                  color: Colors.black), // Dropdown text color
                              icon: Icon(Icons.arrow_drop_down), // Dropdown icon
                              underline: Container(), // Remove underline
                              // elevation: 0,
                            ),
                          ),
                          reusablaSizaBox(context, .015),
                          Container(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * .01),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * .055,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey, width: 1.5), // Border color
                              borderRadius:
                                  BorderRadius.circular(10.0), // Border radius
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
                                'Option 4'
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Container(
                                      width:
                                          MediaQuery.of(context).size.width * .81,
                                      child: reusableText(value,
                                          color: colorController.grayTextColor,
                                          fontsize: 14)),
                                  // Display 'Select value' if value is null
                                );
                              }).toList(),
                              style: TextStyle(
                                  color: Colors.black), // Dropdown text color
                              icon: Icon(Icons.arrow_drop_down), // Dropdown icon
                              underline: Container(), // Remove underline
                              elevation: 0,
                            ),
                          ),
                          reusablaSizaBox(context, .015),
                          reusableTextField(
                            context,
                            _teacherCon,
                            'Name',
                            _teacherfocusNode.hasFocus
                                ? colorController.blueColor
                                : colorController.textfieldBorderColorBefore,
                            _teacherfocusNode,
                            () {
                              _teacherfocusNode.unfocus();
                              FocusScope.of(context)
                                  .requestFocus(_contactfocusNode);
                            },
                            keyboardType: TextInputType.text,
                          ),
                          reusablaSizaBox(context, .015),
                          reusableTextField(
                            context,
                            _contactCon,
                            'Contact No',
                            _contactfocusNode.hasFocus
                                ? colorController.blueColor
                                : colorController.textfieldBorderColorBefore,
                            _contactfocusNode,
                            () {
                              _contactfocusNode.unfocus();
                              FocusScope.of(context).requestFocus(_passfocusNode);
                            },
                            keyboardType: TextInputType.phone,
                          ),
                          reusablaSizaBox(context, .015),
                          reusableTextField(
                              context,
                              _passCon,
                              'Password',
                              _passfocusNode.hasFocus
                                  ? colorController.blueColor
                                  : colorController.textfieldBorderColorBefore,
                              _passfocusNode, () {
                            _passfocusNode.unfocus();
                            FocusScope.of(context).requestFocus(_passfocusNode);
                          }, keyboardType: TextInputType.text, obscureText: true),
                          reusablaSizaBox(context, .02),
                          reusableBtn(context, 'Register'),
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
          if(isLoading == true)
            reusableloadingrow(context, isLoading),
        ],
      ),
    );
  }

  Widget buildCheckboxWithTitle(String title, bool value) {
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
                checkbox1 = newValue ?? false;
              } else if (title == 'Online') {
                checkbox2 = newValue ?? false;
              } else if (title == "At Tutor's Place") {
                checkbox3 = newValue ?? false;
              }
            });
          },
        ),
        reusableText(title, fontsize: 15),
      ],
    );
  }
}
