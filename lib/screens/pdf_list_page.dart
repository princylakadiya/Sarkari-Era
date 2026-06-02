import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sem5project/modalclasses/pdfJsonParse.dart';
import 'package:http/http.dart' as http;
import 'package:sem5project/screens/show_pdf_page.dart';
import '../constants.dart';

class PdfListPage extends StatefulWidget {
  final String category;

  PdfListPage({required this.category});

  @override
  State<PdfListPage> createState() => _PdfListPageState();
}

class _PdfListPageState extends State<PdfListPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPdfs();
  }
  PdfJsonParse? p1;
  bool isLoad=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("${widget.category}'s PDFs",
            style: TextStyle(
                fontFamily: "poppins",
                fontSize: 20.sp,
                fontWeight: FontWeight.bold)),
      ),
      body: !isLoad?(p1!.pdfJsonParse.isEmpty?Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text("Files for ${widget.category} is not yet uploaded",textAlign: TextAlign.center,style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              fontFamily: "poppins"
          )),
        ),
      ):ListView.builder(
        itemCount: p1!.pdfJsonParse.length,
        itemBuilder: (context, index) {
        return Container(
          height: 95.h,
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ShowPdfPage(pdfUrl: "${p1!.pdfJsonParse[index].pdfurl}"),));
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
                        image: DecorationImage(image: AssetImage("LogoImages/pdfLogo.png"))),
                  ),
                  SizedBox(
                    width: 25.w,
                  ),
                  Expanded(
                    child: Text(
                      "${p1!.pdfJsonParse[index].name}",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 24.sp,
                          fontFamily: "poppins"),
                    ),
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
      },)):Center(
        child: LoadingAnimationWidget.threeRotatingDots(color: primaryColor, size: 60.w),
      ),
    );
  }

  Future<void> getPdfs() async {
    Map map={
      'category':widget.category
    };
    var url = Uri.parse('http://10.0.2.2/php_projects/sarkari_era_apis/getPdfs.php');
    var response = await http.post(url, body: jsonEncode(map));
    Map map1=jsonDecode(response.body);
    p1=PdfJsonParse(map: map1);
    isLoad=false;
    setState(() {

    });
  }
}
