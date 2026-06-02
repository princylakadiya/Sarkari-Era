import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sem5project/widgets/formButton.dart';
import '../constants.dart';

class UploadPdfPage extends StatefulWidget {
  const UploadPdfPage({super.key});

  @override
  State<UploadPdfPage> createState() => _UploadPdfPageState();
}

class _UploadPdfPageState extends State<UploadPdfPage> {
  bool filenameVisible = false;
  bool isLoad = false;
  TextEditingController pdfNameController=TextEditingController();
  String pdfName = "";
  String pdfUrl = "";
  List category=[
    'Mathematics',
    'Reasoning',
    'English',
    'GS/GK',
  ];
  String selectedCategory="Mathematics";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Upload PDF Notes",
            style: TextStyle(
                fontFamily: 'poppins',
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
                fontSize: 24.sp)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10.h,),
              TextField(
                controller: pdfNameController,
                decoration: InputDecoration(
                  hintText: "Enter Pdf Title",
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black,width: 1)
                      ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black,width: 2)),
                ),
              ),
              SizedBox(height: 20.h,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Select Category :- ",style: w70016TextStyle),
                  SizedBox(height: 3.h,),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: primaryColor,width: 1.5)
                        )
                      // Add more decoration..
                    ),
                    isExpanded: true,
                    elevation: 5,
                    value: selectedCategory,
                    hint: const Text(
                      'Select Your Gender',
                      style: TextStyle(fontSize: 14),
                    ),
                    items: category.map((e) {
                      return DropdownMenuItem(
                          value: e,
                          child: Text(e,style: TextStyle(
                              color: Colors.black,
                              fontFamily: "poppins"
                          ),));
                    }).toList() ,
                    onChanged: (value) {
                      selectedCategory=value.toString();
                      setState(() {

                      });
                    },),
                  SizedBox(height: 10.h,)
                ],
              ),
              SizedBox(height: 20.h,),
              GestureDetector(
                onTap: () async {
                  final result = await FilePicker.platform.pickFiles(
                      type: FileType.custom, allowedExtensions: ['pdf']);
                  if (result != null) {
                    File file = File(result.files.single.path!);
                    pdfName = result.files.single.name;
                    pdfUrl = base64Encode(file.readAsBytesSync());
                    filenameVisible = true;
                    setState(() {});
                  }
                },
                child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 3),
                              blurRadius: 3,
                              spreadRadius: 2,
                              color: greyColor)
                        ]),
                    width: double.infinity,
                    child: Row(
                      children: [
                        SizedBox(
                          child: Image.asset("LogoImages/uploadPdf.png"),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        pdfUrl==""?Text(
                          "Upload From Device",
                          style: TextStyle(
                              fontFamily: "poppins",
                              fontWeight: FontWeight.w500,
                              fontSize: 20.sp),
                        ):Expanded(
                          child: Text(
                            "Pdf Selected :- ${pdfName}",
                            style: TextStyle(
                                fontFamily: "poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 20.sp),
                          ),
                        )
                      ],
                    )),
              ),
              SizedBox(
                height: 30.h,
              ),
              FormButton(
                name: "Upload",
                isload: isLoad,
                onpress: () async {
                  if(pdfNameController.text=="")
                    {
                      errorToast("Warning", "Please Enter Pdf Title", context);
                    }
                  else if(pdfUrl=="")
                    {
                      errorToast("Warning", "Please Select Pdf File", context);
                    }
                  else
                    {
                      isLoad=true;
                      setState(() {

                      });
                      Map map={
                        'pdfTitle':pdfNameController.text.trim(),
                        'pdfName':pdfName.trim(),
                        'category':selectedCategory,
                        'pdfUrl':pdfUrl
                      };
                      var url = Uri.parse('http://10.0.2.2/php_projects/sarkari_era_apis/uploadPdf.php');
                      var response = await http.post(url, body: jsonEncode(map));
                      pdfUrl="";
                      pdfNameController.text="";
                      pdfName="";
                      isLoad=false;
                      setState(() {

                      });
                      successToast("Success", "File Uploaded SuccessFully", context);
                    }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
