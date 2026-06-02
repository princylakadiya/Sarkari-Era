import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sem5project/examCallApi/examCallApi.dart';
import 'package:sem5project/modalclasses/examJsonParse.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class ExamDetailsPage extends StatefulWidget {
  final String tableName;
  final String examname;

  ExamDetailsPage({required this.examname, required this.tableName});

  @override
  State<ExamDetailsPage> createState() => _ExamDetailsPageState();
}

class _ExamDetailsPageState extends State<ExamDetailsPage> {
  ExamJsonParse? e1;
  bool isLoad=true;
  String exam1="";
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    if(widget.tableName=="UPSC/PCS")
    {
      exam1="UPSC";
    }
    else if(widget.tableName=="BANK JOBS")
    {
      exam1="BANK";
    }
    else if(widget.tableName=="STATE GOV.")
    {
      exam1="STATE";
    }
    else {
      exam1=widget.tableName;
    }
    getExamDetails();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Sarkari Era",
            style: TextStyle(
                fontFamily: 'poppins',
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
                fontSize: 24.sp)),
      ),
      body: isLoad?Center(
        child: LoadingAnimationWidget.threeRotatingDots(color: primaryColor, size: 60.w),
      ):(e1!.examJsonParse!.applyDate==""?Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Center(
          child: Text("The Exam is not yet uploaded, you will be notified soon if it is uploaded",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: "poppins"
              )),
        ),
      ):SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 13.h, vertical: 10.h),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 3),
                          blurRadius: 3,
                          spreadRadius: 2,
                          color: Colors.grey)
                    ]),
                width: double.infinity,
                child: Row(
                  children: [
                    Image.asset("LogoImages/notificationLogo.png"),
                    Expanded(
                        child: Text(
                          "${widget.examname}",
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontFamily: "poppins"),
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 13.h,
              ),
              Text(
                "Details About Exam",
                style: TextStyle(
                    fontFamily: "poppins",
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                    color: Color(0xFF0055FA)),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 3),
                          blurRadius: 3,
                          spreadRadius: 2,
                          color: greyColor)
                    ]),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Important Dates :",
                      style: sb15redTextStyle,
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    Text(
                      "Apply Date : ${e1!.examJsonParse!.applyDate}",
                      style: sb14blackTextStyle,
                    ),
                    Text(
                      "Last Apply Date : ${e1!.examJsonParse!.lastApplyDate}",
                      style: sb14blackTextStyle,
                    ),
                    Text(
                      "Exam Date : ${e1!.examJsonParse!.examDate}",
                      style: sb14blackTextStyle,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 3),
                          blurRadius: 3,
                          spreadRadius: 2,
                          color: greyColor)
                    ]),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Educational Qualification :",
                      style: sb15redTextStyle,
                    ),
                    Text(
                      "${e1!.examJsonParse!.educationQualification}",
                      style: sb14blackTextStyle,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 3),
                          blurRadius: 3,
                          spreadRadius: 2,
                          color: greyColor)
                    ]),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Age Limit :",
                      style: sb15redTextStyle,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      "• Minimum Age : ${e1!.examJsonParse!.minAge} Years",
                      style: sb14blackTextStyle,
                    ),
                    Text(
                      "• Maximum Age : ${e1!.examJsonParse!.maxAge} Years",
                      style: sb14blackTextStyle,
                    ),
                    Text(
                      "• Age relaxation extra as per rules",
                      style: sb14blackTextStyle,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 3),
                          blurRadius: 3,
                          spreadRadius: 2,
                          color: greyColor)
                    ]),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Application Fees :",
                      style: sb15redTextStyle,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    DataTable(columns: [
                      DataColumn(label: Text("Category")),
                      DataColumn(label: Text("Online Charge")),
                    ], rows: [
                      DataRow(cells: [
                        DataCell(Text("UR / OBC")),
                        DataCell(Text("₹ ${e1!.examJsonParse!.urobcFees}")),
                      ]),
                      DataRow(cells: [
                        DataCell(Text("SC / ST / PWD")),
                        DataCell(Text("₹ ${e1!.examJsonParse!.scstpwdFees}")),
                      ]),
                      DataRow(cells: [
                        DataCell(Text("Payment Method")),
                        DataCell(Text("${e1!.examJsonParse!.paymentMethod}")),
                      ])
                    ])
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 3),
                          blurRadius: 3,
                          spreadRadius: 2,
                          color: greyColor)
                    ]),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Selection Process :",
                      style: sb15redTextStyle,
                    ),
                    Text(
                      "${e1!.examJsonParse!.selectionProcess}",
                      style: sb14blackTextStyle,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 3),
                          blurRadius: 3,
                          spreadRadius: 2,
                          color: greyColor)
                    ]),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Download Old Notification For More Details :",
                      style: sb15redTextStyle,
                    ),
                    GestureDetector(
                      onTap:() => _launchUrl(Uri.parse("${e1!.examJsonParse!.oldNotificationLink}")),
                      child: Text(
                        "${e1!.examJsonParse!.oldNotificationLink}",
                        style: linkTextStyle,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 3),
                          blurRadius: 3,
                          spreadRadius: 2,
                          color: greyColor)
                    ]),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Apply Online Here :",
                      style: sb15redTextStyle,
                    ),
                    GestureDetector(
                      onTap:() => _launchUrl(Uri.parse("${e1!.examJsonParse!.onlineApplyLink}")),
                      child: Text(
                        "${e1!.examJsonParse!.onlineApplyLink}",
                        style: linkTextStyle,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 3),
                          blurRadius: 3,
                          spreadRadius: 2,
                          color: greyColor)
                    ]),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Download New Notification :",
                      style: sb15redTextStyle,
                    ),
                    GestureDetector(
                      onTap:() => _launchUrl(Uri.parse("${e1!.examJsonParse!.newNotificationLink}")),
                      child: Text(
                        "${e1!.examJsonParse!.newNotificationLink}",
                        style: linkTextStyle,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 3),
                          blurRadius: 3,
                          spreadRadius: 2,
                          color: greyColor)
                    ]),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.examname} Official Website Link :",
                      style: sb15redTextStyle,
                    ),
                    GestureDetector(
                      onTap:() => _launchUrl(Uri.parse("${e1!.examJsonParse!.officialWebsiteLink}")),
                      child: Text(
                        "${e1!.examJsonParse!.officialWebsiteLink}",
                        style: linkTextStyle,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      )),
    );
  }
  Future<void> _launchUrl(Uri _url) async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
  getExamDetails()
  async {
    Map map1= await CallExamDetailsApi.getExamDetails(tableName: exam1.trim(), examName: widget.examname.trim());
    e1=ExamJsonParse(map: map1);
    isLoad=false;
    setState(() {

    });
  }
}
