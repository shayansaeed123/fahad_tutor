

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

Widget reusablelisttile(){
  return ListTile(
    leading: Text('hello'),
    title: Text('hello'),
    trailing: Text('data'),
  );
}