import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_quiz_app_ui/models/models/answer_model/answer_model.dart';
import 'package:sample_quiz_app_ui/utils/app_style.dart';
import 'package:sample_quiz_app_ui/views/cubits/task_quiz_cubit/task_quiz_cubit.dart';
import 'package:sample_quiz_app_ui/views/cubits/task_quiz_cubit/task_quiz_state.dart';
import 'package:sample_quiz_app_ui/views/widgets/custom_elevated_button_widget.dart';

class ViewAnswersTakeAQuizViewBody extends StatelessWidget {
  const ViewAnswersTakeAQuizViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(22.0),
      child: Column(
        children: [
          const SizedBox(
            height: 82,
            width: double.infinity,
          ),
          Image.asset(
            "assets/images/quiz_logo.png",
            width: 160,
          ),
          const SizedBox(
            height: 32,
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xffB8E893),
              borderRadius: BorderRadius.circular(12),
            ),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: BlocBuilder<TakeQuizCubit, TakeQuizState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Spacer(),
                          Text(
                            "${(BlocProvider.of<TakeQuizCubit>(context).currentQuestionIndex) + 1}/${BlocProvider.of<TakeQuizCubit>(context).takedQuizModel.quiz!.questions!.length}",
                            style: AppStyle.styleMedium18,
                          ),
                        ],
                      ),
                      Text(
                        BlocProvider.of<TakeQuizCubit>(context)
                            .takedQuizModel
                            .quiz!
                            .questions![BlocProvider.of<TakeQuizCubit>(context)
                                .currentQuestionIndex]
                            .questionText,
                        style: AppStyle.styleMedium18,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: generateSubTaskWidgets(context),
                      ),
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> generateSubTaskWidgets(BuildContext context) {
    int currentIndex =
        BlocProvider.of<TakeQuizCubit>(context).currentQuestionIndex;
    List<AnswerModel> answersModel = BlocProvider.of<TakeQuizCubit>(context)
        .takedQuizModel
        .quiz!
        .questions![currentIndex]
        .answers!;
    List<Widget> taskWidgets = List.generate(
      answersModel.length,
      (index) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: getColorOfAnswerBorder(answersModel[index].isRightAnswer,
                    answersModel[index].isSelected),
                width: 4,
              ),
              color: getColorOfAnswerBackground(
                  answersModel[index].isRightAnswer,
                  answersModel[index].isSelected),
            ),
            child: Text(
              "  ${index + 1} - ${answersModel[index].answerText}",
              style: AppStyle.styleMedium18,
            ),
          ),
        );
      },
    );

    // Add a button at the end of the list
    taskWidgets.add(Column(
      children: [
        const SizedBox(
          height: 22,
        ),
        Row(
          children: [
            CustomElevatedButtonWidget(
              backgroundColor: const Color(0xff86948F),
              textName: "Back",
              height: 38,
              textStyle: AppStyle.styleMedium18.copyWith(
                color: Colors.white,
                fontSize: 20,
              ),
              onPressed: BlocProvider.of<TakeQuizCubit>(context)
                          .currentQuestionIndex ==
                      0
                  ? null
                  : () {
                      BlocProvider.of<TakeQuizCubit>(context).getLastAnswer();
                    },
              width: 92,
            ),
            const Spacer(),
            CustomElevatedButtonWidget(
              backgroundColor: const Color(0xff86948F),
              textName:
                  BlocProvider.of<TakeQuizCubit>(context).currentQuestionIndex +
                              1 ==
                          BlocProvider.of<TakeQuizCubit>(context)
                              .takedQuizModel
                              .quiz!
                              .questions!
                              .length
                      ? "Close"
                      : "Next",
              height: 38,
              textStyle: AppStyle.styleMedium18.copyWith(
                color: Colors.white,
                fontSize: 20,
              ),
              onPressed: () {
                BlocProvider.of<TakeQuizCubit>(context).getNextAnswer();
              },
              width: 92,
            ),
          ],
        ),
      ],
    ));

    return taskWidgets;
  }

  Color getColorOfAnswerBackground(bool? isRight, bool? isSelected) {
    if (isRight == true) {
      return Colors.grey.withOpacity(0.2);
    } else if (isSelected == true && isRight == null) {
      return Colors.red.withOpacity(0.2);
    } else {
      return Colors.transparent;
    }
  }

  Color getColorOfAnswerBorder(bool? isRight, bool? isSelected) {
    if (isRight == true) {
      return Colors.grey.withOpacity(0.4);
    } else if (isSelected == true && isRight == null) {
      return Colors.red.withOpacity(0.4);
    } else {
      return Colors.transparent;
    }
  }
}
