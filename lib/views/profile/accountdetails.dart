import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/controller/text_field_controller.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusableTextField.dart';
import 'package:fahad_tutor/res/reusablebtn.dart';
import 'package:fahad_tutor/res/reusableloading.dart';
import 'package:fahad_tutor/res/reusableprofilewidget.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:flutter/cupertino.dart';

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
                          reusableText("Qualification and Preferences",color: colorController.blackColor,fontsize: 23,fontweight: FontWeight.bold),
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
                          reusabletextfieldcontroller.bankname, 'Title', _bankname.hasFocus
                        ? colorController.blueColor
                        : colorController.textfieldBorderColorBefore, _bankname, () {
                      _bankname.unfocus();
                      FocusScope.of(context).requestFocus(_branchcode);
                    }, ),
                    reusablaSizaBox(context, 0.020),
                    reusableTextField(context, 
                          reusabletextfieldcontroller.branchcode, 'Title', _branchcode.hasFocus
                        ? colorController.blueColor
                        : colorController.textfieldBorderColorBefore, _branchcode, () {
                      _branchcode.unfocus();
                      FocusScope.of(context).requestFocus(_accountnumber);
                    }, ),
                    reusablaSizaBox(context, 0.020),
                    reusableTextField(context, 
                          reusabletextfieldcontroller.accountnumber, 'Title', _accountnumber.hasFocus
                        ? colorController.blueColor
                        : colorController.textfieldBorderColorBefore, _accountnumber, () {
                      _accountnumber.unfocus();
                      FocusScope.of(context).requestFocus(_ibannumber);
                    }, ),
                    reusablaSizaBox(context, 0.020),
                    reusableTextField(context, 
                          reusabletextfieldcontroller.ibannumber, 'Title', _ibannumber.hasFocus
                        ? colorController.blueColor
                        : colorController.textfieldBorderColorBefore, _ibannumber, () {
                      _ibannumber.unfocus();
                      FocusScope.of(context).requestFocus(_accounttitle);
                    }, ),
                    reusablaSizaBox(context, 0.020),
                    reusableText('OR',color: colorController.grayTextColor,fontsize: 16,fontweight: FontWeight.bold),
                    reusablaSizaBox(context, 0.020),
                    reusableTextField(context, 
                          reusabletextfieldcontroller.accounttitle, 'Title', _accounttitle.hasFocus
                        ? colorController.blueColor
                        : colorController.textfieldBorderColorBefore, _accounttitle, () {
                      _accounttitle.unfocus();
                      FocusScope.of(context).requestFocus(_mobilenumber);
                    }, ),
                    reusablaSizaBox(context, 0.020),
                    reusableTextField(context, 
                          reusabletextfieldcontroller.mobilenumber, 'Title', _mobilenumber.hasFocus
                        ? colorController.blueColor
                        : colorController.textfieldBorderColorBefore, _mobilenumber, () {
                      _mobilenumber.unfocus();
                      FocusScope.of(context).requestFocus(_mobilenumber);
                    }, ),
                           reusableBtn(context, 'button', (){}),
                            
                    ],
                  ),
                ),
      reusableloadingrow(context, isLoading)
    );
  }
}