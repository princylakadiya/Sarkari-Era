import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants.dart';

class ExamFormTextfield extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final int? noOfLines;


  ExamFormTextfield({required this.hint, required this.controller,this.noOfLines});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$hint :- ",style: w70016TextStyle,),
          SizedBox(height: 3.h,),
          TextField(
            maxLines: noOfLines==null?null:noOfLines,
            controller: controller,
            decoration: InputDecoration(
                hintText: hint,
                contentPadding: noOfLines==null?EdgeInsets.only(left: 10.w,):EdgeInsets.only(left: 10.w,top: 8.h,bottom: 8.h),
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor)
                )
            ),
          ),
        ],
      ),
    );
  }
}
