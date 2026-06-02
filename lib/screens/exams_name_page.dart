import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sem5project/screens/exam_details_page.dart';

import '../constants.dart';
import '../listData/examNames.dart';
import 'no_data_found_page.dart';

class ExamsNamePage extends StatefulWidget {
  final String data;

  ExamsNamePage({required this.data});

  @override
  State<ExamsNamePage> createState() => _ExamsNamePageState();
}

class _ExamsNamePageState extends State<ExamsNamePage> {
  List Exams = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initExamNames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("${widget.data}",
            style: TextStyle(
                fontFamily: "poppins",
                fontSize: 20.sp,
                fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: Exams.length,
              itemBuilder: (context, index) {
              return IconTextContainer("LogoImages/notificationLogo.png", Exams[index], () {
                if(widget.data=="STATE GOV.")
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NoDataFoundPage()));
                }
                else  {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ExamDetailsPage(examname: Exams[index],tableName: widget.data),));
                }
              },);
            },),
          )
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
                width: 16.w,
              ),
              Flexible(
                child: Text(
                  text,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      fontFamily: "poppins"),
                ),
              ),
              SizedBox(
                width: 10.w,
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

  void initExamNames() {
    if (widget.data == ExamNames.category[0]) {
      Exams = ExamNames.eight;
    } else if (widget.data == ExamNames.category[1]) {
      Exams=ExamNames.tenth;
    } else if (widget.data == ExamNames.category[2]) {
      Exams=ExamNames.twelveth;
    } else if (widget.data == ExamNames.category[3]) {
      Exams=ExamNames.Degree;
    } else if (widget.data == ExamNames.category[4]) {
      Exams=ExamNames.Other;
    } else if (widget.data == ExamNames.exams[0]) {
      Exams=ExamNames.UPSC;
    } else if (widget.data == ExamNames.exams[1]) {
      Exams=ExamNames.SSC;
    } else if (widget.data == ExamNames.exams[2]) {
      Exams=ExamNames.Bank;
    } else if (widget.data == ExamNames.exams[3]) {
      Exams=ExamNames.Railway;
    } else if (widget.data == ExamNames.exams[4]) {
      Exams=ExamNames.Defence;
    } else if (widget.data == ExamNames.exams[5]) {
      Exams=ExamNames.Agniveer;
    } else if (widget.data == ExamNames.exams[6]) {
      Exams=ExamNames.Teaching;
    } else if (widget.data == ExamNames.exams[7]) {
      Exams=ExamNames.Paramilitary;
    } else if (widget.data == ExamNames.exams[8]) {
      Exams=ExamNames.State;
    } 
  }
}
