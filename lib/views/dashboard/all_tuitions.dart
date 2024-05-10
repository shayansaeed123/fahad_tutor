


import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusableappbar.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:fahad_tutor/res/reusablevisibility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllTuitions extends StatefulWidget {
  const AllTuitions({super.key});

  @override
  State<AllTuitions> createState() => _AllTuitionsState();
}

class _AllTuitionsState extends State<AllTuitions> {
  final TextEditingController _searchCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reusableappbar(context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * .032),
          child: Column(children: [
            // reusablaSizaBox(context, .01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                reusableText('All Tuitions',fontsize: 25,color: colorController.blackColor, fontweight: FontWeight.bold),
                reusableText('Youtube',color: colorController.blueColor,fontsize: 20)
              ],
            ),
            reusablaSizaBox(context, .007),
            Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * .065,
              child: TextField(
                    controller: _searchCon,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[350],
                      hintText: 'Search Tuitions',
                      prefixIcon: Icon(Icons.search,color: Colors.grey[270],),
                      // prefixIcon: const Icon(Icons.password_outlined, color: Colors.white),
                      hintStyle: TextStyle(color: Colors.grey[250]),
                      border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none
                  ),
                      enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none
              // borderSide: BorderSide(
              //     color: colorController.textfieldBorderColorBefore, width: 1.5)
                  ),
                      focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none
              // borderSide: BorderSide(
              //     color: colorController.grayTextColor, width: 1.5)
                  ),
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      // contentPadding: EdgeInsets.symmetric(vertical: 25, horizontal: 30),
                    ),
                  ),
            ),
            reusablaSizaBox(context, .009),
            reusableVisiblity(context, 'Apply carefully to maintain your profile', (){})
          ],),
        ),
      ),
    );
  }
}