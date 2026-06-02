import 'dart:io';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sem5project/listData/examNames.dart';
import 'package:sem5project/screens/about_page.dart';
import 'package:sem5project/screens/exams_name_page.dart';
import 'package:sem5project/screens/free_test_page.dart';
import 'package:sem5project/screens/help_page.dart';
import 'package:sem5project/screens/notification_page.dart';
import 'package:sem5project/screens/pdf_notes_page.dart';
import 'package:sem5project/screens/profile_page.dart';
import 'package:sem5project/screens/registration_page.dart';
import 'package:sem5project/widgets/formButton.dart';
import 'package:share_plus/share_plus.dart';
import '../constants.dart';
import '../modalclasses/sharedPreferencesData.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int sliderPosition = 0;
  String Name="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserName();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            children: [
              SizedBox(height: 60.h,),
              Container(
                width: double.infinity,
                height: 210.h,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 130.h,
                        width: 130.h,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("LogoImages/profileLogo.png")
                          )
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 15.w),
                          child: Text("Hi ! ${SharedPreferemcesData.prefs!.getString("name")}",style: r22TextStyle),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.h,),
              profileItems("My Profile", "LogoImages/profile.png", () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilePage(),));
              },),
              profileItems("Contact Us", "LogoImages/contactUs.png", () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HelpPage(),));
              },),
              profileItems("About Us", "LogoImages/notificationLogo.png", () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AboutPage(),));
              },),
              profileItems("Share", "LogoImages/share.png", () {
                Share.share("Download Our Application at PlayStore : https://play.google.com , You can also checkout in YouTube : https://www.youtube.com");
              },),
              profileItems("Logout", "LogoImages/logout.png", () {
                SharedPreferemcesData.prefs!.setBool("login", false);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegistrationPage(),));
              },),
              SizedBox(height: 20.h,),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Sarkari Era",
            style: TextStyle(
                fontFamily: 'poppins',
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
                fontSize: 24.sp)),
        actions: [
          appBarIcon(
            Icon(Icons.notifications_active_outlined),
            () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage(),));
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          children: [
            SizedBox(
              height: 5.h,
            ),
            Text("Hi ! $Name",style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 25.sp,
              letterSpacing: 1.5,
              fontFamily: "poppins"
            )),
            SizedBox(
              height: 7.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                testContainers("PDF &\nNOTES", "LogoImages/pdfLogo.png",() {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PdfNotesPage(),));
                }),
                SizedBox(
                  width: 10.w,
                ),
                testContainers("FREE TEST", "LogoImages/mockTest.png",() {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FreeTestPage(),));
                }),
              ],
            ),
            SizedBox(
              height: 12.h,
            ),
            Stack(
              children: [
                CarouselSlider.builder(
                    itemCount: 5,
                    itemBuilder: (context, index, realIndex) {
                      return Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage("Images/banner${index+1}.png")),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 5.0), //(x,y)
                                blurRadius: 6.0,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(15.w),
                            color: Colors.white),
                        margin: EdgeInsets.symmetric(horizontal: 2.w),
                        width: double.infinity,
                      );
                    },
                    options: CarouselOptions(
                      viewportFraction: 1,
                      initialPage: sliderPosition,
                      onPageChanged: (index, reason) {
                        setState(() {
                          sliderPosition = index;
                        });
                      },
                      height: 195.h,
                      autoPlayAnimationDuration: Duration(milliseconds: 400),
                      autoPlayInterval: Duration(seconds: 4),
                      autoPlay: true,
                    )),
                Positioned(
                  bottom: 10.h,
                  left: 120.w,
                  child: DotsIndicator(
                    dotsCount: 5,
                    position: sliderPosition,
                    decorator: DotsDecorator(
                        activeColor: primaryColor,
                        size: const Size.square(9.0),
                        activeSize: const Size(18.0, 9.0),
                        activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              height: 38.h,
              child: ListView.builder(
                itemCount: ExamNames.category.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ExamsNamePage(data: ExamNames.category[index]),));
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10.w,bottom: 5.h),
                      width: 74.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey[400]!, width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 5.0), //(x,y)
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Center(
                          child: Text(ExamNames.category[index], style: b16TextStyle)),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Expanded(
              child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisExtent: 80.h,
                    mainAxisSpacing: 4.h,
                    crossAxisSpacing: 10.w),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ExamsNamePage(data: ExamNames.exams[index]),));
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      elevation: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[400]!, width: 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              child: Image.asset(ExamNames.GridImages[index]),
                              height: 45.w,
                              width: 45.h,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            FittedBox(
                              fit: BoxFit.fill,
                              child: Text(ExamNames.exams[index], style: b13TextStyle),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void getUserName() {
    String str=SharedPreferemcesData.prefs!.getString("name")!;
    for(int i=0;i<str.length;i++)
    {
      if(str[i]==" ")
      {
        break;
      }
      else
      {
        Name=Name+str[i];
      }
    }
    setState(() {

    });
  }
}

Widget appBarIcon(Icon icon, Function() onpress) {
  return IconButton(
    onPressed: () {
      onpress();
    },
    icon: icon,
  );
}

Widget testContainers(String name, String img,Function() ontap) {
  return Expanded(
    child: GestureDetector(
      onTap: () {
        ontap();
      },
      child: Material(
        borderRadius: BorderRadius.circular(20),
        elevation: 15,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[400]!, width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
          height: 70.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40.h,
                width: 40.w,
                child: Image.asset(img),
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(name, style: b16TextStyle)
            ],
          ),
        ),
      ),
    ),
  );
}

Widget profileItems(String text,String img,Function() onpress){
  return GestureDetector(
    onTap: () {
      onpress();
    },
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
      child: Row(
        children: [
          SizedBox(
              height: 40.h,
              width: 40.w,
              child: Image.asset(img)),
          SizedBox(width: 15.w,),
          Text(text,style: r22TextStyle,)
        ],
      ),
    ),
  );
}
