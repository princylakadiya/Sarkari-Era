import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sem5project/screens/bottom_navigation_page.dart';
import 'package:sem5project/screens/exams_name_page.dart';
import 'package:sem5project/screens/home_page.dart';

class NotificationServices {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<void> requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {

      Map<Permission,  PermissionStatus> statuses = await [
        Permission.notification,
      ].request();
    } else {
      Map<Permission,  PermissionStatus> statuses = await [
        Permission.notification,
      ].request();
    }
  }

  void initLocalNotifications(BuildContext context,
      RemoteMessage message) async {
    var androidInitializationSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        handleMessage(context, message);
      },
    );
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      initLocalNotifications(context, message);
      showNotification(message);
    });
  }

  void showNotification(RemoteMessage message) {
    AndroidNotificationChannel channel=AndroidNotificationChannel(
        message.notification!.android!.channelId.toString(),
        message.notification!.android!.channelId.toString() ,
      importance: Importance.max  ,
      showBadge: true ,
      playSound: true,
    );
    AndroidNotificationDetails androidNotificationDetails=AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: "Channel Description",
      importance: Importance.high,
      priority: Priority.high,
      ticker: "ticker",
      sound: channel.sound,
      playSound: true
    );

    NotificationDetails notificationDetails=NotificationDetails(
      android: androidNotificationDetails
    );

    Future.delayed(Duration.zero,() {
      flutterLocalNotificationsPlugin.show(0, message.notification!.title.toString(), message.notification!.body.toString(), notificationDetails);
    },);
  }

  void handleMessage(BuildContext context, RemoteMessage message)
  {
        String data=message.data['type'];
        Navigator.push(context, MaterialPageRoute(builder: (context) => ExamsNamePage(data: data),));
  }

  void setupInteractMessage(BuildContext context)async{

    //when app is terminated
    RemoteMessage? initialMessage=await FirebaseMessaging.instance.getInitialMessage();
    if(initialMessage!=null)
      {
        handleMessage(context, initialMessage);
      }

    //when app is in foreground
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event);
    });
  }
}
