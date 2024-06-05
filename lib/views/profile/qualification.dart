import 'package:dropdown_search/dropdown_search.dart';
import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusablebtn.dart';
import 'package:fahad_tutor/res/reusableloading.dart';
import 'package:fahad_tutor/res/reusableprofilewidget.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QualificationAndPreferences extends StatefulWidget {
  const QualificationAndPreferences({super.key});

  @override
  State<QualificationAndPreferences> createState() => _QualificationAndPreferencesState();
}

class _QualificationAndPreferencesState extends State<QualificationAndPreferences> {
  bool isLoading = false;
   
//   List<ListItem> items = [
//   ListItem(value: 'Item 1'),
//   ListItem(value: 'Item 2'),
//   ListItem(value: 'Item 3'),
// ];
// List<String> selectedValues = [];


// bool _isDialogOpen = false;
//   search() {
//     setState(() {
//       _isDialogOpen = true;
//     });
//   return showDialog(
     
//     context: context,
//     builder: (context) => CupertinoAlertDialog(
//       // title: reusableText('Tutor Basic Information',color: colorController.blackColor,fontsize: 22,fontweight: FontWeight.bold),
//       content: 
//       Column(
//         // mainAxisAlignment: MainAxisAlignment.start,
//         // crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             height: 100,
//             child: ListView.builder(
//               itemCount: items.length,
//               itemBuilder: (context, index) {
//               return CupertinoListTile(
//         title: Text(items[index].value),
//         trailing: items[index].selected ? Icon(Icons.check,color: colorController.blackColor,) : null,
//         onTap: () {
//                   setState(() {
//                     // Toggle the selected flag
//                     items[index].selected = !items[index].selected;

//                     // Add or remove the value from the selectedValues list
//                     if (items[index].selected) {
//                       selectedValues.add(items[index].value);
//                     } else {
//                       selectedValues.remove(items[index].value);
//                     }
//                   });

//                   // Print the selected values
//                   print('Selected values: $selectedValues');
//                 },
//       );
//             },),
//           ),

//         ],
//       ),
//       // actions: [
//       //   ElevatedButton(
//       //     onPressed: () {
//       //       btnontap();
//       //       Navigator.pop(context);
//       //     },
//       //     child: Text(btntxt),
//       //   ),
//       // ],
//     ),
//   );
// }
  @override
  Widget build(BuildContext context) {
    return reusableprofileidget(
      Padding(padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .032),
                  child: 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          reusableText("Qualification and \nPreferences",color: colorController.blackColor,fontsize: 25,fontweight: FontWeight.bold),
                          reusablaSizaBox(context, 0.020),
                          //  reusableBtn(context, 'button', (){search();}),
                            
                    ],
                  ),
                ),
      reusableloadingrow(context, isLoading)
    );
  }
}

