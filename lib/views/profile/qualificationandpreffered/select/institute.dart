
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Institute extends StatefulWidget {
  const Institute({super.key});

  @override
  State<Institute> createState() => _InstituteState();
}

class _InstituteState extends State<Institute> {
   @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Topics'),
      // content: SingleChildScrollView(
      //   child: ListBody(
      //     children: widget.items
      //         .map((item) => CheckboxListTile(
      //               value: _selectedItems.contains(item),
      //               title: Text(item),
      //               controlAffinity: ListTileControlAffinity.leading,
      //               onChanged: (isChecked) => _itemChange(item, isChecked!),
      //             ))
      //         .toList(),
      //   ),
      // ),
      actions: [
        // TextButton(
        //   onPressed: _cancel,
        //   child: const Text('Cancel'),
        // ),
        // ElevatedButton(
        //   onPressed: _submit,
        //   child: const Text('Submit'),
        // ),
      ],
    );
  }
}