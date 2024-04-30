

import 'package:flutter/material.dart';

Widget reusablaSizaBox(BuildContext context, double size){
  return SizedBox(
              height: MediaQuery.of(context).size.height * size,
            );
}