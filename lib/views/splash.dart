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
  Timer? _timer;

  Future<void> checkLoginStatus() async {
    bool isLoggedIn = await MySharedPrefrence().getUserLoginStatus();
    if (!mounted) return; // Check if the widget is still mounted
    setState(() {
      _isLoggedIn = isLoggedIn;
    });
    _timer = Timer(Duration(seconds: 3), () {
      navigateToScreen();
    });
  }

  Future<void> navigateToScreen() async {
    if (!mounted) return; // Check if the widget is still mounted
    print('tutor ID ${MySharedPrefrence().get_user_ID()}');
    print('tutor status ${MySharedPrefrence().getUserLoginStatus()}');
    if (MySharedPrefrence().get_user_ID() != '') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => NavBar(),));
    } else {
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => WillPopScope(
      //       onWillPop: () async => false,
      //       child: Login(),
      //     ),
      //   ),
      // );
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login(),));
    }
  }

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
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
