import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sem5project/constants.dart';
import 'package:sem5project/listData/examNames.dart';
import 'package:sem5project/screens/add_new_exam_form.dart';
import 'package:sem5project/screens/admin_exam_names_page.dart';

class AddNEwExamPage extends StatefulWidget {
  const AddNEwExamPage({super.key});

  @override
  State<AddNEwExamPage> createState() => _AddNEwExamPageState();
}

class _AddNEwExamPageState extends State<AddNEwExamPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Add New Exam",style :TextStyle(
            fontFamily: 'poppins',
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            fontSize: 24.sp)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 45.h,
              child: ListView.builder(
                itemCount: ExamNames.category.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AdminExamNamesPage(tableName: ExamNames.category[index]),));
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10.w,bottom: 4.h),
                      width: 74.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey[400]!, width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 5.0), //(x,y)
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Center(
                          child: Text(ExamNames.category[index], style: b16TextStyle)),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Expanded(
              child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisExtent: 90.h,
                    mainAxisSpacing: 4.h,
                    crossAxisSpacing: 10.w),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AdminExamNamesPage(tableName: ExamNames.exams[index]),));
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      elevation: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[400]!, width: 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              child: Image.asset(ExamNames.GridImages[index]),
                              height: 45.w,
                              width: 45.h,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            FittedBox(
                              fit: BoxFit.fill,
                              child: Text(ExamNames.exams[index], style: b13TextStyle),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
