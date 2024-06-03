import 'package:dropdown_search/dropdown_search.dart';
import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/res/reusableText.dart';
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

  List<dynamic> areaList = [
    {'id': 1, 'area_name': 'Area 1'},
    {'id': 2, 'area_name': 'Area 2'},
    {'id': 3, 'area_name': 'Area 3'},
    // Add more areas as needed
  ];

  List<dynamic> selectedAreas = [];
  bool isAreaDropdownEnabled = true;
  @override
  Widget build(BuildContext context) {
    return reusableprofileidget(
      Padding(padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .032),
                  child: 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          reusableText("Qualification and Preferences",color: colorController.blackColor,fontsize: 23,fontweight: FontWeight.bold),
                          reusablaSizaBox(context, 0.020),
                           Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownSearch<dynamic>(
              popupProps: PopupPropsMultiSelection.dialog(
                fit: FlexFit.loose,
                showSearchBox: true,
                dialogProps: DialogProps(
                  backgroundColor: colorController.whiteColor,
                  elevation: 10,
                ),
                searchFieldProps: TextFieldProps(
                  decoration: InputDecoration(
                    hintText: 'Search Area',
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                ),
                showSelectedItems: true,
                itemBuilder: (context, item, isSelected) {
                  return ListTile(
                    title: Text(item['area_name']),
                    trailing: isSelected ? Icon(Icons.check) : null,
                  );
                },
              ),
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  hintText: 'Select Area',
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
              ),
              items: areaList,
              itemAsString: (dynamic area) => area['area_name'].toString(),
              onChanged: 
              // isAreaDropdownEnabled
              //     ? 
                  (dynamic newValues) {
                      setState(() {
                        selectedAreas = newValues;
                      });
                      print('Selected Areas: ${newValues.map((e) => e['area_name']).toList()}');
                    },
                  // : null,
              selectedItem: selectedAreas,
              compareFn: (item, selectedItem) => item['id'] == selectedItem['id'],
            ),
            SizedBox(height: 20),
            Text(
              'Selected Areas:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: selectedAreas.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(selectedAreas[index]['area_name']),
                  );
                },
              ),
            ),
          ],
        ),
      ),
                    ],
                  ),
                ),
      reusableloadingrow(context, isLoading)
    );
  }
}