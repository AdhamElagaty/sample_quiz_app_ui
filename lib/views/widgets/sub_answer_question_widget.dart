import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_quiz_app_ui/utils/app_style.dart';
import 'package:sample_quiz_app_ui/views/cubits/add_quiz_cubit/add_quiz_cubit.dart';

class SubAnswerQuestionWidget extends StatelessWidget {
  const SubAnswerQuestionWidget({
    super.key,
    required this.indexQuestion,
    required this.index,
  });

  final int indexQuestion;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            "${index + 1}) ${BlocProvider.of<AddQuizCubit>(context).quizModel.questions![indexQuestion].answers![index].answerText}",
            style: AppStyle.styleBold22,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        // const Spacer(),
        BlocProvider.of<AddQuizCubit>(context)
                        .quizModel
                        .questions![indexQuestion]
                        .answers![index]
                        .isRightAnswer !=
                    null &&
                BlocProvider.of<AddQuizCubit>(context)
                    .quizModel
                    .questions![indexQuestion]
                    .answers![index]
                    .isRightAnswer!
            ? const Icon(
                Icons.check,
                size: 32,
                color: Colors.green,
              )
            : Container(),
      ],
    );
  }
}
