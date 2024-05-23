import 'dart:convert';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/controller/navigation_controller.dart';
import 'package:fahad_tutor/database/MySharedPrefrence.dart';
import 'package:fahad_tutor/repo/utils.dart';
import 'package:fahad_tutor/views/dashboard/all_tuitions.dart';
import 'package:fahad_tutor/views/dashboard/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NavBar extends StatefulWidget {
  NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  BottomNavigationController bottomNavigationController =
      Get.put(BottomNavigationController());

  
  bool isLoading = false;

  // Future<Map<String, dynamic>> allTuitions(int start)async{
  //   setState(() {
  //     isLoading = true;
  //   });
  //   try {
  //   final response = await http.get(
  //     Uri.parse('${Utils.baseUrl}mobile_app/tuitions.php?code=10&tutor_id=${MySharedPrefrence().get_user_ID()}&start=$start&end=10'),
  //   );

  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> responseData = json.decode(response.body);
  //     print('All Tuitions $responseData');
  //     return responseData;
  //   } else {
  //     print('Error2: ' + response.statusCode.toString());
  //     return {};
  //   }
  // } catch (e) {
  //   print('No Data Found $e');
  //   throw Exception('No Data Found $e');
  // } finally {
  //   setState(() {
  //     isLoading = false;
  //   });
  // }
  // }
  // // int start = 0;
  // // Future<Map<String, dynamic>>? _futureTuitions;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   // _futureTuitions = allTuitions(start);
  // }
  final screens = [Home(), AllTuitions()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
            children: screens,
            index: bottomNavigationController.selectedIndex.value,
          )),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: colorController.btnColor,
        style: TabStyle.flip,
        // cornerRadius: 20.0,
        elevation: 10,
        items: [
          TabItem(
              icon: Icon(
                CupertinoIcons.square_favorites,
                color: colorController.whiteColor,
              ),
              title: 'Preffered Tuitions',
              fontFamily: 'tutorPhi',
              activeIcon: Icon(CupertinoIcons.square_favorites_fill,color: colorController.whiteColor,)),
          TabItem(
              icon: Icon(
                CupertinoIcons.book,
                color: colorController.whiteColor,
              ),
              title: 'All Tuitions',
              fontFamily: 'tutorPhi',
              activeIcon: Icon(CupertinoIcons.book_fill,color: colorController.whiteColor,)),
        ],
        onTap: (index) {
          // allTuitions(0);
          bottomNavigationController.changeIndex(index);
        },
      ),
    );
  }
}
