import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:sem5project/constants.dart';
import 'package:sem5project/widgets/formButton.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'bottom_navigation_page.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  bool isLoad=false;
  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController mnoController=TextEditingController();
  TextEditingController messageController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Help",style: TextStyle(fontFamily: "poppins",fontWeight: FontWeight.bold,fontSize: 20.sp)),
      ),
      body: WillPopScope(
        onWillPop: () => OnBackPressed(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 25.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("Help",style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: "poppins",
                ),),
                SizedBox(height: 20.h,),
                contactTextfield("Enter Name", nameController,0),
                SizedBox(height: 10.h,),
                contactTextfield("Enter Email", emailController,0),
                SizedBox(height: 10.h,),
                contactTextfield("Enter Mobile Number", mnoController,0),
                SizedBox(height: 10.h,),
                contactTextfield("Write about the problem", messageController,4),
                SizedBox(height: 40.h,),
                FormButton(name: "Submit Issue", isload:isLoad ,onpress: () async {
                  if(nameController.text!=""&&emailController.text!=""&&mnoController.text!=""&&messageController.text!="")
                  {
                    isLoad=true;
                    setState(() {

                    });
                    Map map={
                      'name':nameController.text.trim(),
                      'email':emailController.text.trim(),
                      'mno':mnoController.text.trim(),
                      'problem':messageController.text.trim(),
                    };
                    var url = Uri.parse('http://10.0.2.2/php_projects/sarkari_era_apis/addHelpRequest.php');
                    var response = await http.post(url,body: jsonEncode(map));
                    infoToast("Sucess", "Request Submitted, We will contact you soon", context);
                    isLoad=false;
                    clearControls();
                    setState(() {
                    });
                  }
                  else
                  {
                    errorToast("Warning ", "Please fill all fields", context);
                    isLoad=false;
                    setState(() {

                    });
                  }
                },),
                SizedBox(height: 10.h,),
                FormButton(name: "Watch App Tutorial", isload: false,onpress: () {
                  _launchUrl(Uri.parse("https://youtu.be/WMeqYOHT_Nc?si=vZbNgKtbndyGP1IS"));
                },)
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget contactTextfield(String hint, TextEditingController controller,int noOfRows)
  {
    return TextField(
      controller: controller,
      maxLines: noOfRows==0?null:noOfRows,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Color(0xFF8EABC9),
        enabledBorder: OutlineInputBorder(
          // width: 0.0 produces a thin "hairline" border
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide(color: Colors.white24)
          //borderSide: const BorderSide(),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide(color: Colors.white24)
        ),
      ),
    );
  }

  void clearControls()
  {
    nameController.text="";
    emailController.text="";
    mnoController.text="";
    messageController.text="";
  }
  OnBackPressed() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavigationPage(),));
  }
  Future<void> _launchUrl(Uri _url) async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
