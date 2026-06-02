import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormTextField extends StatelessWidget {
  final String title;
  final String hint;
  final Icon icon;
  final bool isPassword;
  final bool isShowPassword;
  final TextEditingController controller;
  final Function()? onIconTap;
  final Function(String value)? onchange;
  final String errorText;
  final bool isError;
  final TextInputType? textinputtype;



  FormTextField(
      {required this.title,
      required this.hint,
      required this.icon,
      required this.isPassword,
      required this.isShowPassword,
      required this.controller,
      this.onIconTap,
        this.onchange(String value)?,
        required this.errorText,
        required this.isError,
        this.textinputtype
 });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title!,style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontFamily: "poppins",
            fontWeight: FontWeight.w500
        )),
        TextField(
          keyboardType: textinputtype==null?null:textinputtype,
          onChanged: (value) {
            onchange!(value);
          },
          controller: controller,
          obscureText: isShowPassword,
          decoration: InputDecoration(
            errorText: isError?errorText:null,
              contentPadding: EdgeInsets.only(top: 20.h),
              suffixIcon: isPassword?GestureDetector(
                onTap: () {
                  onIconTap!();
                },
                child: isShowPassword?
                Icon(Icons.visibility):Icon(Icons.visibility_off),
              ):icon,
              suffixIconColor: Colors.grey,
              focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red,width: 2)
              ),
              errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red,width: 2)
              ),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 1,color: Colors.grey)
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black,width: 2)
              ),
              hintText: hint
          ),
        ),
      ],
    );
  }
}
