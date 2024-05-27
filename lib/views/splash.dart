import 'dart:async';


import 'package:fahad_tutor/database/my_shared.dart';
import 'package:fahad_tutor/views/dashboard/nav_bar.dart';
import 'package:fahad_tutor/views/login/login.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoggedIn = false;

  Future<void> checkLoginStatus() async {
    bool isLoggedIn = await MySharedPrefrence().getUserLoginStatus();
    setState(() {
      _isLoggedIn = isLoggedIn;
    });
    Timer(Duration(seconds: 3), () {
      navigateToScreen();
    });
  }

  Future<void> navigateToScreen() async {
    print('tutor ID ${MySharedPrefrence().get_user_ID()}');
    print('tutor status ${MySharedPrefrence().getUserLoginStatus()}');
    if (MySharedPrefrence().get_user_ID() != '') {
      Navigator.push(context,MaterialPageRoute(
            builder: (context) => WillPopScope( onWillPop: () async => false, child: NavBar())),);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                WillPopScope(onWillPop: () async => false, child: Login())),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/fta_logo.png',
          filterQuality: FilterQuality.high,
          fit: BoxFit.contain,
          width: MediaQuery.of(context).size.width * .8,
          height: MediaQuery.of(context).size.height * .28,
        ),
      ),
    );
  }
}
