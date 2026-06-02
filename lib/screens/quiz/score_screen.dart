import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sem5project/screens/free_test_page.dart';
import '../../constants.dart';
import 'constants.dart';
import 'question_controller.dart';

class ScoreScreen extends StatelessWidget {

  List<Map> data=[];

  ScoreScreen(this.data);

  @override
  Widget build(BuildContext context) {
    QuestionController _qnController = Get.put(QuestionController(this.data));

    return WillPopScope(
      onWillPop: () async {
        Get.offAll(const FreeTestPage());
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text("TEST SCORE",
              style: TextStyle(
                  fontFamily: "poppins",
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold)),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Lottie.asset("lottie/trophy.json",width: 300,height: 300,fit: BoxFit .fill),
                Text(
                  "Congratulations !",
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 28,color: kcustom),
                ),
                SizedBox(height: 20,),
                Text(
                  "Your Score",
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(height: 5,),
                Text.rich(
                  TextSpan(
                    text:
                    "${_qnController.numOfCorrectAns}",
                    style: TextStyle(fontSize: 30,color: Colors.green),
                    children: [
                      TextSpan(
                        text: " /${_qnController.questions.length}",
                        style: TextStyle(fontSize: 25,color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.all(25),
                  child: Text(
                    "You did a Great Job , Learn More By Taking Another Mock Test.",
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 40,),
                InkWell(
                  onTap: () {
                    Get.offAll(FreeTestPage());
                  },
                  child: Container(
                    width: 200,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: kcustom,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Text(
                      "Back To Home",
                      style: TextStyle(fontSize: 15,color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
