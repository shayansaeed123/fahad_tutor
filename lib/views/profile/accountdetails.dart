import 'package:dropdown_search/dropdown_search.dart';
import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/controller/text_field_controller.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusableTextField.dart';
import 'package:fahad_tutor/res/reusablebtn.dart';
import 'package:fahad_tutor/res/reusableloading.dart';
import 'package:fahad_tutor/res/reusableprofilewidget.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  // String? value;

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


  void _onFocusChange() {
    setState(() {
      // Redraw the UI when the focus changes
    });
  }
  @override
  Widget build(BuildContext context) {
    return reusableprofileidget(
      Padding(padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .032),
                  child: 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          reusableText("Account Details",color: colorController.blackColor,fontsize: 23,fontweight: FontWeight.bold),
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
                             child: reusableBtn(context, 'Update', (){}),
                           ),
                            
                    ],
                  ),
                ),
      reusableloadingrow(context, isLoading)
    );
  }
}