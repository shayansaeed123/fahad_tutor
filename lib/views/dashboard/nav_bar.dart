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
  int start = 0;
  int limit = 10;

  @override
  void initState() {
    super.initState();
    // fetchAllTuitions(start, limit); // Initial fetch
    fetchPrefferedTuitions(start, limit);
  }

  Future<void> fetchAllTuitions(int start, int limit) async {
    setState(() {
      isLoading = true;
    });
    await _repository.allTuitions(start, limit);
    setState(() {
      isLoading = false;
    });
  }

  Future<void> fetchPrefferedTuitions(int start, int limit) async {
    setState(() {
      isLoading = true;
    });
    await _repository.prefferedTuitions(start, limit);
    setState(() {
      isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    final screens = [Home(isLoading2: isLoading,), AllTuitions(isLoading2: isLoading,)];
    return Scaffold(
      body: Obx(() => IndexedStack(
            children: screens,
            index: bottomNavigationController.selectedIndex.value,
          )),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: colorController.btnColor,
        style: TabStyle.react,
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
          bottomNavigationController.changeIndex(index);
          if (index == 1) {
            fetchAllTuitions(start, limit);
          }else if(index == 0){
            fetchPrefferedTuitions(start, limit);
          }
        },
      ),
    );
  }
}



