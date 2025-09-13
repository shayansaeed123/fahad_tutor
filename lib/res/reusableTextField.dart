import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/repo/utils.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusablevalidator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart'; // Add this for DateFormat if not already included

Widget reusableTextField(
  BuildContext context,
  TextEditingController controller,
  String labelText,
  Color color,
  FocusNode focusnode,
  Function onsubmit,
  // bool validate_or_not,
  // String message,
   {
  TextInputType keyboardType = TextInputType.text,
  bool obscureText = false,
}) {
  return Container(
    // margin: EdgeInsets.only(bottom: 10),
    width: MediaQuery.of(context).size.width * 1,
    // height: MediaQuery.of(context).size.height * .060,
    child: TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(fontSize: 12.5),
      focusNode: focusnode,
      onFieldSubmitted: (value) {
                              onsubmit();
                            },
      // validator: (value) {
      //   // if (validate_or_not) {
      //     if (value!.isEmpty) {
      //       return Utils.snakbar(context, message);
      //     }
      //     // return null;
      //   // }
        
      //   return null;
      // },
                            
                          
      obscureText: obscureText,
      
      decoration: InputDecoration(
        filled: true,
        fillColor: colorController.whiteColor,
        labelText: labelText,
        labelStyle: TextStyle(color: color,fontSize: 11.5),
        // prefixIcon: const Icon(Icons.password_outlined, color: Colors.white),
        hintStyle: TextStyle(color: colorController.textfieldBorderColorBefore),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: colorController.textfieldBorderColorBefore, width: 1.5)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: colorController.textfieldBorderColorBefore, width: 1.5)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: colorController.textfieldBorderColorAfter, width: 1.5)),
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10),
      ),
    ),
  );
}

Widget reusableOnlineTextField(
  BuildContext context,
  TextEditingController controller,
  String labelText,
  Color color,
  FocusNode focusnode,
  Function onsubmit,
  void Function(String)? onChange,
  // bool validate_or_not,
  // String message,
   {
  TextInputType keyboardType = TextInputType.text,
  bool obscureText = false,
}) {
  return Container(
    // margin: EdgeInsets.only(bottom: 10),
    width: MediaQuery.of(context).size.width * 1,
    // height: MediaQuery.of(context).size.height * .060,
    child: TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(fontSize: 12.5),
      focusNode: focusnode,
      onFieldSubmitted: (value) {
                              onsubmit();
                            },
      // validator: (value) {
      //   // if (validate_or_not) {
      //     if (value!.isEmpty) {
      //       return Utils.snakbar(context, message);
      //     }
      //     // return null;
      //   // }
        
      //   return null;
      // },
                            
                          
      obscureText: obscureText,
      onChanged: onChange,
      decoration: InputDecoration(
        filled: true,
        fillColor: colorController.whiteColor,
        labelText: labelText,
        labelStyle: TextStyle(color: color,fontSize: 11.5),
        // prefixIcon: const Icon(Icons.password_outlined, color: Colors.white),
        hintStyle: TextStyle(color: colorController.textfieldBorderColorBefore),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: colorController.textfieldBorderColorBefore, width: 1.5)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: colorController.textfieldBorderColorBefore, width: 1.5)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: colorController.textfieldBorderColorAfter, width: 1.5)),
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10),
      ),
    ),
  );
}

reusableContactUs(BuildContext context,String text, IconData icons, TextEditingController controller,FocusNode focusnode,Function onsubmit){
  return Column(
    children: [
      Row(mainAxisAlignment: MainAxisAlignment.start,
      children: [
        reusableText(text,color: colorController.blackColor,fontsize: 16),
        Icon(icons,color: colorController.blackColor,size: 20,),
      ],),
      Container(
        // margin: EdgeInsets.only(bottom: 10),
        width: MediaQuery.of(context).size.width * 1,
        // height: MediaQuery.of(context).size.height * .060,
        child: TextFormField(
          controller: controller,
          focusNode: focusnode,
          onFieldSubmitted: (value) {
                                  onsubmit();
                                },           
          decoration: InputDecoration(
            filled: true,
            fillColor: colorController.whiteColor,
            // labelText: labelText,
            // labelStyle: TextStyle(color: color),
            // prefixIcon: const Icon(Icons.password_outlined, color: Colors.white),
            hintStyle: TextStyle(color: colorController.textfieldBorderColorBefore),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: colorController.textfieldBorderColorBefore, width: 0.75)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: colorController.textfieldBorderColorBefore, width: 0.75)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: colorController.appliedTextColor, width: 0.75)),
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10),
          ),
        ),
      ),
    ],
  );
}

reusablemultilineTextField(TextEditingController controller,int numLine,String name){
  return TextField(
              controller: controller,
                  maxLines: numLine, // Set the maximum number of lines
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    label: reusableText('$name'),
                    labelStyle: TextStyle(color: colorController.grayTextColor),
                    border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: colorController.textfieldBorderColorBefore, width: 1.5)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: colorController.textfieldBorderColorBefore, width: 1.5)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: colorController.textfieldBorderColorAfter, width: 1.5)),
                  ),
            );
}

// reusableDateofBirthField(BuildContext context,
// DateTime lastDate,
// DateTime? selectedTime,
// Function(DateTime) selectdateontap,
// Widget icon,
// String hint){
//   return InkWell(
//                             onTap: ()async{
//                               final DateTime initialDate =
//           (selectedTime != null && !selectedTime.isBefore(lastDate))
//               ? selectedTime
//               : DateTime.now();

//                               final DateTime? timeofday =
//                                             await showDatePicker(
//                                           context: context,
//                                           firstDate: lastDate,
//                                           // lastDate: selectedTime,
//                                           // initialDate: selectedTime,
//                                           lastDate: DateTime.now(),
//                                           // initialDate: selectedTime ?? DateTime.now(),
//                                           initialDate: initialDate,
//                                           initialEntryMode:
//                                               DatePickerEntryMode.calendar,
//                                           builder: (BuildContext context,
//                                               Widget? child) {
//                                             return Theme(
//                                               data: ThemeData.dark().copyWith(
//                                                   // primaryColor: colorController.btnColor,
//                                                   colorScheme:
//                                                       ColorScheme.light(
//                                                     primary: colorController
//                                                         .btnColor, // Header background color
//                                                     onPrimary: colorController
//                                                         .whiteColor, // Header text color
//                                                     onSurface: colorController
//                                                         .btnColor, // Body text color
//                                                   ),
//                                                   dialogBackgroundColor: Colors
//                                                       .white, // Background color
//                                                   bannerTheme:
//                                                       MaterialBannerThemeData(
//                                                           backgroundColor:
//                                                               colorController
//                                                                   .btnColor)),
//                                               child: child!,
//                                             );
//                                           },
//                                         );
//                                         if (timeofday != null) {
                                         
//                                           selectdateontap(timeofday);
//                                         }
//                             },
//                             child: 
//                             // Container(
//                             //   height: MediaQuery.of(context).size.height * .052,
//                             //   width: MediaQuery.of(context).size.width,
//                             //   decoration: BoxDecoration(
//                             //             border: Border.all(
//                             //                 color: colorController.grayTextColor,
//                             //                 width: 1.5),
//                             //             borderRadius: BorderRadius.circular(10)),
//                             //             child: 
//                                         ListTile(
//                                         enabled: false,
//                                         dense: true,
//                                         shape: RoundedRectangleBorder(
//               side: BorderSide(
//                 color: Colors.grey, // Border color
//                 width: 1.5, // Border width
//               ),
//               borderRadius: BorderRadius.circular(10), // Border radius
//             ),
//                                         trailing: icon,
//                                         contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
//                                         title: Align(
//                                           alignment: Alignment.topLeft,
//                                           child: reusableText(
//                                             selectedTime == null
//                                                 ? '$hint'
//                                                 : '${DateFormat(' yyyy-MM-dd').format(selectedTime)}',
//                                                 fontsize: 11.5, // Adjust the font size
//                                           ),
//                                         // ),
//                                             )
//                             ),
//                           );
// }

Widget reusableDateofBirthField(
  BuildContext context,
  DateTime lastDate,
  DateTime? selectedTime,
  Function(DateTime) selectdateontap,
  Widget icon,
  String hint,
) {
  final controller = TextEditingController(
    text: selectedTime == null
        ? ''
        : DateFormat('yyyy-MM-dd').format(selectedTime),
  );

  return InkWell(
    onTap: () async {
      final DateTime initialDate =
          (selectedTime != null && !selectedTime.isBefore(lastDate))
              ? selectedTime
              : DateTime.now();

      final DateTime? picked = await showDatePicker(
        context: context,
        firstDate: lastDate,
        lastDate: DateTime.now(),
        initialDate: initialDate,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: colorController.btnColor,
                onPrimary: colorController.whiteColor,
                onSurface: colorController.btnColor,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child!,
          );
        },
      );

      if (picked != null) {
        selectdateontap(picked);
      }
    },
    child: IgnorePointer(
      child: TextFormField(
        controller: controller,
        style: TextStyle(fontSize: 12.0,color: colorController.blackColor,),
        decoration: InputDecoration(
          filled: true,
          fillColor: colorController.whiteColor,
          labelText: selectedTime != null ? hint : null, // Float only if date is selected
          suffixIcon: icon,
          hintText: selectedTime == null ? hint : null, // Show hint only if no date
          hintStyle: TextStyle(
            color: colorController.textfieldBorderColorBefore,
            fontSize: 11,
          ),
          labelStyle: TextStyle(
            color: colorController.textfieldBorderColorBefore,
            fontSize: 11.5,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: colorController.textfieldBorderColorBefore,
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: colorController.textfieldBorderColorBefore,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: colorController.textfieldBorderColorAfter,
              width: 1.5,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10),
        ),
      ),
    ),
  );
}


Widget reusableOnlinePortalDate(
  BuildContext context,
  DateTime lastDate,
  DateTime? selectedTime,
  Function(DateTime) selectdateontap,
  Widget icon,
  String hint,
) {
  final controller = TextEditingController(
    text: selectedTime == null
        ? ''
        : DateFormat('yyyy-MM').format(selectedTime), // 👈 only Year-Month
  );

  return InkWell(
    onTap: () async {
      final DateTime initialDate =
          (selectedTime != null && !selectedTime.isBefore(lastDate))
              ? selectedTime
              : DateTime.now();

      /// 👇 Month-Year Picker instead of full date picker
      final DateTime? picked = await showMonthYearPicker(
        context: context,
        firstDate: lastDate,
        lastDate: DateTime.now(),
        initialDate: initialDate,
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: colorController.btnColor,
                onPrimary: colorController.whiteColor,
                onSurface: colorController.btnColor,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child!,
          );
        },
      );

      if (picked != null) {
        final onlyYearMonth = DateTime(picked.year, picked.month);
        selectdateontap(onlyYearMonth);
      }
    },
    child: IgnorePointer(
      child: TextFormField(
        controller: controller,
        style: TextStyle(
          fontSize: 12.0,
          color: colorController.blackColor,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: colorController.whiteColor,
          labelText: selectedTime != null ? hint : null,
          suffixIcon: icon,
          hintText: selectedTime == null ? hint : null,
          hintStyle: TextStyle(
            color: colorController.textfieldBorderColorBefore,
            fontSize: 11,
          ),
          labelStyle: TextStyle(
            color: colorController.textfieldBorderColorBefore,
            fontSize: 11.5,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: colorController.textfieldBorderColorBefore,
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: colorController.textfieldBorderColorBefore,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: colorController.textfieldBorderColorAfter,
              width: 1.5,
            ),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10),
        ),
      ),
    ),
  );
}





reusableDropdownfeild(BuildContext context,String? selected,Function(String?) ontap, String showTitle,List<String> values,){
  return 
  Container(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .01),
                                      width: MediaQuery.of(context).size.width *
                                          .43,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .055,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey,
                                            width: 1.5), // Border color
                                        borderRadius: BorderRadius.circular(
                                            10.0), // Border radius
                                      ),
                                      child: 
                                      DropdownButton<String>(
                                        dropdownColor:
                                            colorController.whiteColor,
                                        value: selected ,
                                        // isExpanded: true,
                                        onChanged: (String? newValue) {
                                          ontap(newValue);
                                          // setState(() {
                                          //   _selectedGender = newValue;
                                          //   print('gender $_selectedGender');
                                          // });
                                        },
                                        hint: reusableText('$showTitle',
                                            color:
                                                colorController.grayTextColor,
                                            fontsize: 11.5),
                                        items: values.map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .3,
                                                child: reusableText(value,
                                                    color: colorController
                                                        .blackColor,
                                                    fontsize: 14)),
                                            // Display 'Select value' if value is null
                                          );
                                        }).toList(),
                                        style: TextStyle(
                                            color: Colors
                                                .black), // Dropdown text color
                                        icon: Expanded(
                                          child: Icon(Icons
                                              .arrow_drop_down),
                                        ), // Dropdown icon
                                        underline:
                                            Container(), // Remove underline
                                        // elevation: 0,
                                      ),
                                      );
}

Widget reusableDropdownAdditional(
    BuildContext context,
    String? selected,
    Function(String?) ontap,
    String showTitle,
    List<String> values,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: 3.0),
      child: DropdownButtonFormField<String>(
        isDense: true,
        borderRadius: BorderRadius.circular(11),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          labelText: showTitle,
          labelStyle: TextStyle(fontSize: 11.5),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: colorController.btnColor),
            borderRadius: BorderRadius.circular(11)),
        ),
        dropdownColor: Colors.white, // Replace with your color controller if needed
        value: values.contains(selected) ? selected : null, // Ensure value is in items
        onChanged: (String? newValue) {
          ontap(newValue);
        },
        items: values.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Container(
              width: MediaQuery.of(context).size.width * .3,
              child: Text(
                value,
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ),
          );
        }).toList(),
        style: TextStyle(color: Colors.black), // Dropdown text color
        icon: Icon(Icons.arrow_drop_down),
      ),
    );
  }

  Widget reusableExperienceDropdown(
  String? selectedValue,
  List<dynamic> items,
  Function(String?) onChanged,
  String label,
) {
  final validOptions = items.map((e) => e['Experience_name'].toString()).toList();

  return DropdownButtonFormField<String>(
    value: validOptions.contains(selectedValue) ? selectedValue : null, // ✅ null if not selected
    isExpanded: true,
    items: [
      const DropdownMenuItem<String>(
        value: null, // ✅ default null option
        child: Text("Select Experience", style: TextStyle(color: Colors.grey)),
      ),
      ...items.map<DropdownMenuItem<String>>((item) {
        final name = item['Experience_name'].toString();
        return DropdownMenuItem<String>(
          value: name,
          child: Text(name),
        );
      }).toList(),
    ],
    onChanged: onChanged,
    decoration: InputDecoration(
      labelText: label,
      hintText: "Select Experience",
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}


// Widget reusableExperienceDropdown(
//   String? selectedValue,
//   List<dynamic> items,
//   Function(String) onChanged,
//   String label,
// ) {
//   final validOptions = items.map((e) => e['Experience_name'].toString()).toList();

//   // ✅ Set default value if not found
//   final dropdownValue = validOptions.contains(selectedValue) ? selectedValue : 'Select Experience';

//   return DropdownButtonFormField<String>(
//     value: dropdownValue,
//     isExpanded: true,
//     items: items.map<DropdownMenuItem<String>>((item) {
//       final name = item['Experience_name'].toString();
//       return DropdownMenuItem<String>(
//         value: name,
//         child: Text(name),
//       );
//     }).toList(),
//     onChanged: (value) => onChanged(value!),
//     decoration: InputDecoration(
//       labelText: label,
//       hintText: 'Select',
//       contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(10), // 👈 Rounded Border
//     ),
//     ),
//   );
// }


  reusableDropdownBankDetails<T>(
    List<T> items,
  T? selectedItem,
  String label,
  String Function(T) getLabel,
  Function(T?) onChanged,
  ){
    return DropdownButtonFormField<T>(
      decoration: InputDecoration(
        labelText: label,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      value: items.contains(selectedItem) ? selectedItem : null,
      items: items.map((item) {
        return DropdownMenuItem<T>(
          value: item,
          child: reusableText(getLabel(item), fontsize: 15),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }




// Widget reusableTextField(
//   BuildContext context,
//   TextEditingController controller,
//   String labelText,
//   Color color,
//   FocusNode focusNode,
//   Function onSubmit,
//   bool validate_or_not,
//   String message,
//   // Function validator,
//    {
//   TextInputType keyboardType = TextInputType.text,
//   bool obscureText = false,
// }) {
//   return Container(
//     width: MediaQuery.of(context).size.width * 1,
//     height: MediaQuery.of(context).size.height * .060,
//     child: TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       focusNode: focusNode,
//       onFieldSubmitted: (value) {
//         onSubmit();
//       },
//        validator: (value) {
//         if (validate_or_not == true) {
//           if (value!.isEmpty) {
//             return message;
//           }
//           return null;
//         }
//       },

//       obscureText: obscureText,
//       decoration: InputDecoration(
//         filled: true,
//         fillColor: colorController.whiteColor,
//         labelText: labelText,
//         labelStyle: TextStyle(color: color),
//         hintStyle: TextStyle(color: colorController.textfieldBorderColorBefore),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide(
//             color: colorController.textfieldBorderColorBefore,
//             width: 1.5,
//           ),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide(
//             color: colorController.textfieldBorderColorBefore,
//             width: 1.5,
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide(
//             color: colorController.textfieldBorderColorAfter,
//             width: 1.5,
//           ),
//         ),
//         errorBorder: InputBorder.none,
//         disabledBorder: InputBorder.none,
//       ),
//     ),
//   );
// }
