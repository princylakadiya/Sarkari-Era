import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';

class AdminShowRequestsPage extends StatefulWidget {
  const AdminShowRequestsPage({super.key});

  @override
  State<AdminShowRequestsPage> createState() => _AdminShowRequestsPageState();
}

class _AdminShowRequestsPageState extends State<AdminShowRequestsPage> {
  bool isLoad=true;
  Map data={};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRequests();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Users",
            style: TextStyle(
                fontFamily: "poppins",
                fontSize: 20.sp,
                fontWeight: FontWeight.bold)),
      ),
      body: isLoad?Center(
        child: LoadingAnimationWidget.threeRotatingDots(color: primaryColor, size: 60.w),
      ):(data['data'].isEmpty?Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Center(
          child: Text("No users are registered yet",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: "poppins"
              )),
        ),
      ):Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: data['data'].length,
              itemBuilder: (context, index) {
                return Container(
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex :2,
                                child: Container(
                                  height: 50.h,
                                  width: 50.w,
                                  child: Image.asset("LogoImages/contactUs.png"),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                flex: 8,
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(text: "Name : ",style: sb14blackTextStyle),
                                            TextSpan(text: "${data['data'][index]['name']}",style: sb14SmallTextStyle),
                                          ]
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(text: "Email : ",style: sb14blackTextStyle),
                                            TextSpan(text: "${data['data'][index]['email']}",style: sb14SmallTextStyle),
                                          ]
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                            children: [
                                              TextSpan(text: "Mobile No. : ",style: sb14blackTextStyle),
                                              TextSpan(text: "${data['data'][index]['mno']}",style: sb14SmallTextStyle),
                                            ]
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                            children: [
                                              TextSpan(text: "Message : ",style: sb14blackTextStyle),
                                              TextSpan(text: "${data['data'][index]['problem']}",style: sb14SmallTextStyle),
                                            ]
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                  ),
                );
              },),
          )
        ],
      )),
    );
  }

  Future<void> getRequests() async {
    var url = Uri.parse('http://10.0.2.2/php_projects/sarkari_era_apis/getContactRequests.php');
    var response = await http.post(url);
    data=jsonDecode(response.body);
    isLoad=false;
    setState(() {

    });

  }
}
