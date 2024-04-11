import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {

  // create an instance of Firebase Messagging
  final _firebaseMessaging = FirebaseMessaging.instance;

  // function to inizialize notifications
  Future<void> initNotifications() async {

    // request permission from user (will prompt user)
    await _firebaseMessaging.requestPermission();

    // fetch the FCM token for this device
    final fCMToken = await _firebaseMessaging.getToken();

    // print the token 
    print('Token: $fCMToken');
  }

  // function to handle received messages

  // function to initialize foreground and background settings 
}