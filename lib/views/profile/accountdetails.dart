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
    super.dispose();
  }
  void _onFocusChange() {setState(() {});}

  Future<void> updateAccountDetails()async{
    setState(() {
      isLoading = true;
    });
    try{
      
      final response = await http.post(
      Uri.parse('${Utils.baseUrl}mobile_app/step_6_update.php'),
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
                          reusabletextfieldcontroller.title, 'Title', _title.hasFocus
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
                          reusabletextfieldcontroller.branchcode, 'Barnch Code', _branchcode.hasFocus
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
                                  height:
                                      MediaQuery.of(context).size.height * .055,
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
        hintStyle: TextStyle(color: colorController.blackColor),
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
      border: InputBorder.none,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                             child: reusableBtn(context, 'Update', (){updateAccountDetails();}),
                           ),
                            
                    ],
                  ),
                ),
      reusableloadingrow(context, isLoading)
    );
  }
}