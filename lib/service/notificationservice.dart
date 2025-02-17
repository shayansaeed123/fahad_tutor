import 'package:fahad_tutor/main.dart';
import 'package:fahad_tutor/repo/tutor_repo.dart';
import 'package:fahad_tutor/res/reusableloading.dart';
import 'package:fahad_tutor/res/reusabletutordetails.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationService {
  
  static void initialize() {
    FirebaseMessaging.instance.requestPermission();

    // Handle notification when the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showNotificationDialog(message);
    });

    // Handle notification when the app is opened by tapping the notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _showNotificationDialog(message);
    });
  }
  
  

  static void _showNotificationDialog(RemoteMessage message) {
TutorRepository repository = TutorRepository();
    final navigator = navigatorKey.currentState!;
    final title = message.notification?.title ?? "Notification";
    final body = message.notification?.body ?? "No details provided";
    final data = message.data;
    final tuition_id = data['tution_id'];
    print("bodyyyyyyyyyyyyyyyyyyyyyy $body");
    print("dataaaaaaaaaaaaaaaaaaaaaa $data");
    print('Tuition id ${data['tution_id']}');
    print(message.notification!.title);

    // Ensure dialog is shown on the current context
    if(tuition_id != null || tuition_id != ""){
      print('Tuition id ${data['tution_id']}');
      // Get the NotificationState from Provider
      final notificationState = Provider.of<NotificationState>(navigator.context, listen: false);
      notificationState.setAlready(1);
      repository.getSingleTuitions(tuition_id).then((value) {
                                    reusabletutorDetails(
                                        navigator.context,
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
                                                      reusableMessagedialog(navigator.context, data['Online_terms_check_heading'], repository.formatInfo(data['Online_terms_check_text']), 'Agree', 'Disagree', (){
                                                        repository.applyTuitions(navigator.context,() {
                                                          // setState(() {
                                                          //   data['already'] = 1;
                                                          // });
                                                          notificationState.setAlready(1); // Replace setState with Provider
                                                        });
                                                        Navigator.pop(navigator.context);
                                                      }, (){Navigator.pop(navigator.context);});
                                                    }else{
                                                        repository.applyTuitions(navigator.context,() {
                                                          // setState(() {
                                                          //   data['already'] = 1;
                                                          // });
                                                          notificationState.setAlready(1); // Replace setState with Provider
                                                        });
                                                    }
                                      } else {
                                        reusableMessagedialog(
                                            navigator.context,
                                            'Classes',
                                            'Are you sure${repository.class_name}',
                                            'Confirm','Cancel', () {
                                          if(data['Online_terms_check']==1){
                                                      reusableMessagedialog(navigator.context, data['Online_terms_check_heading'], repository.formatInfo(data['Online_terms_check_text']), 'Agree', 'Disagree', (){
                                                        repository.applyTuitions(navigator.context,() {
                                                          // setState(() {
                                                          //   data['already'] = 1;
                                                          // });
                                                          notificationState.setAlready(1); // Replace setState with Provider
                                                        });
                                                        Navigator.pop(navigator.context);
                                                      }, (){Navigator.pop(navigator.context);});
                                                    }else{
                                                        repository.applyTuitions(navigator.context,() {
                                                          // setState(() {
                                                          //   data['already'] = 1;
                                                          // });
                                                          notificationState.setAlready(1); // Replace setState with Provider
                                                        });
                                                    }
                                        }, () {
                                          Navigator.pop(navigator.context);
                                        });
                                      }
                                    }, repository.g_id.value, tuition_id, repository.already.value,() {
                                                // setState(() {
                                                //   data['already'] = 1;
                                                // });
                                                notificationState.setAlready(1); // Replace setState with Provider

                                              });
                                    // setState(() {});
                                  });
    }else{
    showDialog(
      context: navigator.context,
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

