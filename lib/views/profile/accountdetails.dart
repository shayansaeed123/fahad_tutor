import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
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
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:fahad_tutor/res/reusablevisibility.dart';
import 'package:fahad_tutor/views/profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AccountDetails extends StatefulWidget {
  const AccountDetails({super.key});

  @override
  State<AccountDetails> createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  bool isLoading = false;
  late FocusNode _title;
  late FocusNode _bankname;
  late FocusNode _branchcode;
  late FocusNode _accountnumber;
  late FocusNode _ibannumber;
  late FocusNode _accounttitle;
  late FocusNode _mobilenumber;
  String methodValue = '';
  bool visible = true;
  TutorRepository repository = TutorRepository();
   String update_status= '';
  String Bank_Name = '';
  String Title = '';
  String Branch_Code = '';
  String Account_Number = '';
  String IBAN_Pptional = '';
  String Easy_Paisa_Mobile = '';
  String Easy_Paisa_Title = '';
  String easypesa_bank = '';

  @override
  void initState() {
    super.initState();
    _title = FocusNode();
    _title.addListener(_onFocusChange);
    _bankname = FocusNode();
    _bankname.addListener(_onFocusChange);
    _branchcode = FocusNode();
    _branchcode.addListener(_onFocusChange);
    _accountnumber = FocusNode();
    _accountnumber.addListener(_onFocusChange);
    _ibannumber = FocusNode();
    _ibannumber.addListener(_onFocusChange);
    _accounttitle = FocusNode();
    _accounttitle.addListener(_onFocusChange);
    _mobilenumber = FocusNode();
    _mobilenumber.addListener(_onFocusChange);
    repository.check_msg();
      getData();
  }
  void getData() async {
    await getAccountDetails();
    setState(() {
      reusabletextfieldcontroller.title.text = Title;
      reusabletextfieldcontroller.bankname.text = Bank_Name;
      reusabletextfieldcontroller.branchcode.text = Branch_Code;
      reusabletextfieldcontroller.accountnumber.text = Account_Number;
      reusabletextfieldcontroller.ibannumber.text = IBAN_Pptional;
      reusabletextfieldcontroller.accounttitle.text = easypesa_bank;
      reusabletextfieldcontroller.mobilenumber.text = Easy_Paisa_Mobile;

      reusabletextfieldcontroller.title.addListener(_updateTitle);
      reusabletextfieldcontroller.bankname.addListener(_updateTitle);
      reusabletextfieldcontroller.branchcode.addListener(_updateTitle);
      reusabletextfieldcontroller.accountnumber.addListener(_updateTitle);
      reusabletextfieldcontroller.ibannumber.addListener(_updateTitle);
      reusabletextfieldcontroller.accounttitle.addListener(_updateTitle);
      reusabletextfieldcontroller.mobilenumber.addListener(_updateTitle);
    });
  }
  @override
  void dispose() {
    _title.removeListener(_onFocusChange);
    _title.dispose();
    _bankname.removeListener(_onFocusChange);
    _bankname.dispose();
    _branchcode.removeListener(_onFocusChange);
    _branchcode.dispose();
    _accountnumber.removeListener(_onFocusChange);
    _accountnumber.dispose();
    _ibannumber.removeListener(_onFocusChange);
    _ibannumber.dispose();
    _accounttitle.removeListener(_onFocusChange);
    _accounttitle.dispose();
    _mobilenumber.removeListener(_onFocusChange);
    _mobilenumber.dispose();
    reusabletextfieldcontroller.title.removeListener(_updateTitle);
    reusabletextfieldcontroller.bankname.removeListener(_updateTitle);
    reusabletextfieldcontroller.branchcode.removeListener(_updateTitle);
    reusabletextfieldcontroller.accountnumber.removeListener(_updateTitle);
    reusabletextfieldcontroller.accounttitle.removeListener(_updateTitle);
    reusabletextfieldcontroller.ibannumber.removeListener(_updateTitle);
    reusabletextfieldcontroller.mobilenumber.removeListener(_updateTitle);
    super.dispose();
  }
  void _onFocusChange() {setState(() {});}
  void _updateTitle() {
    if (mounted) {
      setState(() {
        Title = reusabletextfieldcontroller.title.text;
         Bank_Name = reusabletextfieldcontroller.bankname.text;
        Branch_Code = reusabletextfieldcontroller.branchcode.text;
        Account_Number = reusabletextfieldcontroller.accountnumber.text;
        IBAN_Pptional = reusabletextfieldcontroller.ibannumber.text;
        Easy_Paisa_Mobile = reusabletextfieldcontroller.mobilenumber.text;
        easypesa_bank = reusabletextfieldcontroller.accounttitle.text;
      });
    }
  }

   Future<void> loadBanks() async {
    try {
      final banks = await fetchBanks();
      setState(() {
        _banks = banks;
      });
    } catch (e) {
      print('Error loading banks: $e');
    }
  }

  // void _validateForm() {
  //    if (
  //     reusabletextfieldcontroller.title.text.isNotEmpty && 
  //     reusabletextfieldcontroller.bankname.text.isNotEmpty && 
  //     reusabletextfieldcontroller.branchcode.text.isNotEmpty && 
  //     reusabletextfieldcontroller.accountnumber.text.isNotEmpty && 
  //     reusabletextfieldcontroller.ibannumber.text.isNotEmpty && 
  //     reusabletextfieldcontroller.mobilenumber.text.isNotEmpty && 
  //     methodValue.isNotEmpty && 
  //     reusabletextfieldcontroller.accounttitle.text.isNotEmpty
      

  //                       ) {
  //                 updateAccountDetails();
  //               } else {
  //                 Utils.snakbar(
  //                   context,
  //                   reusabletextfieldcontroller.title.text.isEmpty
  //                       ? "Title Is Missing"
  //                       : reusabletextfieldcontroller.bankname.text.isEmpty
  //                           ? "Bank Name Is Missing" :
  //                           reusabletextfieldcontroller.branchcode.text.isEmpty
  //                           ? "Branch Code Is Missing" :
  //                           reusabletextfieldcontroller.accountnumber.text.isEmpty
  //                           ? "Account Number Is Missing" :
  //                           reusabletextfieldcontroller.ibannumber.text.isEmpty
  //                           ? "IBAN Number Is Missing" :
  //                           reusabletextfieldcontroller.mobilenumber.text.isEmpty
  //                           ? "Mobile Number Is Missing" :
  //                           methodValue.isEmpty
  //                           ? "Payment Method Is Missing" :
  //                           reusabletextfieldcontroller.accounttitle.text.isEmpty
  //                           ? "Account Title Is Missing" :
  //                            "Fill Correct Fields",
  //                 );
  //               }
  // }

  Future<void> updateAccountDetails()async{
    setState(() {
      isLoading = true;
    });
    try{
      
      final response = await http.post(
      Uri.parse('${MySharedPrefrence().get_baseUrl()}step_6_update.php'),
      body: {
        'code' : '10'.toString(),
        'tutor_id' : MySharedPrefrence().get_user_ID().toString(),
        'Title' : reusabletextfieldcontroller.title.text.toString(),
        'bank_n': reusabletextfieldcontroller.bankname.text.toString(),
        'Branch_Code': reusabletextfieldcontroller.branchcode.text.toString(),
        'Account_Number': reusabletextfieldcontroller.accountnumber.text.toString(),
        'IBAN': reusabletextfieldcontroller.ibannumber.text.toString(),
        'Easy_p': reusabletextfieldcontroller.mobilenumber.text.toString(),
        'Titlee': methodValue.toString(),
        'easypesa_bank': reusabletextfieldcontroller.accounttitle.text.toString(),
      }
    );
    if (response.statusCode == 200) {
      print('object');
              final Map<String, dynamic> responseData =
                  json.decode(response.body);
                  print('response $responseData');
              String apiMessage = responseData['message'];
              print('message $apiMessage');
              if (responseData['success'] == 1) {
                setState(() {});
              print('message $apiMessage');
              // Navigator.pop(context);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Profile(),));
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

  Future<void> getAccountDetails() async {
  setState(() {
    isLoading = true;
  });
  try {
    final userId = MySharedPrefrence().get_user_ID().toString();
    print('Fetching data for user ID: $userId');
    final response = await http.get(
      Uri.parse('${MySharedPrefrence().get_baseUrl()}step_6.php?code=10&tutor_id=$userId')
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      update_status = responseData['update_status'];
      print(responseData);
      Bank_Name = responseData['Bank_Name'];
      Title = responseData['Title'];
      Branch_Code = responseData['Branch_Code'];
      Account_Number = responseData['Account_Number'];
      IBAN_Pptional = responseData['IBAN_Pptional'];
      Easy_Paisa_Mobile = responseData['Easy_Paisa_Mobile'];
      Easy_Paisa_Title = responseData['Easy_Paisa_Title'];
      easypesa_bank = responseData['easypesa_bank'];
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
    return reusableprofileidget(context,
      Padding(padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .032),
                  child: 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          reusableText("Account Details",color: colorController.blackColor,fontsize: 23,fontweight: FontWeight.bold),
                          reusablaSizaBox(context, 0.020),
                          ValueListenableBuilder(valueListenable: repository.popup, builder: (context, value, child) {
              if(value == 1){
                return reusableVisiblityMesage(context, MySharedPrefrence().get_popup_text(), (){setState(() {visible=false;});}, visible);
                }else{return Container();}},),
                reusablaSizaBox(context, 0.020),
                          reusableTextField(context, 
                          reusabletextfieldcontroller.title,'Title', _title.hasFocus
                        ? colorController.blueColor
                        : colorController.textfieldBorderColorBefore, _title, () {
                      _title.unfocus();
                      FocusScope.of(context).requestFocus(_bankname);
                    }, ),
                    reusablaSizaBox(context, 0.020),
                    reusableTextField(context, 
                          reusabletextfieldcontroller.bankname, 'Bank Name', _bankname.hasFocus
                        ? colorController.blueColor
                        : colorController.textfieldBorderColorBefore, _bankname, () {
                      _bankname.unfocus();
                      FocusScope.of(context).requestFocus(_branchcode);
                    }, ),
                    reusablaSizaBox(context, 0.020),
                    reusableTextField(context, 
                          reusabletextfieldcontroller.branchcode, 'Branch Code', _branchcode.hasFocus
                        ? colorController.blueColor
                        : colorController.textfieldBorderColorBefore, _branchcode, () {
                      _branchcode.unfocus();
                      FocusScope.of(context).requestFocus(_accountnumber);
                    }, ),
                    reusablaSizaBox(context, 0.020),
                    reusableTextField(context, 
                          reusabletextfieldcontroller.accountnumber, 'Account Number', _accountnumber.hasFocus
                        ? colorController.blueColor
                        : colorController.textfieldBorderColorBefore, _accountnumber, () {
                      _accountnumber.unfocus();
                      FocusScope.of(context).requestFocus(_ibannumber);
                    }, ),
                    reusablaSizaBox(context, 0.020),
                    reusableTextField(context, 
                          reusabletextfieldcontroller.ibannumber, 'IBAN Number', _ibannumber.hasFocus
                        ? colorController.blueColor
                        : colorController.textfieldBorderColorBefore, _ibannumber, () {
                      _ibannumber.unfocus();
                      FocusScope.of(context).requestFocus(_accounttitle);
                    }, ),
                    reusablaSizaBox(context, 0.020),
                    Center(child: reusableText('OR',color: colorController.grayTextColor,fontsize: 16,fontweight: FontWeight.bold)),
                    reusablaSizaBox(context, 0.020),
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
                                  DropdownSearch<String>(
  popupProps: PopupPropsMultiSelection.dialog(
    fit: FlexFit.loose,
    showSearchBox: true,
    dialogProps: DialogProps(
      backgroundColor: colorController.whiteColor,
      elevation: 10,
    ),
    searchFieldProps: TextFieldProps(
      decoration: InputDecoration(
        hintText: 'Search...',
        hintStyle: TextStyle(color: colorController.blackColor,fontSize: 12.5),
        fillColor: colorController.whiteColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
        ),
      ),
    ),
  ),
  dropdownDecoratorProps: DropDownDecoratorProps(
    dropdownSearchDecoration: InputDecoration(
      hintText: methodValue.isEmpty ? 'Select Method' : methodValue,
      hintStyle: TextStyle(color: colorController.grayTextColor,fontSize: 11.5),
      border: InputBorder.none,
    ),
  ),
  items: <String>['Jazz Cash', 'Easypaisa'],
  onChanged: (String? newValue) {
    setState(() {
      methodValue = newValue ?? '';
      print(methodValue);
    });
  },
  selectedItem: methodValue.isNotEmpty ? methodValue : null,
)

                                ),
                                reusablaSizaBox(context, 0.020),
                    reusableTextField(context, 
                          reusabletextfieldcontroller.accounttitle, 'Account Title', _accounttitle.hasFocus
                        ? colorController.blueColor
                        : colorController.textfieldBorderColorBefore, _accounttitle, () {
                      _accounttitle.unfocus();
                      FocusScope.of(context).requestFocus(_mobilenumber);
                    }, ),
                    reusablaSizaBox(context, 0.020),
                    reusableTextField(context, 
                          reusabletextfieldcontroller.mobilenumber, 'Mobile Number', _mobilenumber.hasFocus
                        ? colorController.blueColor
                        : colorController.textfieldBorderColorBefore, _mobilenumber, () {
                      _mobilenumber.unfocus();
                      FocusScope.of(context).requestFocus(_mobilenumber);
                    }, ),
                    reusablaSizaBox(context, 0.020),
                           Padding(
                             padding: EdgeInsets.all(MediaQuery.of(context).size.width * .10),
                             child: reusableBtn(context, 'Update', (){
                              updateAccountDetails();
                              // _validateForm();
                              }),
                           ),
                            
                    ],
                  ),
                ),
      reusableloadingrow(context, isLoading)
    );
  }
}