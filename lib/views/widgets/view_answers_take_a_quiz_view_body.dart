import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_quiz_app_ui/models/models/answer_model/answer_model.dart';
import 'package:sample_quiz_app_ui/utils/app_style.dart';
import 'package:sample_quiz_app_ui/views/cubits/task_quiz_cubit/take_quiz_cubit.dart';
import 'package:sample_quiz_app_ui/views/cubits/task_quiz_cubit/take_quiz_state.dart';
import 'package:sample_quiz_app_ui/views/widgets/custom_elevated_button_widget.dart';

class ViewAnswersTakeAQuizViewBody extends StatelessWidget {
  const ViewAnswersTakeAQuizViewBody({super.key, this.imageTag});

  final int? imageTag;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(22.0),
      child: Column(
        children: [
          const SizedBox(height: 82, width: double.infinity),
          _buildLogo(),
          const SizedBox(height: 32),
          _buildQuizContainer(context),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return imageTag == null
        ? Image.asset(
            "assets/images/quiz_logo.png",
            width: 160,
          )
        : Hero(
            tag: imageTag!,
            child: Image.asset(
              "assets/images/quiz_logo.png",
              width: 160,
            ),
          );
  }

  Widget _buildQuizContainer(BuildContext context) {
    return Container(
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
                _buildQuestionProgress(context),
                _buildQuestionText(context),
                ..._buildAnswerWidgets(context),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildQuestionProgress(BuildContext context) {
    final currentIndex =
        BlocProvider.of<TakeQuizCubit>(context).currentQuestionIndex;
    final totalQuestions = BlocProvider.of<TakeQuizCubit>(context)
            .takedQuizModel
            .quiz
            ?.questions
            ?.length ??
        0;
    return Row(
      children: [
        const Spacer(),
        Text(
          "${currentIndex + 1}/$totalQuestions",
          style: AppStyle.styleMedium18,
        ),
      ],
    );
  }

  Widget _buildQuestionText(BuildContext context) {
    final questionText = BlocProvider.of<TakeQuizCubit>(context)
        .takedQuizModel
        .quiz!
        .questions![
            BlocProvider.of<TakeQuizCubit>(context).currentQuestionIndex]
        .questionText;
    return Text(
      questionText,
      style: AppStyle.styleMedium18,
    );
  }

  List<Widget> _buildAnswerWidgets(BuildContext context) {
    int currentIndex =
        BlocProvider.of<TakeQuizCubit>(context).currentQuestionIndex;
    List<AnswerModel> answersModel = BlocProvider.of<TakeQuizCubit>(context)
        .takedQuizModel
        .quiz!
        .questions![currentIndex]
        .answers!;
    int index = 0;
    List<Widget> answerWidgets = answersModel.map((answer) {
      index++;
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: _buildAnswerContainer(answer, index),
      );
    }).toList();

    // Add action buttons with padding
    answerWidgets.add(
      Padding(
        padding: const EdgeInsets.only(top: 22.0),
        child: _buildActionButtons(context),
      ),
    );

    return answerWidgets;
  }

  Widget _buildAnswerContainer(AnswerModel answer, int index) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _getAnswerBorderColor(answer.isRightAnswer, answer.isSelected),
          width: 4,
        ),
        color:
            _getAnswerBackgroundColor(answer.isRightAnswer, answer.isSelected),
      ),
      child: Text(
        "  $index) ${answer.answerText}",
        style: AppStyle.styleMedium18,
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    final quizCubit = BlocProvider.of<TakeQuizCubit>(context);
    final isLastQuestion = quizCubit.currentQuestionIndex + 1 ==
        quizCubit.takedQuizModel.quiz!.questions!.length;

    return Column(
      children: [
        const SizedBox(height: 22),
        Row(
          children: [
            CustomElevatedButtonWidget(
              backgroundColor: const Color(0xff86948F),
              textName: "Back",
              height: 44,
              textStyle: AppStyle.styleMedium18.copyWith(
                color: Colors.white,
                fontSize: 22,
              ),
              onPressed: quizCubit.currentQuestionIndex == 0
                  ? null
                  : () => quizCubit.previousAnswer(),
              width: 108,
            ),
            const Spacer(),
            CustomElevatedButtonWidget(
              backgroundColor: const Color(0xff86948F),
              textName: isLastQuestion ? "Close" : "Next",
              height: 44,
              textStyle: AppStyle.styleMedium18.copyWith(
                color: Colors.white,
                fontSize: 22,
              ),
              onPressed: quizCubit.nextAnswer,
              width: 108,
            ),
          ],
        ),
      ],
    );
  }

  Color _getAnswerBackgroundColor(bool? isRight, bool? isSelected) {
    if (isRight == true) {
      return Colors.grey.withOpacity(0.2);
    } else if (isSelected == true && isRight == null) {
      return Colors.red.withOpacity(0.2);
    } else {
      return Colors.transparent;
    }
  }

  Color _getAnswerBorderColor(bool? isRight, bool? isSelected) {
    if (isRight == true) {
      return Colors.grey.withOpacity(0.4);
    } else if (isSelected == true && isRight == null) {
      return Colors.red.withOpacity(0.4);
    } else {
      return Colors.transparent;
    }
  }
}
