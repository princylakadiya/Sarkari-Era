import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sem5project/notificationData/notificationServices.dart';
import 'package:sem5project/screens/about_page.dart';
import 'package:sem5project/screens/help_page.dart';
import 'package:sem5project/screens/home_page.dart';
import 'package:sem5project/screens/intro_page.dart';
import 'package:sem5project/screens/profile_page.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../constants.dart';

class BottomNavigationPage extends StatefulWidget {
  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int selectedPage=0;
  List Screens=[
    HomePage(),
    HelpPage(),
    AboutPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screens[selectedPage],
      bottomNavigationBar: StylishBottomBar(
          currentIndex: selectedPage,
          onTap: (index) {
            setState(() {
              selectedPage = index;
            });
          },
          items: [
            BottomBarItem(
                icon: Icon(Icons.home),
                title: Text("Home"),
                selectedColor: primaryColor),
            BottomBarItem(
                icon: Icon(Icons.help),
                title: Text("Help"),
                selectedColor: primaryColor),
            BottomBarItem(
                icon: Icon(Icons.account_box_outlined),
                title: Text("About"),
                selectedColor: primaryColor),
            BottomBarItem(
                icon: Icon(Icons.person),
                title: Text("Profile"),
                selectedColor: primaryColor),
          ],
          option: AnimatedBarOptions(
            iconStyle: IconStyle.animated,
            barAnimation: BarAnimation.fade,
            iconSize: 30.w,
          )),
    );
  }
}
