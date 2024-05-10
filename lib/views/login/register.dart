import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusableTextField.dart';
import 'package:fahad_tutor/res/reusablebtn.dart';
import 'package:fahad_tutor/res/reusableradiobtn.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:fahad_tutor/views/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

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

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorController.whiteColor,
      body: SafeArea(
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
                        child: DropdownButton<String>(
                          value: _selectedArea,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedArea = newValue;
                            });
                          },
                          hint: reusableText('Select Area',
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
