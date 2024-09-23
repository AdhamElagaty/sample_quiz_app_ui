import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_quiz_app_ui/models/models/answer_model/answer_model.dart';
import 'package:sample_quiz_app_ui/utils/app_style.dart';
import 'package:sample_quiz_app_ui/views/cubits/task_quiz_cubit/task_quiz_cubit.dart';
import 'package:sample_quiz_app_ui/views/cubits/task_quiz_cubit/task_quiz_state.dart';
import 'package:sample_quiz_app_ui/views/widgets/custom_elevated_button_widget.dart';
import 'package:sample_quiz_app_ui/views/widgets/custom_radio_button.dart';

class QuestionTakeAQuizViewBody extends StatelessWidget {
  const QuestionTakeAQuizViewBody({super.key});

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
    // Generate the list of task widgets
    List<Widget> taskWidgets = List.generate(
      answersModel.length,
      (index) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: CustomRadioButton(
            alignment: Alignment.centerLeft,
            activeColor: Colors.grey,
            inactiveColor: const Color.fromARGB(109, 158, 158, 158),
            groupValue: BlocProvider.of<TakeQuizCubit>(context).selectedAnswer,
            onChanged: (value) {
              BlocProvider.of<TakeQuizCubit>(context)
                  .selectAnswer(value, index);
            },
            value: answersModel[index],
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
            const Spacer(),
            CustomElevatedButtonWidget(
              backgroundColor: const Color(0xff86948F),
              textName: "Next",
              height: 38,
              textStyle: AppStyle.styleMedium18.copyWith(
                color: Colors.white,
                fontSize: 20,
              ),
              onPressed:
                  BlocProvider.of<TakeQuizCubit>(context).selectedAnswer == null
                      ? null
                      : () {
                          BlocProvider.of<TakeQuizCubit>(context)
                              .getNextQuestion();
                        },
              width: 92,
            ),
            const Spacer(),
          ],
        ),
      ],
    ));

    return taskWidgets;
  }
}
