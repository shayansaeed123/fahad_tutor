

import 'package:fahad_tutor/repo/utils.dart';
import 'package:flutter/cupertino.dart';

String? reusableValidator(BuildContext context, String title, String message, String? value) {
  if (value == null || value.isEmpty) {
    Utils.snackBar(title, message);
    return '$title cannot be empty';
  }
  return null;
}