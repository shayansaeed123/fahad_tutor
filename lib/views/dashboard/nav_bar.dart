import 'dart:convert';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/controller/navigation_controller.dart';
import 'package:fahad_tutor/database/my_shared.dart';
import 'package:fahad_tutor/repo/tutor_repo.dart';
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
  TutorRepository _repository = TutorRepository();

      bool isLoading = false;
  // bool hasMoreData = true;
  int start = 0;
  int limit = 10;


  Future<List<dynamic>> fetchTuitions(int start, int limit) async {
    setState(() {
      isLoading = true;
    });
    List<dynamic> newItems = [];
    try {
      String url =
          '${Utils.baseUrl}mobile_app/tuitions.php?code=10&tutor_id=${MySharedPrefrence().get_user_ID()}&start=$start&end=${limit}';
      final response = await http.get(Uri.parse(url));
      print('urlllll $url');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        newItems = responseData['tuition_listing'];
        print('shaya $newItems');
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('No Data Found $e');
    }finally{
      setState(() {
        isLoading = false;
      });
    }
    return newItems;
  }

  @override
  void initState() {
    super.initState();
    fetchTuitions(start, limit); // Initial fetch
    // _repository.fetchTuitions(start, limit);
  }


  @override
  Widget build(BuildContext context) {
    final screens = [Home(isLoading2: _repository.isLoading,), AllTuitions(isLoading2: isLoading,)];
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
          if (index == 1) {
            // _repository.fetchTuitions(start, limit);
            fetchTuitions(start, limit);
          }
        },
      ),
    );
  }
}



