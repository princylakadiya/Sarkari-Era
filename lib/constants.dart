import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

const Color primaryColor=Color(0xFF4A56AB);
const Color greyColor=Color(0xFF7D7A7A);

void infoToast(String title, String desc, BuildContext context) {
  return MotionToast.info(
    title: Text(title),
    description: Text(desc),
    animationType: AnimationType.fromRight,
    animationDuration: Duration(milliseconds: 500),
    toastDuration: Duration(milliseconds: 3000),
  ).show(context);
}

void errorToast(String title, String desc, BuildContext context) {
  return MotionToast.error(
    title: Text(title),
    description: Text(desc),
    animationType: AnimationType.fromRight,
    animationDuration: Duration(milliseconds: 500),
    toastDuration: Duration(milliseconds: 3000),
  ).show(context);
}

void successToast(String title, String desc, BuildContext context) {
  return MotionToast.success(
    title: Text(title),
    description: Text(desc),
    animationType: AnimationType.fromRight,
    animationDuration: Duration(milliseconds: 500),
    toastDuration: Duration(milliseconds: 3000),
  ).show(context);
}

TextStyle b16TextStyle=TextStyle(
  fontFamily: "poppins",
  fontSize: 16.sp,
  fontWeight: FontWeight.w600
);

TextStyle b13TextStyle=TextStyle(
    fontFamily: "poppins",
    fontSize: 13.sp,
    fontWeight: FontWeight.w600
);
TextStyle w70016TextStyle=TextStyle(
color: Colors.black,
fontFamily: "poppins",
fontSize: 16.sp,
fontWeight: FontWeight.w700
);

TextStyle sb15redTextStyle=TextStyle(
    color: Colors.red,
    fontFamily: "poppins",
    fontSize: 15.sp,
    fontWeight: FontWeight.w600
);
TextStyle sb14blackTextStyle=TextStyle(
    color: Colors.black,
    fontFamily: "poppins",
    fontSize: 14.sp,
    fontWeight: FontWeight.w600
);

TextStyle sb14SmallTextStyle=TextStyle(
    color: Colors.black,
    fontFamily: "poppins",
    fontSize: 14.sp,
);

TextStyle linkTextStyle=TextStyle(
    color: Colors.blue,
    decoration: TextDecoration.underline,
    fontFamily: "poppins",
    fontSize: 14.sp,
    fontWeight: FontWeight.w600
);


TextStyle r22TextStyle=TextStyle(
color: Colors.black,
fontSize: 22.sp,
fontFamily: "poppins"
);
