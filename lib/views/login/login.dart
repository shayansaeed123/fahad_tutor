import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusableTextField.dart';
import 'package:fahad_tutor/res/reusablebtn.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:fahad_tutor/views/login/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailCon = TextEditingController();
  TextEditingController _passCon = TextEditingController();
  String? _selectedValue;

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
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                    height: MediaQuery.of(context).size.height * .12,
                  ),
                ),
              ],
            ),
            reusablaSizaBox(context, .03),
            reusableText('Welcome Back!',
                fontsize: 26, fontweight: FontWeight.bold),
                reusablaSizaBox(context, .01),
            reusableText(
              'Sign in to continue',
              color: colorController.textfieldBorderColorBefore,
              fontsize: 18,
            ),
            reusablaSizaBox(context, .01),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Radio<String>(
                  overlayColor: MaterialStateColor.resolveWith(
                      (states) => colorController.blueColor),
                  fillColor: MaterialStateColor.resolveWith((states) => colorController.blueColor), // Fill color when the radio button is selected
        focusColor: colorController.blueColor, // Border color when the radio button is focused
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  value: 'Option 3',
                  groupValue: _selectedValue,
                  // activeColor: MaterialStateColor.resolveWith(
                  //     (states) => colorController.blueColor),
                  onChanged: (value) {
                    setState(() {
                      _selectedValue = value;
                    });
                  },
                ),
                reusableText('Tutor', fontsize: 14, fontweight: FontWeight.w200),
              ],
            ),
            reusablaSizaBox(context, .02),
            reusableTextField(context ,_emailCon, 'Email Address', _emailfocusNode.hasFocus ? colorController.blueColor : colorController.textfieldBorderColorBefore,_emailfocusNode,keyboardType: TextInputType.emailAddress,),
            reusablaSizaBox(context, .04),
            reusableTextField(context, _passCon, 'Password',_passfocusNode.hasFocus ? colorController.blueColor : colorController.textfieldBorderColorBefore,_passfocusNode,keyboardType: TextInputType.text,obscureText: true),
            reusablaSizaBox(context, .02),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                reusableText('Forgot Password? ',fontsize: 13, color: colorController.grayTextColor,fontweight: FontWeight.w400),
                reusableText('Reset',fontsize: 13, color: colorController.blueColor,fontweight: FontWeight.bold)
              ],
            ),
            reusablaSizaBox(context, .02),
            reusableBtn(context, 'Login'),
            reusablaSizaBox(context, .03),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                reusableText("Don't have an account? ",fontsize: 13, color: colorController.grayTextColor,fontweight: FontWeight.w400),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Rigister(),));
                  },
                  child: reusableText('Register Now',fontsize: 13, color: colorController.blueColor,fontweight: FontWeight.bold))
              ],
            ),
            reusablaSizaBox(context, .03),
            reusableBtn(context, 'View Tuitions'),
            reusablaSizaBox(context, .025),
            Center(child: reusableText('Support',fontsize: 13, color: colorController.blueColor,fontweight: FontWeight.bold),)
          ]),
        ),
      )),
    );
  }
}
