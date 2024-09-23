import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_quiz_app_ui/views/cubits/task_quiz_cubit/task_quiz_cubit.dart';
import 'package:sample_quiz_app_ui/views/cubits/task_quiz_cubit/task_quiz_state.dart';
import 'package:sample_quiz_app_ui/views/widgets/complete_take_a_quiz_view_body.dart';
import 'package:sample_quiz_app_ui/views/widgets/question_take_a_quiz_view_body.dart';
import 'package:sample_quiz_app_ui/views/widgets/view_answers_take_a_quiz_view_body.dart';
import 'package:sample_quiz_app_ui/views/widgets/welcome_take_a_quiz_view_body.dart';

class TakeAQuizView extends StatelessWidget {
  const TakeAQuizView({super.key});

  final String id = "TakeAQuizView";

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
              return SingleChildScrollView(child: bodyView(state));
            },
          )),
    );
  }

  Widget bodyView(TakeQuizState state) {
    if (state is TakeQuizInitial) {
      return const WelcomeTakeAQuizViewBody();
    } else if (state is CompleteQuiz) {
      return const CompleteTakeAQuizViewBody();
    } else if (state is ViewRightAnswersQuiz ||
        state is GetNextOrLastRightAnswer) {
      return const ViewAnswersTakeAQuizViewBody();
    } else {
      return const QuestionTakeAQuizViewBody();
    }
  }
}
