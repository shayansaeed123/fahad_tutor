import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/controller/navigation_controller.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/views/dashboard/all_tuitions.dart';
import 'package:fahad_tutor/views/dashboard/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavBar extends StatelessWidget {
  NavBar({super.key});

  BottomNavigationController bottomNavigationController =
      Get.put(BottomNavigationController());

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
          bottomNavigationController.changeIndex(index);
        },
      ),
    );
  }
}
