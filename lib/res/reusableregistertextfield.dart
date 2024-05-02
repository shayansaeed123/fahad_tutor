

import 'package:flutter/material.dart';

Widget reusableregistertextfield(BuildContext context,Widget widget){

  return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .055,
                child: widget);
}