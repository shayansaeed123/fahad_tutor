

import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:fahad_tutor/res/reusablevisibility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        foregroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        title: reusableText("Home"),
        centerTitle: true,
        leading: Icon(Icons.ac_unit_rounded,color: Colors.black,),
        actions: [
          Icon(Icons.ac_unit_rounded,color: Colors.black,),
          SizedBox(width: MediaQuery.of(context).size.width * 0.02,)
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * .032),
          child: Column(children: [
            // reusablaSizaBox(context, .01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                reusableText('All Tuitions',fontsize: 28,fontweight: FontWeight.w900),
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