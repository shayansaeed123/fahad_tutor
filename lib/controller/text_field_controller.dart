


import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class TextFieldController extends GetxController {
  final TextEditingController _emailCon = TextEditingController();
  TextEditingController get emailCon => _emailCon;

  final TextEditingController _passCon = TextEditingController();
  TextEditingController get passCon => _passCon;


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

  final TextEditingController _Promocodeplaceorder = TextEditingController();
  TextEditingController get Promocodeplaceorder => _Promocodeplaceorder;

  final TextEditingController _Address = TextEditingController();
  TextEditingController get Address => _Address;

  final TextEditingController _RiderNote = TextEditingController();
  TextEditingController get RiderNote => _RiderNote;

  final TextEditingController _LabelAddress = TextEditingController();
  TextEditingController get LabelAddress => _LabelAddress;






  final TextEditingController _CartQntyController = TextEditingController();
  TextEditingController get CartQntyController => _CartQntyController;




}

TextFieldController reusabletextfieldcontroller =
    Get.put(TextFieldController());