import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:sem5project/constants.dart';
import 'package:sem5project/modalclasses/sharedPreferencesData.dart';
import 'package:sem5project/screens/admin_home_page.dart';
import 'package:sem5project/screens/registration_page.dart';
import 'package:sem5project/widgets/formButton.dart';
import 'package:sem5project/widgets/formTextField.dart';
import 'package:http/http.dart' as http;

class AdminSignInPage extends StatefulWidget {
  const AdminSignInPage({super.key});

  @override
  State<AdminSignInPage> createState() => _AdminSignInPageState();
}

class _AdminSignInPageState extends State<AdminSignInPage> {
  bool isLoad=false;
  bool isShowPassword=true;
  TextEditingController unameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 70.h,),
              Image.asset("Images/logo1_horizontal-2.png"),
              SizedBox(height: 40.h,),
              Text("Sign In As Admin",style: TextStyle(
                fontFamily: "poppins",
                fontSize: 25.sp,
                fontWeight: FontWeight.bold
              )),
              SizedBox(height: 30.h,),
              FormTextField(title: "Enter Username", hint: "Enter Username", icon: Icon(Icons.email), isPassword: false, isShowPassword: false, controller: unameController,errorText: "false",isError: false,onchange: (value) {

              },onIconTap: () {

              },),
              SizedBox(height: 40.h,),
              FormTextField(title: "Enter Password", hint: "Enter Password", icon: Icon(Icons.panorama_fish_eye), isPassword: true, isShowPassword: isShowPassword, controller: passwordController,onIconTap: () {
                isShowPassword=!isShowPassword;
                setState(() {

                });
              },isError: false,errorText: "",onchange: (value) {

              },),
              SizedBox(height: 30.h,),
              FormButton(name: "Sign In",isload: isLoad ,onpress: () async {
                isLoad=true;
                setState(() {

                });

                if(unameController.text=="" && passwordController.text=="")
                  {
                    errorToast("Warning", "Please fill all fields", context);
                  }
                else
                  {
                    Map map={
                      'username':unameController.text,
                      'password':passwordController.text
                    };
                    var url = Uri.parse('http://10.0.2.2/php_projects/sarkari_era_apis/adminLogin.php');
                    var response = await http.post(url, body: jsonEncode(map));
                    Map map1=jsonDecode(response.body);
                    if(map1['data']>0)
                      {
                        successToast("Success", "SignIn Successfull", context);
                        SharedPreferemcesData.prefs!.setBool("login", true);
                        SharedPreferemcesData.prefs!.setString("role", "admin");
                        Get.offAll(AdminHomePage());
                      }
                    else
                      {
                        errorToast("Failed", "Invalid Credentials", context);
                        isLoad=false;
                        setState(() {

                        });
                      }
                  }
              },)
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        child: TextButton(
          child:
          Text("Sign in as User?", style: TextStyle(fontFamily: "poppins")),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => RegistrationPage(),
                ));
          },
        ),
      ),
    );
  }
}
