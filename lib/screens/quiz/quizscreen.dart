import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sem5project/screens/free_test_page.dart';

import 'body.dart';
import 'constants.dart';
import 'question_controller.dart';

class QuizScreen extends StatefulWidget {

  List<Map> data=[];

  QuizScreen(this.data);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController(widget.data));
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child:OutlinedButton(
                onPressed: () {
                  _controller.nextQuestion();
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(width: 0,color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15),),
                  ),
                ),
                child: Text(
                  "Skip",
                  style: TextStyle(color: kcustom,fontWeight: FontWeight.bold,fontSize: 17),
                ),
              ),
            ),
          ],
        ),
        body: WillPopScope(
            onWillPop: () => OnBackPressed(),
            child: Body(widget.data)),
      ),
    );
  }

  OnBackPressed() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FreeTestPage(),));
  }
}
