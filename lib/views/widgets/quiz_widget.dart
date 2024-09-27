import 'package:flutter/material.dart';
import 'package:sample_quiz_app_ui/utils/app_style.dart';

class QuizWidget extends StatelessWidget {
  const QuizWidget({
    super.key,
    required this.quizName,
    required this.numberOfQuestion,
    required this.id,
    this.onTap,
    this.onLongPress,
  });

  final String quizName;
  final String numberOfQuestion;
  final int id;
  final Function()? onTap;
  final void Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onLongPress: onLongPress,
      onTap: onTap,
      child: Card(
        color: const Color(0xffABBFB8),
        elevation: 8, // Adjust the elevation as needed
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$quizName Quiz",
                      style: AppStyle.styleBold22.copyWith(
                        fontSize: 32,
                      ),
                      maxLines: 2,
                    ),
                    Text(
                      "$numberOfQuestion Questions",
                      style: AppStyle.styleBold22,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              Hero(
                tag: id,
                child: Image.asset(
                  "assets/images/quiz_logo.png",
                  width: 90,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
