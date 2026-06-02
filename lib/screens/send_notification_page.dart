import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:sem5project/listData/examNames.dart';
import 'package:sem5project/screens/admin_home_page.dart';
import 'package:sem5project/widgets/formButton.dart';

import '../constants.dart';

class SendNotificationPage extends StatefulWidget {
  const SendNotificationPage({super.key});

  @override
  State<SendNotificationPage> createState() => _SendNotificationPageState();
}

class _SendNotificationPageState extends State<SendNotificationPage> {
  List exams=ExamNames.UPSC;
  String selectedExam="Civil Services Examination (CSE)";
  String selectedCategory=ExamNames.exams[0];
  bool isLoad=false;

  void setExamDropDown(){
    if (selectedCategory == ExamNames.exams[0]) {
      exams=ExamNames.UPSC;
    } else if (selectedCategory == ExamNames.exams[1]) {
      exams=ExamNames.SSC;
    } else if (selectedCategory == ExamNames.exams[2]) {
      exams=ExamNames.Bank;
    } else if (selectedCategory == ExamNames.exams[3]) {
      exams=ExamNames.Railway;
    } else if (selectedCategory == ExamNames.exams[4]) {
      exams=ExamNames.Defence;
    } else if (selectedCategory == ExamNames.exams[5]) {
      exams=ExamNames.Agniveer;
    } else if (selectedCategory == ExamNames.exams[6]) {
      exams=ExamNames.Teaching;
    } else if (selectedCategory == ExamNames.exams[7]) {
      exams=ExamNames.Paramilitary;
    } else if (selectedCategory == ExamNames.exams[8]) {
      exams=ExamNames.State;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Send Notification",
            style: TextStyle(
                fontFamily: 'poppins',
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
                fontSize: 24.sp)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 20.h,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Select Exam Category :-",style: b16TextStyle),
                SizedBox(height: 5.h,),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColor,width: 1.5)
                      )
                    // Add more decoration..
                  ),
                  isExpanded: true,
                  elevation: 5,
                  value: selectedCategory,
                  hint: const Text(
                    'Select Your Gender',
                    style: TextStyle(fontSize: 14),
                  ),
                  items: ExamNames.exams.map((e) {
                    return DropdownMenuItem(
                        value: e,
                        child: Text(e,style: TextStyle(
                            color: Colors.black,
                            fontFamily: "poppins"
                        ),));
                  }).toList() ,
                  onChanged: (value) {
                    selectedCategory=value.toString();
                    setExamDropDown();
                    selectedExam=exams[0];
                    setState(() {

                    });
                  },),
              ],
            ),
            SizedBox(height: 20.h,),
            Column(
              children: [
                Text("Select Exam Name To Which You Want To Send Notification :-",style: b16TextStyle),
                SizedBox(height: 5.h,),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColor,width: 1.5)
                      )
                    // Add more decoration..
                  ),
                  isExpanded: true,
                  elevation: 5,
                  value: selectedExam,
                  hint: const Text(
                    'Select Your Gender',
                    style: TextStyle(fontSize: 14),
                  ),
                  items: exams.map((e) {
                    return DropdownMenuItem(
                        value: e,
                        child: Text(e,style: TextStyle(
                            color: Colors.black,
                            fontFamily: "poppins"
                        ),));
                  }).toList() ,
                  onChanged: (value) {
                    selectedExam=value.toString();
                    setState(() {

                    });
                  },),
              ],
            ),
            SizedBox(height: 50.h,),
            FormButton(name: "Send", isload: isLoad, onpress: () async {
              if(selectedCategory!=""&&selectedExam!="")
                {
                  isLoad=true;
                  setState(() {

                  });
                  var url = Uri.parse('http://10.0.2.2/php_projects/sarkari_era_apis/getDeviceTokens.php');
                  var response = await http.post(url);
                  Map map1=jsonDecode(response.body);
                  for(int i=0;i<map1['data'].length;i++)
                    {
                      Send("${map1['data'][i]['device_token']}");
                    }
                  Map map={
                    'table_name': selectedCategory,
                    'exam_name':selectedExam
                  };
                  var url1 = Uri.parse('http://10.0.2.2/php_projects/sarkari_era_apis/addNotification.php');
                  var response1 = await http.post(url1, body: map);
                  isLoad=false;
                  setState(() {

                  });
                  infoToast("Success", "Notification Sent", context);
                }
            },)
          ],
        ),
      ),
    );
  }
  Future<void> Send(String deviceToken) async {
    var data={
      'to':deviceToken,
      'priority':'high',
      'notification': {
        'title':selectedCategory,
        "body":selectedExam
      },
      'data':{
        'type':selectedCategory
      }
    };
    await http.post(Uri.parse("https://fcm.googleapis.com/fcm/send"),body: jsonEncode(data),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization' : 'key=AIzaSyA7TBGHrqj-ofAthz2O6O4RbxnkJGvo7Xs'
    }
    );
  }
}
