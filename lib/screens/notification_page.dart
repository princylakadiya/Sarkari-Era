import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sem5project/constants.dart';
import 'package:http/http.dart' as http;
import 'package:sem5project/screens/exam_details_page.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  Map data={};
  bool isLoad=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotificationsData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text("Notifications",
              style: TextStyle(
                  fontFamily: "poppins",
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold)),
        ),
        body:isLoad?Center(
          child: LoadingAnimationWidget.threeRotatingDots(color: primaryColor, size: 60.w),
        ):(data['data'].isEmpty?Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Center(
            child: Text("No Notifications Received",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: "poppins"
                )),
          ),
        ):ListView.builder(
          itemCount: data['data'].length,
          itemBuilder: (context, index) {
            return IconTextContainer("LogoImages/notificationLogo.png", data['data'][index]['title'], data['data'][index]['description']);
          },))
    );
  }

  Widget IconTextContainer(String img, String title,String description) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ExamDetailsPage(examname: description, tableName: title),));
      },
      child: Container(
        height: 95.h,
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Row(
            children: [
              SizedBox(
                width: 10.w,
              ),
              Container(
                width: 50.w,
                height: 50.h,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(img))),
              ),
              SizedBox(
                width: 10.w,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 25.h,
                    width: 220.w,
                    child: Text(title,style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.black,
                        fontFamily: "poppins",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600
                    )),
                  ),
                  SizedBox(
                    height: 25.h,
                    width: 220.w,
                    child: Text(description,style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: greyColor,
                      fontFamily: "poppins",
                      fontSize: 12.sp,
                    )),
                  ),
                ],
              ),
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

  Future<void> getNotificationsData() async {
    var url = Uri.parse('http://10.0.2.2/php_projects/sarkari_era_apis/getNotificationsData.php');
    var response = await http.post(url);
    data=jsonDecode(response.body);
    isLoad=false;
    setState(() {

    });

  }
}
