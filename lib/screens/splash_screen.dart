import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sem5project/modalclasses/sharedPreferencesData.dart';
import 'package:sem5project/screens/admin_home_page.dart';
import 'package:sem5project/screens/bottom_navigation_page.dart';
import 'package:sem5project/screens/registration_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import '../notificationData/notificationServices.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  NotificationServices notificationServices=NotificationServices();
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoginData();
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    _controller = VideoPlayerController.asset("Images/splash.mp4");
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(false);
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:  Center(
        child: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return AspectRatio(aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              );
            }else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  void getLoginData() {
    Timer(Duration(seconds: 3), () async {
      SharedPreferemcesData.prefs = await SharedPreferences.getInstance();
      bool getlogedInValue=SharedPreferemcesData.prefs!.getBool("login")??false;
      String role=SharedPreferemcesData.prefs!.getString("role")??"role";
      if(getlogedInValue)
        {
          if(role=="user")
            {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavigationPage(),));
            }
          else
            {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminHomePage(),));
            }
        }
      else
        {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>const RegistrationPage(),));
        }
    });
  }
}
