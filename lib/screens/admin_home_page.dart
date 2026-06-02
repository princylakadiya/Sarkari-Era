import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sem5project/modalclasses/sharedPreferencesData.dart';
import 'package:sem5project/screens/add_new_exam_page.dart';
import 'package:sem5project/screens/admin_help_requests_page.dart';
import 'package:sem5project/screens/registration_page.dart';
import 'package:sem5project/screens/send_notification_page.dart';
import 'package:sem5project/screens/upload_pdf_page.dart';
import 'package:share_plus/share_plus.dart';
import '../constants.dart';
import 'admin_all_pdfs_page.dart';
import 'admin_all_users_page.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
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
                          child: Text("Hi ! Admin",style: r22TextStyle),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.h,),
              profileItems("Help Requests", "LogoImages/contactUs.png", () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AdminShowRequestsPage(),));
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
      ),
      body: Column(
        children: [
          SizedBox(height: 10.h,),
          IconTextContainer(
            "LogoImages/addNotification.png",
            "Add New Exam",
                () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddNEwExamPage(),));
                },
          ),
          IconTextContainer(
            "LogoImages/pdfLogo.png",
            "Add Pdf & Notes",
                () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AdminAllPdfsPage(),));
                },
          ),
          IconTextContainer(
            "LogoImages/sendTextNotice.png",
            "Send Notification",
                () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SendNotificationPage(),));
                },
          ),
          IconTextContainer(
            "LogoImages/profile.png",
            "Application Users",
                () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AdminAllUsersPage(),));
            },
          ),
        ],
      ),
    );
  }

  Widget IconTextContainer(String img, String text, Function() onpress) {
    return Container(
      height: 95.h,
      child: GestureDetector(
        onTap: () {
          onpress();
        },
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Row(
            children: [
              SizedBox(
                width: 20.w,
              ),
              Container(
                width: 50.w,
                height: 50.h,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(img))),
              ),
              SizedBox(
                width: 25.w,
              ),
              Text(
                text,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 24.sp,
                    fontFamily: "poppins"),
              )
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          margin: EdgeInsets.all(10),
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
}
