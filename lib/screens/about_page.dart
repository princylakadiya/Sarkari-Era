import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants.dart';
import 'bottom_navigation_page.dart';

class AboutPage extends StatelessWidget {
  static const List about=[
    "Sarkari Era app finds latest jobs in government sector and students can apply for jobs in different categories as per their qualification in this app.",
    "Whenever any type of jobs will be released in any sector of the government, then first of all you will be informed through this app.",
    "Students can also apply for jobs as per their qualification and can also give a test like exam before getting the jobs.",
    "To prepare for the subjects that appear in the exam, complete PDFs of different subjects are already available in this app .",
  ];
  static const List uses=[
    "Get new notification when job announced.",
    "Subject wise mock test.",
    "Subject wise pdf & notes.",
    "Qualification wise exam details.",
    "Short notice for all exams.",
    "User friendly exam details.",
    "Old Exam Notification to know about future exams.",
    "Exam calendar.",
    "Apply link of official website.",
    "Notification download link.",
    "Exam date with Exam syllabus.",
    "Admit Card Information.",
    "Help Section for Students.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("About Application",style: TextStyle(fontFamily: "poppins",fontWeight: FontWeight.bold,fontSize: 20.sp)),
      ),
      body: WillPopScope(
        onWillPop: () => OnBackPressed(context),
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w,),
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text("About SarkariEra ?",style: TextStyle(
                        fontSize: 30.sp,
                        fontFamily: "poppins",
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF000080)
                    ),),
                    SizedBox(height: 25.h,),
                    Column(
                      children: about.map((strone){
                        return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              Text("\u2022", style: TextStyle(fontSize: 30.sp),), //bullet text
                              SizedBox(width: 10,), //space between bullet and text
                              Expanded(
                                child:Text(strone, style: TextStyle(fontSize: 17.sp),), //text
                              )
                            ]
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 25.h,),
                    Text("Why to use SarkariEra ?",style: TextStyle(
                        fontSize: 24.sp,
                        fontFamily: "poppins",
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF000080)
                    ),),
                    SizedBox(height: 20.h,),
                    Column(
                      children: uses.map((strone){
                        return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              Text("\u2022", style: TextStyle(fontSize: 30.sp),), //bullet text
                              SizedBox(width: 10,), //space between bullet and text
                              Expanded(
                                child:Text(strone, style: TextStyle(fontSize: 17.sp),), //text
                              )
                            ]
                        );
                      }).toList(),
                    ),
                  ],
                ),
              )
          ),
        ),
      ),
    );
  }
  OnBackPressed(BuildContext context) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavigationPage(),));
  }
}
