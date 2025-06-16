


import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class TextFieldController extends GetxController {
  final TextEditingController _emailCon = TextEditingController();
  TextEditingController get emailCon => _emailCon;

  final TextEditingController _loginPassCon = TextEditingController();
  TextEditingController get loginPassCon => _loginPassCon;

final TextEditingController _registerPassCon = TextEditingController();
  TextEditingController get registerPassCon => _registerPassCon;


  final TextEditingController _teacherCon = TextEditingController();
  TextEditingController get teacherCon => _teacherCon;

  final TextEditingController _fatherCon = TextEditingController();
  TextEditingController get fatherCon => _fatherCon;

  final TextEditingController _contactCon = TextEditingController();
  TextEditingController get contactCon => _contactCon;

  final TextEditingController _alterContactCon = TextEditingController();
  TextEditingController get alterContactCon => _alterContactCon;

  final TextEditingController _cnicCon = TextEditingController();
  TextEditingController get cnicCon => _cnicCon;

  final TextEditingController _rePassCon = TextEditingController();
  TextEditingController get rePassCon => _rePassCon;

  final TextEditingController _religionCon = TextEditingController();
  TextEditingController get religionCon => _religionCon;

  final TextEditingController _addressCon = TextEditingController();
  TextEditingController get addressCon => _addressCon;

  final TextEditingController _ChangeOldPassword = TextEditingController();
  TextEditingController get ChangeOldPassword => _ChangeOldPassword;

  final TextEditingController _ChangenewPassword = TextEditingController();
  TextEditingController get ChangenewPassword => _ChangenewPassword;

  final TextEditingController _ChangecnfmPassword = TextEditingController();
  TextEditingController get ChangecnfmPassword => _ChangecnfmPassword;

  final TextEditingController _EditProfileName = TextEditingController();
  TextEditingController get EditProfileName => _EditProfileName;

  final TextEditingController _Wallet = TextEditingController();
  TextEditingController get Wallet => _Wallet;

  final TextEditingController _Discount = TextEditingController();
  TextEditingController get Discount => _Discount;

  final TextEditingController _Complaintmessage = TextEditingController();
  TextEditingController get Complaintmessage => _Complaintmessage;

  final TextEditingController _MessageCafe = TextEditingController();
  TextEditingController get MessageCafe => _MessageCafe;

  final TextEditingController _Specialinstructions = TextEditingController();
  TextEditingController get Specialinstructions => _Specialinstructions;

  final TextEditingController _contactUsName = TextEditingController();
  TextEditingController get contactUsName => _contactUsName;

  final TextEditingController _contactUsemail = TextEditingController();
  TextEditingController get contactUsemail => _contactUsemail;

  final TextEditingController _contactUsphone = TextEditingController();
  TextEditingController get contactUsphone => _contactUsphone;

  final TextEditingController _feedback = TextEditingController();
  TextEditingController get feedback => _feedback;

  final TextEditingController _oldPass = TextEditingController();
  TextEditingController get oldPass => _oldPass;

  final TextEditingController _newPass = TextEditingController();
  TextEditingController get newPass => _newPass;

  final TextEditingController _conPass = TextEditingController();
  TextEditingController get conPass => _conPass;

  final TextEditingController _searchConAll = TextEditingController();
  TextEditingController get searchConAll => _searchConAll;

  final TextEditingController _searchConPre = TextEditingController();
  TextEditingController get searchConPre => _searchConPre;


  ///Account Details 

final TextEditingController _title = TextEditingController();
  TextEditingController get title => _title;

  final TextEditingController _bankname = TextEditingController();
  TextEditingController get bankname => _bankname;

  final TextEditingController _branchcode = TextEditingController();
  TextEditingController get branchcode => _branchcode;

  final TextEditingController _accountnumber = TextEditingController();
  TextEditingController get accountnumber => _accountnumber;

  final TextEditingController _ibannumber = TextEditingController();
  TextEditingController get ibannumber => _ibannumber;

  final TextEditingController _accounttitle = TextEditingController();
  TextEditingController get accounttitle => _accounttitle;

  final TextEditingController _mobilenumber = TextEditingController();
  TextEditingController get mobilenumber => _mobilenumber;

  final TextEditingController _wallet = TextEditingController();
  TextEditingController get wallet => _wallet;




  final TextEditingController _furtherInfo = TextEditingController();
  TextEditingController get furtherInfo => _furtherInfo;

   @override
  void onClose() {
    _title.dispose();
    _emailCon.dispose();
    _loginPassCon.dispose();
    _registerPassCon.dispose();
    _teacherCon.dispose();
    _fatherCon.dispose();
    _contactCon.dispose();
    _alterContactCon.dispose();
    _cnicCon.dispose();
    _rePassCon.dispose();
    _religionCon.dispose();
    _addressCon.dispose();
    super.onClose();
  }




}

TextFieldController reusabletextfieldcontroller =
    Get.put(TextFieldController());