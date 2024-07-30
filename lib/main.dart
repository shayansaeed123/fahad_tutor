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
    // DevicePreview(
    //   enabled: !kReleaseMode,
    //   builder: (context) => MyApp(), // Wrap your app
    // ),
    const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'TutorFont',
        // textTheme: TextTheme(
        //   bodySmall: TextStyle(fontFamily: 'TutorFont'),
        //   bodyMedium: TextStyle(fontFamily: 'TutorFont'),
        //   // Customize other text styles as needed
        // ),
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
