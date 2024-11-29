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
import 'package:fahad_tutor/res/reusablepassfield.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:fahad_tutor/views/dashboard/nav_bar.dart';
import 'package:fahad_tutor/views/dashboard/view_tuitions.dart';
import 'package:fahad_tutor/views/login/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _selectedValue = 'Tutor';
  TutorRepository repository = TutorRepository();

  late FocusNode _emailfocusNode;
  late FocusNode _passfocusNode;
  late FocusNode _buttonFocusNode;
  bool pass = true;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailfocusNode = FocusNode();
    _emailfocusNode.addListener(_onFocusChange);
    _passfocusNode = FocusNode();
    _passfocusNode.addListener(_onFocusChange);
    _buttonFocusNode = FocusNode();
    repository.get_Token();
  }

  @override
  void dispose() {
    _emailfocusNode.removeListener(_onFocusChange);
    _emailfocusNode.dispose();
    _passfocusNode.removeListener(_onFocusChange);
    _passfocusNode.dispose();
    _buttonFocusNode.dispose();
    super.dispose();
  }


  void _onFocusChange() {
    setState(() {
    });
  }


   void _validateForm() {
     if (reusabletextfieldcontroller.emailCon.text.isNotEmpty && reusabletextfieldcontroller.loginPassCon.text.isNotEmpty 
                        ) {
                  login();
                } else {
                  Utils.snakbar(
                    context,
                    reusabletextfieldcontroller.emailCon.text.isEmpty
                        ? "Email Is Missing"
                        : reusabletextfieldcontroller.loginPassCon.text.isEmpty
                            ? "Password Is Missing" : "Fill Correct Fields",
                  );
                }
  }

  // Future<void> saveAccount(String email, String password) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setString(email, password);
  // }

  // Future<String?> getPasswordForEmail(String email) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(email);
  // }

  // void _onEmailChanged(String email) async {
  //   final password = await getPasswordForEmail(email);
  //   if (password != null) {
  //     setState(() {
  //       reusabletextfieldcontroller.loginPassCon.text = password; // Auto-fill password
  //     });
  //   }
  // }

  Future<void> login()async{
    setState(() {
      isLoading = true;
    });
    try{
      // final email = reusabletextfieldcontroller.emailCon.text.toString();
      //   final password = reusabletextfieldcontroller.loginPassCon.text.toString();
      final response = await http.post(
      Uri.parse('${Utils.baseUrl}mobile_app/login.php'),
      body: {
        'cell_access_token': MySharedPrefrence().get_cell_token().toString(),
        'deviceid': '1'.toString(),
        'tu_email': reusabletextfieldcontroller.emailCon.text.toString(),
        'password': reusabletextfieldcontroller.loginPassCon.text.toString(),
      }
    );
    if (response.statusCode == 200) {
              final Map<String, dynamic> responseData =
                  json.decode(response.body);
                  print('response $responseData');
              String apiMessage = responseData['message'];
              if (responseData['success'] == 1) {
                setState(() {});
                // await saveAccount(email, password); // Save account on successful login
              print('message $apiMessage');
              MySharedPrefrence().setUserLoginStatus(true);
              MySharedPrefrence().set_user_ID(responseData['ID']);
              // MySharedPrefrence().set_profile_img(responseData['profile_img']);
              setState(() {});
              MySharedPrefrence().set_tutor_name(responseData['teacher_name']);
              setState(() {});
                print('Tutor ID ${MySharedPrefrence().get_user_ID()}');
                print('tutor status ${MySharedPrefrence().getUserLoginStatus()}');
                _fetchBasicInfo();
                // Navigator.pop(context);
                setState(() {
                  
                });
                    Navigator.pushReplacement(context,MaterialPageRoute(
          builder: (context) => WillPopScope(
            onWillPop: () async => false,
            child: NavBar(),
          ),
        ),
      );
                        Utils.snakbarSuccess(context, apiMessage);
              } else {
                Utils.snakbarFailed(context, apiMessage);
              }
            } else {
              print('Error2: ' + response.statusCode.toString());
            }
    
    }catch(e){
      Utils.snakbar(context, 'Check your Internet Connection');
      print('login Api Error $e');
    }finally{
      setState(() {isLoading = false;});
    }
  }

  // Function to fetch and save basic info
  Future<void> _fetchBasicInfo() async {
    setState(() {
      isLoading = true;
    });

    String userId = MySharedPrefrence().get_user_ID().toString();
    await repository.basicTutorInfo(userId);

    setState(() {
      isLoading = false;
    });
  }

  // Future<void> basicInfo()async{
  //   setState(() {
  //     isLoading = true;
  //   });
  //   try{
  //     final response = await http.get(
  //     Uri.parse('${Utils.baseUrl}mobile_app/step_1.php?code=10&tutor_id=${MySharedPrefrence().get_user_ID()}'),
  //   );
  //   if (response.statusCode == 200) {
  //             final Map<String, dynamic> responseData =
  //                 json.decode(response.body);
  //             MySharedPrefrence().set_info(responseData['info']);
  //             print('basic Info ${MySharedPrefrence().get_info()}');
  //             setState(() {});
  //           } else {
  //             print('Error2: ' + response.statusCode.toString());
  //           }
    
  //   }catch(e){
  //     print('Data Not Load $e');
  //   }finally{
  //     setState(() {isLoading = false;});
  //   }
  // }

  

TutorRepository _repository = TutorRepository();
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
                  Form(
                    key: _formKey,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                        fillColor: MaterialStateColor.resolveWith((states) =>
                            colorController
                                .blueColor), // Fill color when the radio button is selected
                        focusColor: colorController
                            .blueColor, // Border color when the radio button is focused
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: 'Tutor',
                        groupValue: _selectedValue,
                        // activeColor: MaterialStateColor.resolveWith(
                        //     (states) => colorController.blueColor),
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value!;
                          });
                        },
                      ),
                      reusableText('Tutor',
                          fontsize: 14, fontweight: FontWeight.w200),
                    ],
                                ),
                                reusablaSizaBox(context, .02),
                                reusableTextField(
                    context,
                    reusabletextfieldcontroller.emailCon,
                    'Email Address',
                    _emailfocusNode.hasFocus
                        ? colorController.blueColor
                        : colorController.textfieldBorderColorBefore,
                    _emailfocusNode,
                    () {
                      // _onEmailChanged;
                      _emailfocusNode.unfocus();
                      FocusScope.of(context).requestFocus(_passfocusNode);
                    }, 
                    // true,
                    // validateEmail, 
                    keyboardType: TextInputType.emailAddress,
                                ),
                                reusablaSizaBox(context, .04),
                                reusablePassField(
                      context,
                      reusabletextfieldcontroller.loginPassCon,
                      'Password',
                      _passfocusNode.hasFocus
                          ? colorController.blueColor
                          : colorController.textfieldBorderColorBefore,
                      _passfocusNode, () {
                    _passfocusNode.unfocus();
                    FocusScope.of(context).requestFocus(_buttonFocusNode);
                                },
                                // true,
                                pass,(){
                                  setState(() {
                                    pass = !pass;
                                  });
                                }),
                                reusablaSizaBox(context, .02),
                                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      reusableText('Forgot Password? ',
                          fontsize: 13,
                          color: colorController.grayTextColor,
                          fontweight: FontWeight.w400),
                      InkWell(
                        onTap: () {
                          launch('https://fahadtutors.com/login.php?Forgotten=0');
                        },
                        child: reusableText('Reset',
                            fontsize: 13,
                            color: colorController.blueColor,
                            fontweight: FontWeight.bold),
                      )
                    ],
                                ),
                                reusablaSizaBox(context, .02),
                                reusableBtn(context, 'Login',
                                (){
                                  _buttonFocusNode.unfocus();
                                  _validateForm();
                                }
                                ),
                                reusablaSizaBox(context, .03),
                                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      reusableText("Don't have an account? ",
                          fontsize: 13,
                          color: colorController.grayTextColor,
                          fontweight: FontWeight.w400),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Rigister(),
                                ));
                          },
                          child: reusableText('Register Now',
                              fontsize: 13,
                              color: colorController.blueColor,
                              fontweight: FontWeight.bold))
                    ],
                                ),
                                reusablaSizaBox(context, .03),
                                reusableBtn(context, 'View Tuitions',()async{
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewTuitions(),));
                                }),
                                reusablaSizaBox(context, .025),
                                Center(
                    child: InkWell(
                      onTap: () {
                        launch('https://fahadtutors.com/contact.php');
                      },
                      child: reusableText('Support',
                          fontsize: 13,
                          color: colorController.blueColor,
                          fontweight: FontWeight.bold),
                    ),
                                )
                              ]),
                  ),
            ),
          )),
          if(isLoading == true)
            reusableloadingrow(context, isLoading),
        ],
      ),
    );
  }
}
