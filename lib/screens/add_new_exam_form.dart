import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:get/get.dart';
import 'package:sem5project/constants.dart';
import 'package:sem5project/screens/admin_home_page.dart';
import 'package:sem5project/widgets/examFormDatepickerField.dart';
import 'package:sem5project/widgets/examFormTextfield.dart';
import 'package:sem5project/widgets/formButton.dart';
import 'package:http/http.dart' as http;

import '../examCallApi/examCallApi.dart';
import '../listData/examNames.dart';
import '../modalclasses/examJsonParse.dart';

class AddNewExamForm extends StatefulWidget {
  String tableName;
  String exam;
  bool Updation;

  AddNewExamForm({required this.tableName,required this.Updation,required this.exam});

  @override
  State<AddNewExamForm> createState() => _AddNewExamFormState();
}

class _AddNewExamFormState extends State<AddNewExamForm> {
  ExamJsonParse? e1;
  bool isLoad=true;
  String minAge="18";
  String maxAge="18";
  String exam1="";
  List Exams=[];
  String? selectedExam;
  List paymentMethods=[
    "Online",
    "Offline",
    "Online/Offline"
  ];
  TextEditingController applyDateController = TextEditingController();
  TextEditingController lastApplyDateController = TextEditingController();
  TextEditingController examDateController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();
  TextEditingController urObcFeesController = TextEditingController();
  TextEditingController scStPwdFeesController = TextEditingController();
  TextEditingController selectionProcessController = TextEditingController();
  TextEditingController oldNotificationLinkController = TextEditingController();
  TextEditingController applyOnlineLinkController = TextEditingController();
  TextEditingController newNotificationLinkController = TextEditingController();
  TextEditingController officialWebsiteController = TextEditingController();
  String PaymentMethod="Online";
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
    if(widget.Updation)
    {
      fillFields();
    }
    initExamNames();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.tableName}'s Exams", style: TextStyle(
            fontFamily: 'poppins',
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            fontSize: 20.sp)),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Fill all follwing details", style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20.sp,
                  fontFamily: "poppins",
                  color: Color(0xFF0055FA)
              ),),
              SizedBox(height: 20.h,),
              Text("Select Exam Name :- ",style: w70016TextStyle),
              SizedBox(height: 3.h,),
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
                items: Exams.map((e) {
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
              ExamFormDatepickerField(hint: "Enter Apply Date", controller: applyDateController),
              ExamFormDatepickerField(hint: "Enter Last Apply Date", controller: lastApplyDateController),
              ExamFormDatepickerField(hint: "Enter Exam Date", controller: examDateController),
              ExamFormTextfield(hint: "Enter Educational Qualification", controller: qualificationController,noOfLines: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Enter Age Limit :-",style: w70016TextStyle,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 173.h,
                        width: 50.w,
                        child: SpinBox(
                          onChanged: (value) {
                            minAge=value.toInt().toString();
                          },
                          min: 1,
                          max: 100,
                          value: double.parse(minAge),
                          direction: Axis.vertical,
                        ),
                      ),
                      Text("Between"),
                      SizedBox(
                        height: 173.h,
                        width: 50.w,
                        child: SpinBox(
                          onChanged: (value) {
                            maxAge=value.toInt().toString();
                          },
                          min: 1,
                          max: 100,
                          value: double.parse(maxAge),
                          direction: Axis.vertical,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Application Fees Details :------",style: w70016TextStyle),
                  SizedBox(height: 10.h,),
                  ExamFormTextfield(hint: "Enter UR / OBC Fees", controller: urObcFeesController),
                  ExamFormTextfield(hint: "Enter SC / ST / PWD Fees", controller: scStPwdFeesController),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Select Payment Method :- ",style: w70016TextStyle),
                      SizedBox(height: 3.h,),
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
                        value: PaymentMethod,
                        hint: const Text(
                          'Select Your Gender',
                          style: TextStyle(fontSize: 14),
                        ),
                        items: paymentMethods.map((e) {
                          return DropdownMenuItem(
                              value: e,
                              child: Text(e,style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "poppins"
                              ),));
                        }).toList() ,
                        onChanged: (value) {
                          PaymentMethod=value.toString();
                          setState(() {

                          });
                        },),
                      SizedBox(height: 10.h,)
                    ],
                  ),

                ],
              ),
              ExamFormTextfield(hint: "Enter Selection Process", controller: selectionProcessController,noOfLines: 5),
              ExamFormTextfield(hint: "Enter Old Notification Link", controller: oldNotificationLinkController),
              ExamFormTextfield(hint: "Enter Online Apply Link", controller: applyOnlineLinkController),
              ExamFormTextfield(hint: "Enter New Notification Link", controller: newNotificationLinkController),
              ExamFormTextfield(hint: "Enter Official Website Link", controller: officialWebsiteController),
              SizedBox(height: 10.h,),
              FormButton(name: widget.Updation?"Update":"Submit", isload: false,onpress: () async {
                if(selectedExam!=""&&applyDateController.text!=""&&lastApplyDateController.text!=""&&examDateController.text!=""&&qualificationController.text!=""&&minAge!=""&&maxAge!=""&&urObcFeesController.text!=""&&scStPwdFeesController.text!=""&&PaymentMethod!=""&&selectionProcessController.text!=""&&oldNotificationLinkController.text!=""&&applyOnlineLinkController.text!=""&&newNotificationLinkController.text!=""&&officialWebsiteController.text!="")
                {
                  Map map={
                    'table_name': exam1,
                    'exam_name': selectedExam,
                    'apply_date': applyDateController.text.trim(),
                    'last_apply_date': lastApplyDateController.text,
                    'exam_date': examDateController.text.trim(),
                    'education_qualification': qualificationController.text.trim(),
                    'min_age': minAge,
                    'max_age': maxAge,
                    'urobc_fees': urObcFeesController.text.trim(),
                    'scstpwd_fees': scStPwdFeesController.text.trim(),
                    'payment_method': PaymentMethod,
                    'selection_process': selectionProcessController.text.trim(),
                    'old_notification_link': oldNotificationLinkController.text.trim(),
                    'online_apply_link': applyOnlineLinkController.text.trim(),
                    'new_notification_link': newNotificationLinkController.text.trim(),
                    'official_website_link': officialWebsiteController.text.trim(),
                  };

                  var url = Uri.parse('http://10.0.2.2/php_projects/sarkari_era_apis/addExam.php');
                  var response = await http.post(url, body: jsonEncode(map));
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminHomePage(),));
                  successToast("Success", widget.Updation?"Exam Updated Successfully":"Exam Added Successfully", context);
                }
                else
                {
                  errorToast("Warning", "Please fill all fields", context);
                }
              },)
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fillFields() async {
    Map map1= await CallExamDetailsApi.getExamDetails(tableName: widget.tableName, examName: widget.exam);
    e1=ExamJsonParse(map: map1);
    selectedExam=e1!.examJsonParse!.examName!;
    applyDateController.text=e1!.examJsonParse!.applyDate!;
    lastApplyDateController.text=e1!.examJsonParse!.lastApplyDate!;
    examDateController.text=e1!.examJsonParse!.examDate!;
    qualificationController.text=e1!.examJsonParse!.educationQualification!;
    minAge=e1!.examJsonParse!.minAge!;
    maxAge=e1!.examJsonParse!.maxAge!;
    urObcFeesController.text=e1!.examJsonParse!.urobcFees!;
    scStPwdFeesController.text=e1!.examJsonParse!.scstpwdFees!;
    PaymentMethod=e1!.examJsonParse!.paymentMethod!;
    selectionProcessController.text=e1!.examJsonParse!.selectionProcess!;
    oldNotificationLinkController.text=e1!.examJsonParse!.oldNotificationLink!;
    applyOnlineLinkController.text=e1!.examJsonParse!.onlineApplyLink!;
    newNotificationLinkController.text=e1!.examJsonParse!.newNotificationLink!;
    officialWebsiteController.text=e1!.examJsonParse!.officialWebsiteLink!;
    isLoad=false;
    setState(() {

    });
  }

  void initExamNames() {
    if (widget.tableName == ExamNames.category[0]) {
      Exams = ExamNames.eight;
    } else if (widget.tableName == ExamNames.category[1]) {
      Exams = ExamNames.tenth;
    } else if (widget.tableName == ExamNames.category[2]) {
      Exams = ExamNames.twelveth;
    } else if (widget.tableName == ExamNames.category[3]) {
      Exams = ExamNames.Degree;
    } else if (widget.tableName == ExamNames.category[4]) {
      Exams = ExamNames.Other;
    } else if (widget.tableName == "UPSC") {
      Exams = ExamNames.UPSC;
    } else if (widget.tableName == ExamNames.exams[1]) {
      Exams = ExamNames.SSC;
    } else if (widget.tableName == "BANK") {
      Exams = ExamNames.Bank;
    } else if (widget.tableName == ExamNames.exams[3]) {
      Exams = ExamNames.Railway;
    } else if (widget.tableName == ExamNames.exams[4]) {
      Exams = ExamNames.Defence;
    } else if (widget.tableName == ExamNames.exams[5]) {
      Exams = ExamNames.Agniveer;
    } else if (widget.tableName == ExamNames.exams[6]) {
      Exams = ExamNames.Teaching;
    } else if (widget.tableName == ExamNames.exams[7]) {
      Exams = ExamNames.Paramilitary;
    } else if (widget.tableName == "STATE") {
      Exams = ExamNames.State;
    }

    print("=======${widget.tableName}");
    print(Exams);

    // ✅ Prevent RangeError
    if (Exams.isNotEmpty) {
      selectedExam = Exams[0];
    } else {
      selectedExam = null; // or keep it null
    }
  }


}
