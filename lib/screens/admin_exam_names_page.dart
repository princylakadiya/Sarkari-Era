import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sem5project/screens/add_new_exam_form.dart';
import '../constants.dart';

class AdminExamNamesPage extends StatefulWidget {
  final String tableName;
  AdminExamNamesPage({required this.tableName});

  @override
  State<AdminExamNamesPage> createState() => _AdminExamNamesPageState();
}

class _AdminExamNamesPageState extends State<AdminExamNamesPage> {
  String exam="";
  Map ExamsFromDatabase={};
  bool isLoad=true;
  void initState() {
    // TODO: implement initState
    super.initState();
    /*if(widget.tableName=="UPSC/PCS")
    {
      exam="UPSC";
    }
    else if(widget.tableName=="BANK JOBS")
    {
      exam="BANK";
    }
    else if(widget.tableName=="STATE GOV.")
    {
      exam="STATE";
    }
    else {
      exam=widget.tableName;
    }*/
    initExams();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("${widget.tableName}",
            style: TextStyle(
                fontFamily: "poppins",
                fontSize: 20.sp,
                fontWeight: FontWeight.bold)),
      ),
      body: isLoad?Center(
        child: LoadingAnimationWidget.threeRotatingDots(color: primaryColor, size: 60.w),
      ):(ExamsFromDatabase['data'].isEmpty?Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Center(
          child: Text("No Exams Are Added to ${widget.tableName}",
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
              itemCount: ExamsFromDatabase['data'].length,
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
                                  child: Image.asset("LogoImages/notificationLogo.png"),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                flex: 8,
                                child: Text("${ExamsFromDatabase['data'][index]['exam_name']}",style: TextStyle(fontFamily: "poppins")),
                              )
                            ],
                          ),
                          SizedBox(height: 20.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddNewExamForm(tableName: exam,Updation: true,exam: ExamsFromDatabase['data'][index]['exam_name']),));
                                }, child: Text("Update"),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryColor
                                ),
                              ),
                              SizedBox(width: 10.w,),
                              ElevatedButton(
                                onPressed: () async {
                                  isLoad=true;
                                  setState(() {

                                  });
                                  Map map={
                                    'exam_name': ExamsFromDatabase['data'][index]['exam_name'],
                                    'table_name': exam
                                  };
                                  var url = Uri.parse('http://10.0.2.2/php_projects/sarkari_era_apis/deleteExam.php');
                                  var response = await http.post(url, body: map);
                                  isLoad=true;
                                  initExams();
                                  setState(() {

                                  });
                                },
                                child: Text("Delete"),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryColor
                                ),
                              )
                            ],
                          )
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: primaryColor,
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddNewExamForm(tableName: exam, Updation: false, exam: ""),));
        },
      ),
    );
  }

  Future<void> initExams() async {
    Map map={
      'table_name': "tblExams"
    };
    var url = Uri.parse('http://10.0.2.2/php_projects/sarkari_era_apis/getExamsForAdmin.php');
    var response = await http.post(url, body: map);
    Map map1=jsonDecode(response.body);
    ExamsFromDatabase=map1;
    print("======$ExamsFromDatabase");
    isLoad=false;
    setState(() {

    });
  }
}
