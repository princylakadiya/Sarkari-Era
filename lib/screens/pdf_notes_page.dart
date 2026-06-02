import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sem5project/screens/pdf_list_page.dart';
import '../constants.dart';

class PdfNotesPage extends StatefulWidget {
  const PdfNotesPage({super.key});

  @override
  State<PdfNotesPage> createState() => _PdfNotesPageState();
}

class _PdfNotesPageState extends State<PdfNotesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("PDF & NOTES",
            style: TextStyle(
                fontFamily: "poppins",
                fontSize: 20.sp,
                fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          SizedBox(height: 10.h,),
          IconTextContainer(
            "LogoImages/maths.png",
            "Mathematics",
          ),
          IconTextContainer(
            "LogoImages/problem-solving.png",
            "Reasoning",
          ),
          IconTextContainer(
            "LogoImages/eng.png",
            "English"
          ),
          IconTextContainer(
            "LogoImages/book.png",
            "GS/GK"
          ),
        ],
      ),
    );
  }

  Widget IconTextContainer(String img, String text) {
    return Container(
      height: 95.h,
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => PdfListPage(category: text),));
        },
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Row(
            children: [
              SizedBox(
                width: 20.w,
              ),
              Container(
                width: 50.w,
                height: 50.h,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(img))),
              ),
              SizedBox(
                width: 25.w,
              ),
              Text(
                text,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 24.sp,
                    fontFamily: "poppins"),
              )
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          margin: EdgeInsets.all(10),
        ),
      ),
    );
  }
}
