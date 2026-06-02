import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sem5project/constants.dart';
import 'package:sem5project/modalclasses/sharedPreferencesData.dart';
import 'package:sem5project/screens/bottom_navigation_page.dart';
import 'package:sem5project/widgets/formButton.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name=SharedPreferemcesData.prefs!.getString("name")!;
  String email=SharedPreferemcesData.prefs!.getString("email")!;
  String mno=SharedPreferemcesData.prefs!.getString("mno")!;
  String password=SharedPreferemcesData.prefs!.getString("password")!;
  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController mnoController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  bool updation=false;
  bool isLoad=false;
  bool isk=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text=name;
    emailController.text=email;
    mnoController.text=mno;
    passwordController.text=password;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        centerTitle: true,
        title: Text("Profile",style: TextStyle(fontFamily: "poppins",fontSize: 20.sp,fontWeight: FontWeight.w500)),
      ),
      body: WillPopScope(
        onWillPop: () => OnBackPressed(),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: AssetImage("Images/profileBackground.png")
              )
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 31.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 93.h,),
                  Container(
                    height: 160.h,
                    width: double.infinity,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 20.h,),
                          CircleAvatar(
                            radius: 40.w,
                            backgroundImage: AssetImage("LogoImages/profile.png"),
                          ),
                          SizedBox(height: 7.h,),
                          Text("${name}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16.sp,fontFamily: "poppins"),)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  Visibility(
                      visible: updation,
                      child: RoundedTextfield(
                        controller: nameController,
                        onIconTap: () {

                        },
                        icon: Icon(Icons.person),
                        isPassword: false,
                        isShowPassword: false,
                        label: "Full Name"
                      )),
                  Visibility(
                      visible: !updation,
                      child: RoundedTextfield(
                        label: "Mobile Number",
                        isShowPassword: false,
                        isPassword: false,
                        icon: Icon(Icons.email),
                        onIconTap: () {

                        },
                        controller: emailController
                      )),
                  RoundedTextfield(
                    controller: mnoController,
                    onIconTap: () {

                    },
                    icon: Icon(Icons.phone),
                    isPassword: false,
                    isShowPassword: false,
                    label: "Mobile Phone"
                  ),
                  RoundedTextfield(
                    label: "Password",
                    isPassword: true,
                    isShowPassword: isk,
                    icon: Icon(Icons.remove_red_eye),
                    controller: passwordController,
                    onIconTap: () {
                      isk=!isk;
                      setState((){});
                    },
                  ),
                  FormButton(
                    name: updation?"Update":"Update Profile",
                    isload: isLoad, onpress: () async {
                      if(updation)
                        {
                          if(nameController.text!=""&&mnoController.text!=""&&passwordController.text!="")
                            {
                              isLoad=true;
                              setState(() {

                              });
                              Map map={
                                'email': email,
                                'name': nameController.text,
                                'mno': mnoController.text,
                                'password': passwordController.text,
                              };
                              var url = Uri.parse('http://10.0.2.2/php_projects/sarkari_era_apis/body: updateUser.php');
                              var response = await http.post(url, body: map);
                              SharedPreferemcesData.prefs!.setString("name", nameController.text);
                              SharedPreferemcesData.prefs!.setString("mno", mnoController.text);
                              SharedPreferemcesData.prefs!.setString("password", passwordController.text);
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavigationPage(),));
                              successToast("Success", "User Updated Successfully", context);
                            }
                          else
                            {
                              errorToast("Warning", "Please fill all data", context);
                            }
                        }
                    updation=true;
                    isLoad=false;
                    setState(() {
                    });
                  },),
                  SizedBox(height: 10.h,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget RoundedTextfield(
      {required String label,
      required bool isPassword,
      required bool isShowPassword,
      required Function() onIconTap,
      required Icon icon,
      required TextEditingController controller}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: SizedBox(
        height: 50.h,
        child: TextField(
          obscureText: isShowPassword,
          controller: controller,
          readOnly: !updation,
          decoration: InputDecoration(
            labelText: label,
            contentPadding: EdgeInsets.symmetric(horizontal: 20.h,),
            labelStyle: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey,
                fontFamily: "poppins",
                fontWeight: FontWeight.w500),
            suffixIcon: isPassword?GestureDetector(
              onTap: () {
                onIconTap!();
              },
              child: isShowPassword?
              Icon(Icons.visibility):Icon(Icons.visibility_off),
            ):icon,
            enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(25),borderSide: BorderSide(color: Colors.grey,width: 1)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25),borderSide: BorderSide(color: Colors.black,width: 2)),
          ),
        ),
      ),
    );
  }

  OnBackPressed() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavigationPage(),));
  }
}
