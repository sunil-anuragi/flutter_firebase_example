import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class pushNotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  Future<void> setUpInteractedMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    //Android
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    initializeUserToken();
    log('User granted permission: ${settings.authorizationStatus}');

    //Get the message from tapping on the notification when app is not in foreground
    RemoteMessage? initialMessage = await messaging.getInitialMessage();

    //If the message contains a service, navigate to the admin
    if (initialMessage != null) {
      await _mapMessageToUser(initialMessage);
    }

    //This listens for messages when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen(_mapMessageToUser);

    //Listen to messages in Foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      //Initialize FlutterLocalNotifications
      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();

      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'schedular_channel', // id
        'Schedular Notifications', // title
        description:
            'This channel is used for Schedular app notifications.', // description
        importance: Importance.max,
      );

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      //Construct local notification using our created channel
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: "@mipmap/ic_launcher", //Your app icon goes here
                // other properties...
              ),
            ));
      }
    });
  }

  shownotification(title, body) {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'schedular_channel', // id
      'Schedular Notifications', // title
      description:
          'This channel is used for Schedular app notifications.', // description
      importance: Importance.max,
    );
    flutterLocalNotificationsPlugin.show(
        0,
        title,
        body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: "@mipmap/ic_launcher", //Your app icon goes here
            // other properties...
          ),
        ));
  }

  initializeUserToken() async {
    return await FirebaseMessaging.instance.getToken().then((token) {
      log("fcmtoken=>>>" + token.toString());
      return token;
    });
  }

  _mapMessageToUser(RemoteMessage message) {
    Map<String, dynamic> json = message.data;

    if (message.data['service'] != null) {
      // Appointment appt = Appointment(
      //     name: json['name'],
      //     time: DateTime.parse(json['time']),
      //     service: json['service'],
      //     status: json['status'],
      //     id: json['id']);
      // Navigator.of(context).pushNamed('/details', arguments: appt);
    } else {
      // Navigator.of(context).pushNamed('/user', arguments: json);
    }
  }
}
