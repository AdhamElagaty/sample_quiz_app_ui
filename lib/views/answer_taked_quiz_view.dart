import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_quiz_app_ui/models/models/taked_quiz_model/taked_quiz_model.dart';
import 'package:sample_quiz_app_ui/views/cubits/task_quiz_cubit/take_quiz_cubit.dart';
import 'package:sample_quiz_app_ui/views/cubits/task_quiz_cubit/take_quiz_state.dart';
import 'package:sample_quiz_app_ui/views/widgets/view_answers_take_a_quiz_view_body.dart';

class AnswerTakedQuizView extends StatelessWidget {
  const AnswerTakedQuizView({
    super.key,
    required this.takedQuizModel,
  });

  final String id = "AnswerTakedQuizView";
  final TakedQuizModel takedQuizModel;

  @override
  Widget build(BuildContext context) {
    return BlocListener<TakeQuizCubit, TakeQuizState>(
      listener: (context, state) {
        if (state is CloseQuiz) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xff86948F),
        body: BlocBuilder<TakeQuizCubit, TakeQuizState>(
          builder: (context, state) {
            if (state is TakeQuizInitial) {
              BlocProvider.of<TakeQuizCubit>(context).takedQuizModel =
                  takedQuizModel;
            }
            return SingleChildScrollView(
              child: ViewAnswersTakeAQuizViewBody(
                imageTag: takedQuizModel.key,
              ),
            );
          },
        ),
      ),
    );
  }
}
