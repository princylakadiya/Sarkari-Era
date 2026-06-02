import 'dart:convert';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sem5project/constants.dart';
import 'package:sem5project/screens/registration_page.dart';
import 'package:sem5project/widgets/formButton.dart';
import 'package:http/http.dart' as http;
import '../modalclasses/sharedPreferencesData.dart';
import 'bottom_navigation_page.dart';

class EnterOtpPage extends StatefulWidget {
  final String email;


  EnterOtpPage({required this.email});

  @override
  State<EnterOtpPage> createState() => _EnterOtpPageState();
}

class _EnterOtpPageState extends State<EnterOtpPage> {
  String dtoken="";
  FirebaseMessaging _firebaseMessaging=FirebaseMessaging.instance;
  String textfieldHint="";
  String ButtonText="Send OTP";
  EmailOTP emailAuth = EmailOTP();
  bool isLoad=false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController.text=widget.email;
    emailAuth.setConfig(
      appEmail: "krishnabeti2304@gmail.com",
      appName: "Email OTP",
      userEmail: emailController.text,
      otpLength: 4,
      otpType: OTPType.digitsOnly,
    );
  }
  TextEditingController emailController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 70.h,
        centerTitle: true,
        title: Text("VERIFY EMAIL",
            style: TextStyle(
                color: primaryColor,
                fontFamily: "poppins",
                letterSpacing: 1,
                fontSize: 24)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              SizedBox(height: 178.h,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Email To Verify :-",style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontFamily: "poppins",
                      fontWeight: FontWeight.w500
                  )),
                  Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: textfieldHint,
                              contentPadding: EdgeInsets.only(top: 20.h),
                              suffixIconColor: Colors.grey,
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(width: 1,color: Colors.grey)
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black,width: 2)
                              ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor
                          ),
                          onPressed: () async {
                            bool result = await emailAuth.sendOTP();
                            if (result) {
                              successToast("Success", "OTP sent", context);
                              emailController.text="";
                              ButtonText="Resend OTP";
                              textfieldHint="Enter OTP";
                              setState(() {

                              });
                            }
                            else
                              {
                                errorToast("Warning", "Not valid email to send OTP", context);
                              }
                          },
                          child: Text(ButtonText,style: TextStyle(fontFamily: "poppins"),),
                        )
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 28.h,),
              Text("Please enter your Email / mobile number . We will send OTP to reset your password",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: "poppins",
                  color: greyColor
                ),
              ),
              SizedBox(
                height: 17.h,
              ),
              FormButton(name: "Verify OTP", isload: isLoad,onpress: () async {
                if(emailController.text.length==4)
                  {
                    if(await emailAuth.verifyOTP(
                        otp: emailController.text) ==
                        true)
                      {
                        isLoad=true;
                        setState(() {

                        });
                        dtoken=(await _firebaseMessaging.getToken())!;
                        Map map={
                          'name': Name,
                          'mno': Mno,
                          'email': Email,
                          'password':Password,
                          'device_token': dtoken
                        };
                        var url = Uri.parse('http://10.0.2.2/php_projects/sarkari_era_apis/userSignup.php');
                        var response = await http.post(url, body: jsonEncode(map));
                        Map map1=jsonDecode(response.body);
                        if(map1['insertion']==1)
                        {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegistrationPage(),));
                          successToast("Success", "Registration Successfull", context);
                        }
                      }
                    else
                      {
                        errorToast("Warning", "Invalid OTP", context);
                      }
                  }
                else{
                  errorToast("Warning", "Please enter valid OTP", context);
                }
              },)
            ],
          ),
        ),
      ),
    );
  }
}
