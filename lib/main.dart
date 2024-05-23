import 'package:device_preview/device_preview.dart';
import 'package:fahad_tutor/database/my_shared.dart';
import 'package:fahad_tutor/views/splash.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(), // Wrap your app
    ),
    // const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(MySharedPrefrence().get_tutor_name());
    print(MySharedPrefrence().getUserLoginStatus());
    print(MySharedPrefrence().get_user_ID());
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'tutorPhi',
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
