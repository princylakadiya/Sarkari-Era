import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sem5project/screens/quiz/constants.dart';
import '../../../constants.dart';
import 'questions.dart';
import 'option.dart';
import 'question_controller.dart';

class QuestionCard extends StatelessWidget {

  List<Map> data=[];

  QuestionCard({
    Key? key,
    required this.question,
    required this.data
  }) : super(key: key);

  final Question question;

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController(this.data));
    return Container(
      margin: EdgeInsets.only(
          right: kDefaultPadding, left: kDefaultPadding, bottom: 30),
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              question.question,
              style: TextStyle(fontSize: 18)
            ),
            SizedBox(height: kDefaultPadding / 2),
            ...List.generate(
              question.options.length,
              (index) => Option(
                data: this.data,
                index: index,
                text: question.options[index],
                press: () => _controller.checkAns(question, index),
              ),
            ),
            SizedBox(height: kDefaultPadding),
            OutlinedButton(
              onPressed: () {
                _controller.nextQuestion();
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(width: 1,color: Colors.black),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15),),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                child: Text(
                  "Next",
                  style: TextStyle(
                      color: kcustom,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
