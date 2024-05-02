


// import 'package:flutter/material.dart';

// widget reusabledropdown(BuildContext context){
//   return Container(
//               padding: EdgeInsets.only(
//                   left: MediaQuery.of(context).size.width * .01),
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height * .055,
//               decoration: BoxDecoration(
//                 border:
//                     Border.all(color: Colors.grey, width: 1.5), // Border color
//                 borderRadius: BorderRadius.circular(10.0),
//                 // Border radius
//               ),
//               child: DropdownButton<String>(
//                 value: _selectedItem,
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     _selectedItem = newValue;
//                   });
//                 },
//                 hint: reusableText('Select Country',
//                     color: colorController.grayTextColor, fontsize: 14),
//                 items: <String>['Option 1', 'Option 2', 'Option 3', 'Option 4']
//                     .map((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Container(
//                         width: MediaQuery.of(context).size.width * .81,
//                         child: reusableText(value,
//                             color: colorController.grayTextColor,
//                             fontsize: 14)),
//                     // Display 'Select value' if value is null
//                   );
//                 }).toList(),
//                 style: TextStyle(color: Colors.black), // Dropdown text color
//                 icon: Icon(Icons.arrow_drop_down), // Dropdown icon
//                 underline: Container(), // Remove underline
//                 elevation: 0,
//               ),
//             );
// }