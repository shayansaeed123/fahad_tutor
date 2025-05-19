import 'package:device_preview/device_preview.dart';
import 'package:fahad_tutor/database/my_shared.dart';
import 'package:fahad_tutor/service/notificationservice.dart';
import 'package:fahad_tutor/views/splash.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await NotificationPermissionHandler.requestNotificationPermission();
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
      if (initialMessage != null) {
    print("🟢 App opened from terminated state via notification.");
    NotificationService.handleNotificationClick(initialMessage);
  }
  NotificationService.initialize(); // Initialize the notification handler
  runApp(
    // const MyApp()
    ChangeNotifierProvider(
      create: (context) => NotificationState(),  // Providing the state here
      child: MyApp(),
    ),
  );
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'TutorFont',
      ),
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey, // Use the global navigator key
      home: const SplashScreen(),
    );
  }
}
