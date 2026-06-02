import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sem5project/constants.dart';
import 'package:sem5project/screens/admin_signin_page.dart';
import 'package:sem5project/screens/bottom_navigation_page.dart';
import 'package:sem5project/screens/enter_otp_page.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../modalclasses/sharedPreferencesData.dart';
import '../widgets/formButton.dart';
import '../widgets/formTextField.dart';
import 'package:http/http.dart' as http;

String Email="";
String Name="";
String Password="";
String Mno="";
class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool nameFlag = false;
  bool emailFlag = false;
  bool loginemailFlag = false;
  bool mnoFlag = false;
  bool passwordFlag = false;
  bool cpasswordFlag = false;
  bool loginpasswordFlag = false;
  String nameError = "";
  String emailError = "";
  String loginemailError = "";
  String mnoError = "";
  String passwordError = "";
  String loginpasswordError = "";
  String cpasswordError = "";
  RegExp emailregex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  RegExp passwordregex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController mobilenoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isk = true;
  bool showPassword = false;
  int selected = 0;
  bool isLoad=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 70.h,
              ),
              Image.asset("Images/logo1_horizontal-2.png"),
              SizedBox(
                height: 30.h,
              ),
              Text(
                "Proceed with your",
                style: TextStyle(
                    fontFamily: "poppins",
                    fontWeight: FontWeight.w500,
                    fontSize: 20.sp),
              ),
              SizedBox(
                height: 12.h,
              ),
              ToggleSwitch(
                minWidth: 149.w,
                cornerRadius: 40.0,
                minHeight: 45.h,
                animationDuration: 2,
                animate: true,
                customTextStyles: [
                  TextStyle(
                      fontFamily: 'poppins',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold)
                ],
                activeBgColors: [
                  [Color(0xFF4A56AB)],
                  [Color(0xFF4A56AB)]
                ],
                activeFgColor: Colors.white,
                inactiveBgColor: Color(0xFFbfbfbf),
                inactiveFgColor: Colors.white,
                initialLabelIndex: selected,
                totalSwitches: 2,
                labels: ['Sign in', 'Sign Up'],
                radiusStyle: true,
                onToggle: (index) {
                  selected = index!;
                  setState(() {});
                },
              ),
              SizedBox(
                height: 35.h,
              ),
              selected == 0 ? signInFrom() : signUpFrom()
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        child: TextButton(
          child:
              Text("SignIn As Admin?", style: TextStyle(fontFamily: "poppins")),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminSignInPage(),
                ));
          },
        ),
      ),
    );
  }

  Widget signInFrom() {
    return Column(
      children: [
        // formTextField("Enter Your Email/Phone No.",Icon(Icons.email)),
        FormTextField(
          onchange: (value) {
            if(value.isEmpty)
            {
              loginemailFlag=true;
              loginemailError="Please Enter Email";
            }
            else if(!emailregex.hasMatch(value))
            {
              loginemailFlag=true;
              loginemailError="Please Enter Valid Email";
            }
            else{
              loginemailFlag=false;
              loginemailError="";
            }
            setState(() {

            });
          },
          isError: loginemailFlag,
          errorText: loginemailError,
          title: "Enter Your Email/Phone No.",
          hint: "Enter Your Email/Phone No.",
          icon: Icon(Icons.mail),
          isPassword: false,
          isShowPassword: false,
          controller: loginEmailController,
        ),
        SizedBox(
          height: 30.h,
        ),
        // formTextField("Enter Password", Icon(Icons.remove_red_eye)),
        FormTextField(
          onchange: (value) {
            if(value.isEmpty)
            {
              loginpasswordFlag=true;
              loginpasswordError="Please Enter Password";
            }
            else if(!passwordregex.hasMatch(value))
            {
              loginpasswordFlag=true;
              loginpasswordError="Password must contain uppercase,lowercase,alphabet and numeric character";
            }
            else{
              loginpasswordFlag=false;
              loginpasswordError="";
            }
            setState(() {

            });
          },
          errorText: loginpasswordError,
          isError: loginpasswordFlag,
          title: "Enter Password",
          hint: "Enter Password",
          icon: Icon(Icons.e_mobiledata),
          isPassword: true,
          isShowPassword: isk,
          controller: loginPasswordController,
          onIconTap: () {
            isk = !isk;
            setState(() {});
          },
        ),
        SizedBox(
          height: 40.h,
        ),
        FormButton(
          name: "Sign In",
          isload: isLoad,
          onpress: () async {
            if(!loginemailFlag&&!loginpasswordFlag)
              {
                Map map={
                  'email': loginEmailController.text.trim(),
                  'password': loginPasswordController.text.trim()
                };
                isLoad=true;
                setState(() {});
                var url = Uri.parse('http://10.0.2.2/php_projects/sarkari_era_apis/userLogin.php');
                var response = await http.post(url, body: jsonEncode(map));
                Map map1=jsonDecode(response.body);
                if(map1['rows']>0)
                  {
                    SharedPreferemcesData.prefs!.setBool("login", true);
                    SharedPreferemcesData.prefs!.setString("role", "user");
                    SharedPreferemcesData.prefs!.setString("name", map1['data'][0]['name']);
                    SharedPreferemcesData.prefs!.setString("email", map1['data'][0]['email']);
                    SharedPreferemcesData.prefs!.setString("mno", map1['data'][0]['mno']);
                    SharedPreferemcesData.prefs!.setString("password", map1['data'][0]['password']);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavigationPage(),));
                  }
                else
                  {
                    isLoad=false;
                    setState(() {

                    });
                    errorToast("Warning", "Invalid Credentials", context);
                  }
              }
            else
              {
                isLoad=false;
                setState(() {

                });
                errorToast("Warning", "Please fill valid data", context);
              }
          },
        ),
        SizedBox(
          height: 12.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Forgot Password?",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    color: Color(0xFF4A56AB))),
          ],
        )
      ],
    );
  }

  Widget signUpFrom() {
    return Column(
      children: [
        // formTextField("Full Name", Icon(Icons.person)),
        FormTextField(
          onchange: (value) {
            if(fullnameController.text.isEmpty)
              {
                nameFlag=true;
                nameError="Please Enter Name";
              }
            else{
              nameFlag=false;
              nameError="";
            }
            setState(() {

            });
          },
          errorText: nameError,
          isError: nameFlag,
          title: "Full Name",
          hint: "Full Name",
          icon: Icon(Icons.person),
          isPassword: false,
          isShowPassword: false,
          controller: fullnameController,
        ),
        SizedBox(
          height: 30.h,
        ),
        FormTextField(
          textinputtype: TextInputType.phone,
          onchange: (value) {
            if(value.isEmpty)
            {
              mnoFlag=true;
              mnoError="Please Enter Mobile Number";
            }
            else if(value.length!=10)
              {
                mnoFlag=true;
                mnoError="Mobile must contain 10 digit";
              }
            else{
              mnoFlag=false;
              mnoError="";
            }
            setState(() {

            });
          },
          isError: mnoFlag,
          errorText: mnoError,
          title: "Mobile Number",
          hint: "Mobile Number",
          icon: Icon(Icons.call),
          isPassword: false,
          isShowPassword: false,
          controller: mobilenoController,
        ),
        SizedBox(
          height: 30.h,
        ),
        FormTextField(
          textinputtype: TextInputType.emailAddress,
          onchange: (value) {
            if(value.isEmpty)
            {
              emailFlag=true;
              emailError="Please Enter Email";
            }
            else if(!emailregex.hasMatch(value))
            {
              emailFlag=true;
              emailError="Please Enter Valid Email";
            }
            else{
              emailFlag=false;
              emailError="";
            }
            setState(() {

            });
          },
          errorText: emailError,
          isError: emailFlag,
          title: "Enter Email",
          hint: "Enter Email",
          icon: Icon(Icons.email),
          isPassword: false,
          isShowPassword: false,
          controller: emailController,
        ),
        SizedBox(
          height: 30.h,
        ),
        FormTextField(
          onchange: (value) {
            if(value.isEmpty)
            {
              passwordFlag=true;
              passwordError="Please Enter Password";
            }
            else if(!passwordregex.hasMatch(value))
              {
                passwordFlag=true;
                passwordError="Password must contain uppercase,lowercase,alphabet and numeric character";
              }
            else{
              passwordFlag=false;
              passwordError="";
            }
            setState(() {

            });
          },
          isError: passwordFlag,
          errorText: passwordError,
          title: "Create Password",
          hint: "Create Password",
          icon: Icon(Icons.remove_red_eye),
          isPassword: true,
          isShowPassword: isk,
          controller: passwordController,
          onIconTap: () {
            isk=!isk;
            setState(() {

            });
          },
        ),
        SizedBox(
          height: 30.h,
        ),
        FormTextField(
          onchange: (value) {
            if(confirmPasswordController.text.isEmpty)
            {
              cpasswordFlag=true;
              cpasswordError="Please Enter Password";
            }
            else if(!passwordregex.hasMatch(value))
            {
              cpasswordFlag=true;
              cpasswordError="Password must contain uppercase,lowercase,alphabet and numeric character";
            }
            else if(value!=passwordController.text)
            {
              cpasswordFlag=true;
              cpasswordError="Must match with above password";
            }
            else{
              cpasswordFlag=false;
              cpasswordError="";
            }
            setState(() {

            });
          },
          errorText: cpasswordError,
          isError: cpasswordFlag,
          title: "Confirm Password",
          hint: "Confirm Password",
          icon: Icon(Icons.person),
          isPassword: true,
          isShowPassword: isk,
          controller: confirmPasswordController,
          onIconTap: () {
            isk=!isk;
            setState(() {

            });
          },
        ),
        SizedBox(
          height: 40.h,
        ),
        FormButton(
          name: "Sign Up",
          isload: false,
          onpress: () async {

            if(!nameFlag&&!emailFlag&&!mnoFlag&&!passwordFlag&&!cpasswordFlag)
              {
                Name=fullnameController.text.trim();
                Email=emailController.text.trim();
                Mno=mobilenoController.text.trim();
                Password=passwordController.text.trim();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EnterOtpPage(email: emailController.text),));
              }
            else
              {
                errorToast("Warning", "Please fill all fields with valid data", context);

              }
          },
        ),
        SizedBox(
          height: 12.h,
        ),
      ],
    );
  }
}