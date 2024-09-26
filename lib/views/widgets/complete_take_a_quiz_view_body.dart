import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_quiz_app_ui/utils/app_style.dart';
import 'package:sample_quiz_app_ui/views/cubits/task_quiz_cubit/take_quiz_cubit.dart';
import 'package:sample_quiz_app_ui/views/widgets/custom_dialog_box_widget.dart';

class CompleteTakeAQuizViewBody extends StatelessWidget {
  const CompleteTakeAQuizViewBody({
    super.key,
    this.imageTag,
  });

  final int? imageTag;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 82,
          width: double.infinity,
        ),
        imageTag == null
            ? Image.asset(
                "assets/images/complete_quiz_logo.png",
                width: 260,
              )
            : Hero(
                tag: imageTag!,
                child: Image.asset(
                  "assets/images/complete_quiz_logo.png",
                  width: 260,
                ),
              ),
        const SizedBox(
          height: 32,
        ),
        CustomDialogBoxWidget(
          content: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Column(
              children: [
                Text(
                    "${BlocProvider.of<TakeQuizCubit>(context).takedQuizModel.personName} your score is",
                    style: AppStyle.styleMedium18.copyWith(fontSize: 22)),
                Text(
                    "${BlocProvider.of<TakeQuizCubit>(context).takedQuizModel.score} / ${BlocProvider.of<TakeQuizCubit>(context).takedQuizModel.quiz!.questions!.length}",
                    style: AppStyle.styleMedium28),
              ],
            ),
          ),
          title: getTitleByScore(context),
          titleStyle: AppStyle.styleRegular18
              .copyWith(fontSize: 16, fontWeight: FontWeight.w900),
          textButton: "FINISH",
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        const SizedBox(
          height: 42,
        ),
        InkWell(
          onTap: () {
            BlocProvider.of<TakeQuizCubit>(context).viewAnswers();
          },
          borderRadius: BorderRadius.circular(22),
          splashColor: Colors.grey.withOpacity(0.5),
          highlightColor: Colors.grey.withOpacity(0.3),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: Colors.black,
              ),
            ),
            child: const Column(
              children: [
                Text("Go to Answers"),
                Icon(Icons.keyboard_arrow_right_outlined),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 22,
        ),
      ],
    );
  }

  String getTitleByScore(BuildContext context) {
    int score = BlocProvider.of<TakeQuizCubit>(context).takedQuizModel.score!;
    int totalScore = BlocProvider.of<TakeQuizCubit>(context)
        .takedQuizModel
        .quiz!
        .questions!
        .length;
    double scorePrecentage = (score / totalScore) * 100;
    if (scorePrecentage < 50) {
      return "Keep trying!";
    } else if (scorePrecentage >= 50 && scorePrecentage < 80) {
      return "Good effort!";
    } else {
      return "CONGRATULATIONS!!";
    }
  }
}
