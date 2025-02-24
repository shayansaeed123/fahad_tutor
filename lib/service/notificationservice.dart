import 'dart:convert';
import 'dart:io';

import 'package:fahad_tutor/main.dart';
import 'package:fahad_tutor/repo/tutor_repo.dart';
import 'package:fahad_tutor/res/reusableloading.dart';
import 'package:fahad_tutor/res/reusabletutordetails.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

class NotificationService {
  
  // static void initialize() {
  //   FirebaseMessaging.instance.requestPermission();

  //   // Handle notification when the app is in the foreground
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     _showNotificationDialog(message);
  //   });

  //   // Handle notification when the app is opened by tapping the notification
  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //     _showNotificationDialog(message);
  //   });
  // }

//   static void _showNotificationDialog(RemoteMessage message) {
// TutorRepository repository = TutorRepository();
//     final navigator = navigatorKey.currentState!;
//     final title = message.notification?.title ?? "Notification";
//     final body = message.notification?.body ?? "No details provided";
//     final data = message.data;
//     final tuition_id = data['tution_id'];
//     print("bodyyyyyyyyyyyyyyyyyyyyyy $body");
//     print("dataaaaaaaaaaaaaaaaaaaaaa $data");
//     print('Tuition id ${data['tution_id']}');
//     print(message.notification!.title);

//     // Ensure dialog is shown on the current context
//     if(tuition_id != null || tuition_id != ""){
//       print('Tuition id ${data['tution_id']}');
//       // Get the NotificationState from Provider
//       final notificationState = Provider.of<NotificationState>(navigator.context, listen: false);
//       notificationState.setAlready(1);
//       repository.getSingleTuitions(tuition_id).then((value) {
//                                     reusabletutorDetails(
//                                         navigator.context,
//                                         repository.formatInfo(repository.remark.value),
//                                         repository.class_namee.value,
//                                         repository.tuition_name.value,
//                                         repository.placment.value,
//                                         repository.job_closed.value,
//                                         repository.subject_name.value,
//                                         repository.share_date.value,
//                                         repository.location.value,
//                                         repository.limit_statement.value, () {
//                                       if (repository.g_id == '0') {
//                                        if(data['Online_terms_check']==1){
//                                                       reusableMessagedialog(navigator.context, data['Online_terms_check_heading'], repository.formatInfo(data['Online_terms_check_text']), 'Agree', 'Disagree', (){
//                                                         repository.applyTuitions(navigator.context,() {
//                                                           // setState(() {
//                                                           //   data['already'] = 1;
//                                                           // });
//                                                           notificationState.setAlready(1); // Replace setState with Provider
//                                                         });
//                                                         Navigator.pop(navigator.context);
//                                                       }, (){Navigator.pop(navigator.context);});
//                                                     }else{
//                                                         repository.applyTuitions(navigator.context,() {
//                                                           // setState(() {
//                                                           //   data['already'] = 1;
//                                                           // });
//                                                           notificationState.setAlready(1); // Replace setState with Provider
//                                                         });
//                                                     }
//                                       } else {
//                                         reusableMessagedialog(
//                                             navigator.context,
//                                             'Classes',
//                                             'Are you sure${repository.class_name}',
//                                             'Confirm','Cancel', () {
//                                           if(data['Online_terms_check']==1){
//                                                       reusableMessagedialog(navigator.context, data['Online_terms_check_heading'], repository.formatInfo(data['Online_terms_check_text']), 'Agree', 'Disagree', (){
//                                                         repository.applyTuitions(navigator.context,() {
//                                                           // setState(() {
//                                                           //   data['already'] = 1;
//                                                           // });
//                                                           notificationState.setAlready(1); // Replace setState with Provider
//                                                         });
//                                                         Navigator.pop(navigator.context);
//                                                       }, (){Navigator.pop(navigator.context);});
//                                                     }else{
//                                                         repository.applyTuitions(navigator.context,() {
//                                                           // setState(() {
//                                                           //   data['already'] = 1;
//                                                           // });
//                                                           notificationState.setAlready(1); // Replace setState with Provider
//                                                         });
//                                                     }
//                                         }, () {
//                                           Navigator.pop(navigator.context);
//                                         });
//                                       }
//                                     }, repository.g_id.value, tuition_id, repository.already.value,() {
//                                                 // setState(() {
//                                                 //   data['already'] = 1;
//                                                 // });
//                                                 notificationState.setAlready(1); // Replace setState with Provider

//                                               });
//                                     // setState(() {});
//                                   });
//     }else{
//     showDialog(
//       context: navigator.context,
//       builder: (context) => AlertDialog(
//         title: Text(title),
//         content: Text(body),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context); // Close the dialog
//             },
//             child: Text("OK"),
//           ),
//         ],
//       ),
//     );
//   }
//   }
// }
  

  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    FirebaseMessaging.instance.requestPermission();

    _initLocalNotifications();

    // Handle foreground notification (when app is open)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (Platform.isAndroid) {
        _showForegroundNotification(message);
      }
    });

    // Handle notification tap when app is in background or terminated
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      handleNotificationClick(message);
    });
  }

  static void _initLocalNotifications() {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidSettings,
      iOS: const DarwinInitializationSettings(),
    );
    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        _handleLocalNotificationClick(response);
      },
    );
  }

  static void _showForegroundNotification(RemoteMessage message) {
  final title = message.notification?.title ?? "Notification";
  final body = message.notification?.body ?? "No details provided";
  final data = message.data; // Get full data map

  // Convert `data` map to JSON string
  final String jsonData = jsonEncode(data);

  _flutterLocalNotificationsPlugin.show(
    message.hashCode,
    title,
    body,
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        channelDescription: 'This channel is used for important notifications.',
        importance: Importance.high,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    ),
    payload: jsonData, // ✅ Store full `data` map in payload
  );
}

static void handleNotificationClick(RemoteMessage message) {
  final Map<String, dynamic> data = message.data;
  final String? tuitionId = data['tution_id'];  // ✅ Get tuition_id safely
  final title = message.notification?.title ?? "Notification";
    final body = message.notification?.body ?? "No details provided";
    print('Tuition ID $tuitionId');

  print("🟢 Background Notification Clicked: $data");

  if (tuitionId != null && tuitionId.isNotEmpty) {
    _showNotificationDialog(tuitionId, data, title,body); // ✅ Pass tuitionId and data
  } else {
    print("❌ Error: tuition_id is missing");
  }
}




  static void _handleLocalNotificationClick(NotificationResponse response) {
  final context = navigatorKey.currentContext;
  if (context == null) return;

  try {
    // ✅ Decode JSON payload (it contains full `data`)
    final Map<String, dynamic> data = jsonDecode(response.payload ?? '{}');

    // ✅ Extract `tuition_id`, `title`, and `body`
    final String tuitionId = data['tution_id'] ?? '';
    final String title = data['title'] ?? 'Notification';
    final String body = data['body'] ?? 'No details provided';
    print('Tuition ID $tuitionId');
    if (tuitionId.isNotEmpty) {
      _showNotificationDialog(tuitionId, data, title, body);  // ✅ Pass title & body
    }
  } catch (e) {
    print("Error decoding notification payload: $e");
  }
}


  

  static void _showNotificationDialog(String tuitionId,Map<String, dynamic> data, String title,String body) {
    
    TutorRepository repository = TutorRepository();
    final navigator = navigatorKey.currentContext;
    if (navigator == null) return;

    // Ensure dialog is shown on the current context
    if(tuitionId != null || tuitionId != ""){
//       print('Tuition id ${data['tution_id']}');
//       // Get the NotificationState from Provider
      final notificationState = Provider.of<NotificationState>(navigator, listen: false);
      notificationState.setAlready(1);
      repository.getSingleTuitions(tuitionId).then((value) {
                                    reusabletutorDetails(
                                        navigator,
                                        repository.formatInfo(repository.remark.value),
                                        repository.class_namee.value,
                                        repository.tuition_name.value,
                                        repository.placment.value,
                                        repository.job_closed.value,
                                        repository.subject_name.value,
                                        repository.share_date.value,
                                        repository.location.value,
                                        repository.limit_statement.value, () {
                                      if (repository.g_id == '0') {
                                       if(data['Online_terms_check']==1){
                                                      reusableMessagedialog(navigator, data['Online_terms_check_heading'], repository.formatInfo(data['Online_terms_check_text']), 'Agree', 'Disagree', (){
                                                        repository.applyTuitions(navigator,() {
                                                          // setState(() {
                                                          //   data['already'] = 1;
                                                          // });
                                                          notificationState.setAlready(1); // Replace setState with Provider
                                                        });
                                                        Navigator.pop(navigator);
                                                      }, (){Navigator.pop(navigator);});
                                                    }else{
                                                        repository.applyTuitions(navigator,() {
                                                          // setState(() {
                                                          //   data['already'] = 1;
                                                          // });
                                                          notificationState.setAlready(1); // Replace setState with Provider
                                                        });
                                                    }
                                      } else {
                                        reusableMessagedialog(
                                            navigator,
                                            'Classes',
                                            'Are you sure${repository.class_name}',
                                            'Confirm','Cancel', () {
                                          if(data['Online_terms_check']==1){
                                                      reusableMessagedialog(navigator, data['Online_terms_check_heading'], repository.formatInfo(data['Online_terms_check_text']), 'Agree', 'Disagree', (){
                                                        repository.applyTuitions(navigator,() {
                                                          // setState(() {
                                                          //   data['already'] = 1;
                                                          // });
                                                          notificationState.setAlready(1); // Replace setState with Provider
                                                        });
                                                        Navigator.pop(navigator);
                                                      }, (){Navigator.pop(navigator);});
                                                    }else{
                                                        repository.applyTuitions(navigator,() {
                                                          // setState(() {
                                                          //   data['already'] = 1;
                                                          // });
                                                          notificationState.setAlready(1); // Replace setState with Provider
                                                        });
                                                    }
                                        }, () {
                                          Navigator.pop(navigator);
                                        });
                                      }
                                    }, repository.g_id.value, tuitionId, repository.already.value,() {
                                                // setState(() {
                                                //   data['already'] = 1;
                                                // });
                                                notificationState.setAlready(1); // Replace setState with Provider

                                              });
                                    // setState(() {});
                                  });
    }else{
    showDialog(
      context: navigator,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }
  }
}

class NotificationState with ChangeNotifier {
  int _already = 0;

  int get already => _already;

  void setAlready(int value) {
    _already = value;
    notifyListeners();  // Notify listeners when the state changes
  }
}

