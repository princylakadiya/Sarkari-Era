import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sem5project/screens/upload_pdf_page.dart';
import '../constants.dart';
import '../modalclasses/pdfJsonParse.dart';

class AdminAllPdfsPage extends StatefulWidget {
  const AdminAllPdfsPage({super.key});

  @override
  State<AdminAllPdfsPage> createState() => _AdminAllPdfsPageState();
}

class _AdminAllPdfsPageState extends State<AdminAllPdfsPage> {
  PdfJsonParse? p1;
  bool isLoad=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPdfs();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("PDFs",
            style: TextStyle(
                fontFamily: "poppins",
                fontSize: 20.sp,
                fontWeight: FontWeight.bold)),
      ),
      body: !isLoad?(p1!.pdfJsonParse.isEmpty?Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text("No Pdfs are uploaded yet",textAlign: TextAlign.center,style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              fontFamily: "poppins"
          )),
        ),
      ):ListView.builder(
        itemCount: p1!.pdfJsonParse.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Container(
                height: 110.h,
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
              Positioned(
                  top: -6,
                  right: 20.w,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor
                    ),
                    child: Text("Delete"),
                    onPressed: () async {
                      successToast("Success", "Pdf Deleted Successfully", context);
                      String pdfUrl=p1!.pdfJsonParse[index].pdfurl!;
                      String pdfUrl2=pdfUrl.substring(37,pdfUrl.length);
                      Map map={
                        'pdf_url':pdfUrl2,
                        'pdf_name':p1!.pdfJsonParse[index].name,
                        'pdf_category':p1!.pdfJsonParse[index].category
                      };
                      var url = Uri.parse('http://10.0.2.2/php_projects/sarkari_era_apis/deletePdf.php');
                      var response = await http.post(url,body: map);
                      isLoad=true;
                      setState(() {

                      });
                      getPdfs();
                    },
                  )
              ),
            ],
          );
        },)):Center(
        child: LoadingAnimationWidget.threeRotatingDots(color: primaryColor, size: 60.w),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: primaryColor,
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UploadPdfPage(),));
        },
      ),
    );
  }

  Future<void> getPdfs() async {
    var url = Uri.parse('http://10.0.2.2/php_projects/sarkari_era_apis/getAdminPdfs.php');
    var response = await http.post(url);
    Map map1=jsonDecode(response.body);
    p1=PdfJsonParse(map: map1);
    isLoad=false;
    setState(() {

    });
  }
}
