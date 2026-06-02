import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sem5project/screens/quiz/constants.dart';
import '../../../constants.dart';
import 'question_controller.dart';

class ProgressBar extends StatelessWidget {
  List<Map> data=[];

  ProgressBar(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: GetBuilder<QuestionController>(
        init: QuestionController(this.data),
        builder: (controller) {
          return Stack(
            children: [
              LayoutBuilder(
                builder: (context, constraints) => Container(
                  width: constraints.maxWidth * controller.animation.value,
                  decoration: BoxDecoration(
                    color: kPrimaryGradient1,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding / 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${(controller.animation.value * 30).round()} Second"),
                      Image(image: AssetImage("LogoImages/clock.png"),color: Colors.black,),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
