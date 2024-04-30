import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusableTextField.dart';
import 'package:fahad_tutor/res/reusablebtn.dart';
import 'package:fahad_tutor/res/reusableradiobtn.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Rigister extends StatefulWidget {
  const Rigister({super.key});

  @override
  State<Rigister> createState() => _RigisterState();
}

class _RigisterState extends State<Rigister> {
  TextEditingController _emailCon = TextEditingController();
  TextEditingController _passCon = TextEditingController();
  String? _selectedValue;
  String? _selectedItem;

  late FocusNode _emailfocusNode;
  late FocusNode _passfocusNode;

  @override
  void initState() {
    super.initState();
    _emailfocusNode = FocusNode();
    _emailfocusNode.addListener(_onFocusChange);
    _passfocusNode = FocusNode();
    _passfocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _emailfocusNode.removeListener(_onFocusChange);
    _emailfocusNode.dispose();
    _passfocusNode.removeListener(_onFocusChange);
    _passfocusNode.dispose();
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
                    'assets/images/logo1.png',
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
            Container(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * .01),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .055,
              decoration: BoxDecoration(
                border:
                    Border.all(color: Colors.grey, width: 1.5), // Border color
                borderRadius: BorderRadius.circular(10.0),
                // Border radius
              ),
              child: DropdownButton<String>(
                value: _selectedItem,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedItem = newValue;
                  });
                },
                hint: reusableText('Select Country',
                    color: colorController.grayTextColor, fontsize: 14),
                items: <String>['Option 1', 'Option 2', 'Option 3', 'Option 4']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Container(
                        width: MediaQuery.of(context).size.width * .81,
                        child: reusableText(value,
                            color: colorController.grayTextColor,
                            fontsize: 14)),
                    // Display 'Select value' if value is null
                  );
                }).toList(),
                style: TextStyle(color: Colors.black), // Dropdown text color
                icon: Icon(Icons.arrow_drop_down), // Dropdown icon
                underline: Container(), // Remove underline
                elevation: 0,
              ),
            ),
            reusablaSizaBox(context, .015),
            Container(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * .01),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .055,
              decoration: BoxDecoration(
                border:
                    Border.all(color: Colors.grey, width: 1.5), // Border color
                borderRadius: BorderRadius.circular(10.0), // Border radius
              ),
              child: DropdownButton<String>(
                value: _selectedItem,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedItem = newValue;
                  });
                },
                hint: reusableText('Select City',
                    color: colorController.grayTextColor, fontsize: 14),
                items: <String>['Option 1', 'Option 2', 'Option 3', 'Option 4']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Container(
                        width: MediaQuery.of(context).size.width * .81,
                        child: reusableText(value,
                            color: colorController.grayTextColor,
                            fontsize: 14)),
                    // Display 'Select value' if value is null
                  );
                }).toList(),
                style: TextStyle(color: Colors.black), // Dropdown text color
                icon: Icon(Icons.arrow_drop_down), // Dropdown icon
                underline: Container(), // Remove underline
                elevation: 0,
              ),
            ),
            reusablaSizaBox(context, .015),
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .055,
                child: reusableTextField(
                  context,
                  _emailCon,
                  'Teacher Name',
                  _emailfocusNode.hasFocus
                      ? colorController.blueColor
                      : colorController.textfieldBorderColorBefore,
                  _emailfocusNode,
                  keyboardType: TextInputType.emailAddress,
                ))
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: [
            //     Radio<String>(
            //       value: 'Option 3',
            //       groupValue: _selectedValue,
            //       activeColor: MaterialStateColor.resolveWith(
            //           (states) => colorController.blueColor),
            //       onChanged: (value) {
            //         setState(() {
            //           _selectedValue = value;
            //         });
            //       },
            //     ),
            //     reusableText('Tutor', fontsize: 16, fontweight: FontWeight.w200),
            //   ],
            // ),
            // reusablaSizaBox(context, .02),
            // reusableTextField(context ,_emailCon, 'Email Address', _emailfocusNode.hasFocus ? colorController.blueColor : colorController.textfieldBorderColorBefore,_emailfocusNode,keyboardType: TextInputType.emailAddress,),
            // reusablaSizaBox(context, .04),
            // reusableTextField(context, _passCon, 'Password',_passfocusNode.hasFocus ? colorController.blueColor : colorController.textfieldBorderColorBefore,_passfocusNode,),
            // reusablaSizaBox(context, .02),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     reusableText('Forgot Password ',fontsize: 13, color: colorController.grayTextColor,fontweight: FontWeight.w400),
            //     reusableText('Reset',fontsize: 13, color: colorController.blueColor,fontweight: FontWeight.bold)
            //   ],
            // ),
            // reusablaSizaBox(context, .02),
            // reusableBtn(context, 'Login'),
            // reusablaSizaBox(context, .03),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     reusableText("Don't have an account? ",fontsize: 13, color: colorController.grayTextColor,fontweight: FontWeight.w400),
            //     reusableText('Register Now',fontsize: 13, color: colorController.blueColor,fontweight: FontWeight.bold)
            //   ],
            // ),
            // reusablaSizaBox(context, .03),
            // reusableBtn(context, 'View Tuitions'),
            // reusablaSizaBox(context, .025),
            // Center(child: reusableText('Support',fontsize: 13, color: colorController.blueColor,fontweight: FontWeight.bold),)
          ]),
        ),
      )),
    );
  }
}
