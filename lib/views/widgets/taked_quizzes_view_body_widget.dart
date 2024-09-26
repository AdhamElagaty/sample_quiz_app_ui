import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_quiz_app_ui/models/models/taked_quiz_model/taked_quiz_model.dart';
import 'package:sample_quiz_app_ui/utils/app_style.dart';
import 'package:sample_quiz_app_ui/utils/view_custom_dialog.dart';
import 'package:sample_quiz_app_ui/views/cubits/quiz_cubit/quiz_cubit.dart';
import 'package:sample_quiz_app_ui/views/cubits/quiz_cubit/quiz_state.dart';
import 'package:sample_quiz_app_ui/views/cubits/taked_quize_cubit/taked_quize_cubit.dart';
import 'package:sample_quiz_app_ui/views/widgets/taked_quiz_widget.dart';

class TakedQuizzesViewBodyWidget extends StatelessWidget {
  const TakedQuizzesViewBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: BlocProvider.of<QuizCubit>(context).getAllTakedQuizzes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return BlocBuilder<QuizCubit, QuizState>(
            builder: (context, state) {
              return tasksUIList(state, context);
            },
          );
        } else {
          return const Center(child: Text('Something went wrong.'));
        }
      },
    );
  }

  Widget tasksUIList(QuizState state, BuildContext context) {
    if (state is GetTakedQuizzesSuccess) {
      final takedQuizzes =
          BlocProvider.of<QuizCubit>(context).takedQuizzesModel;
      if (takedQuizzes == null || takedQuizzes.isEmpty) {
        return buildNoTasksMessage();
      }
      return buildTasksList(takedQuizzes, BlocProvider.of<QuizCubit>(context));
    } else if (state is GetTakedQuizzesNotExist) {
      return buildNoTasksMessage();
    } else if (state is GetTakedQuizzesFailure) {
      return Center(child: Text(state.errorMessage));
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  Widget buildNoTasksMessage() {
    return Center(
      child: Text(
        "No Quizzes Taked 😊",
        style: AppStyle.styleBold22
            .copyWith(color: const Color(0xff000000).withOpacity(0.5)),
      ),
    );
  }

  Widget buildTasksList(List<TakedQuizModel> takedQuizzes, QuizCubit cubit) {
    return ListView.builder(
      itemCount: takedQuizzes.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
        child: BlocProvider(
          create: (context) => TakedQuizCubit(),
          child: TakedQuizWidget(
            takedQuizModel: takedQuizzes[index],
            onLongPress: () {
              viewCustomDialog(
                context: context,
                title: "Delete Taked Quiz",
                content: Text(
                  "Do You Want Delete ${takedQuizzes[index].quiz!.name!.trim()} Quiz Taked by ${takedQuizzes[index].personName!.trim()} from history 🤔",
                  style: AppStyle.styleRegular18,
                ),
                cancelButtonText: "Cancel",
                confirmButtonText: "Delete",
                onConfirm: () async {
                  cubit.deleteTakedQuiz(index);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
