import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class FormButton extends StatelessWidget {
  final String name;
  final Function() onpress;
  bool isload;


  FormButton({required this.name, required this.isload ,required this.onpress});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF4A56AB),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25))
        ),
        child: isload?LoadingAnimationWidget.threeArchedCircle(color: Colors.white, size: 30.w):Text(name, style: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
          fontFamily: "poppins"
      )),
        onPressed: () {
          onpress();
        },
      ),
    );
  }
}