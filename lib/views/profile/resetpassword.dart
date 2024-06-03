import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/controller/text_field_controller.dart';
import 'package:fahad_tutor/repo/tutor_repo.dart';
import 'package:fahad_tutor/repo/utils.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusablebtn.dart';
import 'package:fahad_tutor/res/reusablepassfield.dart';
import 'package:fahad_tutor/res/reusableprofilewidget.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:fahad_tutor/views/profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPassordState();
}

class _ResetPassordState extends State<ResetPassword> {
  // final TextEditingController _oldPassController = TextEditingController();
  // final TextEditingController _newPassController = TextEditingController();
  // final TextEditingController _confirmPassController = TextEditingController();
  late FocusNode _oldPassfocusNode;
  late FocusNode _newPassfocusNode;
  late FocusNode _confirmPassfocusNode;
  bool old = true;
  bool newp = true;
  bool confirm = true;
  TutorRepository repository = TutorRepository();

  void _validateForm() {
    if (reusabletextfieldcontroller.oldPass.text.isNotEmpty &&
        reusabletextfieldcontroller.newPass.text.isNotEmpty &&
        reusabletextfieldcontroller.conPass.text.isNotEmpty &&
        reusabletextfieldcontroller.newPass.text ==
            reusabletextfieldcontroller.conPass.text &&
        reusabletextfieldcontroller.newPass.text.length >= 8 &&
        reusabletextfieldcontroller.conPass.text.length <= 15 
      ) {
      // CheckUserContactExictOrNot();
      repository.resetPassword(context);
      // Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
    } else {
      Utils.snakbar(
        context,
        reusabletextfieldcontroller
                                        .oldPass.text.isEmpty
                                    ? "Old Password Is Missing"
                                    :
        reusabletextfieldcontroller
                                        .newPass.text.isEmpty
                                    ? "New Password Is Missing"
                                    : reusabletextfieldcontroller
                                            .conPass.text.isEmpty
                                        ? "Confirm Password Is Missing"
                                        : reusabletextfieldcontroller
                                                    .newPass.text !=
                                                reusabletextfieldcontroller
                                                    .conPass.text
                                            ? "New Passwords is defferent"
                                            : reusabletextfieldcontroller
                                                        .newPass.text.length <
                                                    8
                                                ? "New Password  Must be at least of 8 and maximum of 15 charracters"
                                                 : "Fill Correct Fields",
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _oldPassfocusNode = FocusNode();
    _oldPassfocusNode.addListener(_onFocusChange);
    _newPassfocusNode = FocusNode();
    _newPassfocusNode.addListener(_onFocusChange);
    _confirmPassfocusNode = FocusNode();
    _confirmPassfocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _oldPassfocusNode.removeListener(_onFocusChange);
    _oldPassfocusNode.dispose();
    _newPassfocusNode.removeListener(_onFocusChange);
    _newPassfocusNode.dispose();
    _confirmPassfocusNode.removeListener(_onFocusChange);
    _confirmPassfocusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      // Redraw the UI when the focus changes
    });
  }

  @override
  Widget build(BuildContext context) {
    return reusableprofileidget(Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .032),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          reusableText('Reset Password',
              color: colorController.blackColor,
              fontsize: 23,
              fontweight: FontWeight.bold),
          reusablaSizaBox(context, 0.020),
          reusablePassField(
              context,
              reusabletextfieldcontroller.oldPass,
              'Old Password',
              _oldPassfocusNode.hasFocus
                  ? colorController.blueColor
                  : colorController.textfieldBorderColorBefore,
              _oldPassfocusNode,
              () {
                _oldPassfocusNode.unfocus();
                FocusScope.of(context).requestFocus(_newPassfocusNode);
              },
              // true,
              // 'Enter Old Password',
              old,
              () {
                setState(() {
                  old = !old;
                });
              },
            ),
              reusablaSizaBox(context, 0.020),
              reusablePassField(
              context,
              reusabletextfieldcontroller.newPass,
              'New Password',
              _newPassfocusNode.hasFocus
                  ? colorController.blueColor
                  : colorController.textfieldBorderColorBefore,
              _newPassfocusNode,
              () {
                _newPassfocusNode.unfocus();
                FocusScope.of(context).requestFocus(_confirmPassfocusNode);
              },
              // true,
              // 'Enter New Password',
              newp,
              () {
                setState(() {
                  newp = !newp;
                });
              }),
              reusablaSizaBox(context, 0.020),
              reusablePassField(
              context,
              reusabletextfieldcontroller.conPass,
              'Confirm Password',
              _confirmPassfocusNode.hasFocus
                  ? colorController.blueColor
                  : colorController.textfieldBorderColorBefore,
              _confirmPassfocusNode,
              () {
                _confirmPassfocusNode.unfocus();
                FocusScope.of(context).requestFocus(_confirmPassfocusNode);
              },
              // true,
              // 'Confirm Old Password',
              confirm,
              () {
                setState(() {
                  confirm = !confirm;
                });
              }),
          reusablaSizaBox(context, 0.040),
          reusableBtn(context, 'Reset Password',(){_validateForm();})
        ],
      ),
    ));
  }
}
