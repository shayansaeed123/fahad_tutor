

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:fahad_tutor/controller/navigation_controller.dart';
import 'package:fahad_tutor/views/dashboard/all_tuitions.dart';
import 'package:fahad_tutor/views/dashboard/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavBar extends StatelessWidget {
   NavBar({super.key});

  BottomNavigationController bottomNavigationController = Get.put(BottomNavigationController());

  final screens = [
    Home(),
    AllTuitions()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: screens,
        index: bottomNavigationController.selectedIndex.value,
      ),
      bottomNavigationBar: ConvexAppBar(items: const [
        TabItem(icon: Icon(Icons.home),title: 'Home'),
        TabItem(icon: Icon(Icons.settings),title: 'setting'),
        ],),
    );
  }
}