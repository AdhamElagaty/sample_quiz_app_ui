import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_quiz_app_ui/utils/app_style.dart';
import 'package:sample_quiz_app_ui/utils/view_custom_dialog.dart';
import 'package:sample_quiz_app_ui/views/cubits/quiz_cubit/quiz_cubit.dart';
import 'package:sample_quiz_app_ui/views/cubits/quiz_cubit/quiz_state.dart';
import 'package:sample_quiz_app_ui/views/cubits/task_quiz_cubit/take_quiz_cubit.dart';
import 'package:sample_quiz_app_ui/views/take_a_quiz_view.dart';
import 'package:sample_quiz_app_ui/views/widgets/quiz_widget.dart';

class QuizzesViewBodyWidget extends StatelessWidget {
  const QuizzesViewBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: BlocProvider.of<QuizCubit>(context).getAllQuizzes(),
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
    if (state is GetQuizzesSuccess) {
      final cubit = BlocProvider.of<QuizCubit>(context);
      if (cubit.quizzesModel == null || cubit.quizzesModel!.isEmpty) {
        return buildNoTasksMessage();
      }
      return buildTasksList(cubit);
    } else if (state is GetQuizzesNotExist) {
      return buildNoTasksMessage();
    } else if (state is GetQuizzesFailure) {
      return Center(child: Text(state.errorMessage));
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  Widget buildNoTasksMessage() {
    return Center(
      child: Text(
        "No Quizzes Added 😊",
        style: AppStyle.styleBold22
            .copyWith(color: const Color(0xff000000).withOpacity(0.5)),
      ),
    );
  }

  Widget buildTasksList(QuizCubit cubit) {
    return ListView.builder(
      itemCount: cubit.quizzesModel!.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 2,
            horizontal: 8,
          ),
          child: QuizWidget(
            quizName: cubit.quizzesModel![index].name!.trim(),
            numberOfQuestion:
                cubit.quizzesModel![index].questions!.length.toString(),
            id: cubit.quizzesModel![index].key,
            onLongPress: () {
              viewCustomDialog(
                context: context,
                title: "Delete Quiz",
                content: Text(
                  "Do You Want Delete ${cubit.quizzesModel![index].name!.trim()} Quiz 🤔",
                  style: AppStyle.styleRegular18,
                ),
                cancelButtonText: "Cancel",
                confirmButtonText: "Delete",
                onConfirm: () async {
                  cubit.deleteQuiz(index);
                },
              );
            },
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return BlocProvider(
                      create: (context) => TakeQuizCubit(),
                      child: TakeAQuizView(
                        quizModel: cubit.quizzesModel![index],
                        imageTag: cubit.quizzesModel![index].key,
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
