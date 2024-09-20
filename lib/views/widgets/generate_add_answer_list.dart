import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_quiz_app_ui/models/models/answer_model/answer_model.dart';
import 'package:sample_quiz_app_ui/views/cubits/add_quiz_cubit/add_quiz_cubit.dart';
import 'package:sample_quiz_app_ui/views/cubits/add_quiz_cubit/add_quiz_state.dart';
import 'package:sample_quiz_app_ui/views/widgets/add_question_widget.dart';
import 'package:sample_quiz_app_ui/views/widgets/custom_radio_button.dart';

class GenerateAddAnswerList extends StatelessWidget {
  const GenerateAddAnswerList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddQuizCubit, AddQuizState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: BlocProvider.of<AddQuizCubit>(context)
              .addQuestionModel
              .answers!
              .length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(4.0),
            child: CustomRadioButton<AnswerModel?>(
              onChanged: (value) {
                BlocProvider.of<AddQuizCubit>(context)
                    .selectRightAnswer(value!);
              },
              groupValue: BlocProvider.of<AddQuizCubit>(context)
                  .addQuestionModel
                  .rightAnswer,
              value: BlocProvider.of<AddQuizCubit>(context)
                  .addQuestionModel
                  .answers![index],
              child: AddQuestionWidget(
                text: BlocProvider.of<AddQuizCubit>(context)
                    .addQuestionModel
                    .answers![index]
                    .answerText,
                onPressed: () {
                  BlocProvider.of<AddQuizCubit>(context).removeAnswer(index);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
