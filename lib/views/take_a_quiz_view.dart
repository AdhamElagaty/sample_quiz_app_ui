import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_quiz_app_ui/models/models/quiz_model/quiz_model.dart';
import 'package:sample_quiz_app_ui/views/cubits/task_quiz_cubit/take_quiz_cubit.dart';
import 'package:sample_quiz_app_ui/views/cubits/task_quiz_cubit/take_quiz_state.dart';
import 'package:sample_quiz_app_ui/views/widgets/complete_take_a_quiz_view_body.dart';
import 'package:sample_quiz_app_ui/views/widgets/question_take_a_quiz_view_body.dart';
import 'package:sample_quiz_app_ui/views/widgets/view_answers_take_a_quiz_view_body.dart';
import 'package:sample_quiz_app_ui/views/widgets/welcome_take_a_quiz_view_body.dart';

class TakeAQuizView extends StatelessWidget {
  const TakeAQuizView({
    super.key,
    required this.quizModel,
    this.imageTag,
  });

  final String id = "TakeAQuizView";
  final QuizModel quizModel;
  final int? imageTag;

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        return BlocProvider.of<TakeQuizCubit>(context).isOutQuiz;
      },
      child: Scaffold(
          backgroundColor: const Color(0xff86948F),
          body: BlocConsumer<TakeQuizCubit, TakeQuizState>(
            listener: (context, state) {
              if (state is CloseQuiz) {
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              if (state is TakeQuizInitial) {
                BlocProvider.of<TakeQuizCubit>(context)
                    .fetchQuizLazy(quizModel.key);
                BlocProvider.of<TakeQuizCubit>(context).takedQuizModel.quizId =
                    quizModel.key;
              }
              return SingleChildScrollView(child: bodyView(state, imageTag));
            },
          )),
    );
  }

  Widget bodyView(TakeQuizState state, int? imageTag) {
    if (state is TakeQuizInitial || state is ErrorInNameValidation) {
      return WelcomeTakeAQuizViewBody(
        imageTag: imageTag,
      );
    } else if (state is CompleteQuiz) {
      return CompleteTakeAQuizViewBody(
        imageTag: imageTag,
      );
    } else if (state is ViewRightAnswersQuiz ||
        state is GetNextOrLastRightAnswer) {
      return ViewAnswersTakeAQuizViewBody(
        imageTag: imageTag,
      );
    } else {
      return const QuestionTakeAQuizViewBody();
    }
  }
}
