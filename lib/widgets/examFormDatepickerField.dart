import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants.dart';

class ExamFormDatepickerField extends StatelessWidget {
  final String hint;
  TextEditingController controller;


  ExamFormDatepickerField({required this.hint, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$hint :- ",style: w70016TextStyle),
          SizedBox(height: 3.h,),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.calendar_month,color: primaryColor),
                hintText: hint,
                contentPadding: EdgeInsets.only(left: 10.w),
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor)
                )
            ),
            readOnly: true,
            onTap: () async {
              DateTime? date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1990),
                  lastDate: DateTime(2050));
              if(date!=null)
              {
                controller.text="${date.day.toString()}/${date.month.toString()}/${date.year.toString()}";
              }
            },
          ),
        ],
      ),
    );
  }
}
