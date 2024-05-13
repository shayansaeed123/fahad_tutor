

import 'package:flutter/material.dart';

reusableprofileInfoDialog(BuildContext context, String titletxt, String contenttxt,
    String btntxt, Function btnontap) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(titletxt),
      content: Text(contenttxt),
      actions: [
        ElevatedButton(
          onPressed: () {
            btnontap();
            Navigator.pop(context);
          },
          child: Text(btntxt),
        ),
      ],
    ),
  );
}