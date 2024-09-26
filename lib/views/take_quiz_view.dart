import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_quiz_app_ui/views/cubits/quiz_cubit/quiz_cubit.dart';
import 'package:sample_quiz_app_ui/views/cubits/quiz_cubit/quiz_state.dart';
import 'package:sample_quiz_app_ui/views/widgets/custom_app_bar_widget.dart';

class TakeQuizView extends StatelessWidget {
  const TakeQuizView({super.key});

  final String id = "TakeQuizView";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizCubit(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(142, 184, 232, 147),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.exit_to_app,
            color: Colors.red[300],
            size: 32,
          ),
        ),
        appBar: const CustomAppBarWidget(),
        backgroundColor: const Color(0xff86948F),
        body: BlocBuilder<QuizCubit, QuizState>(
          builder: (context, state) {
            final pageIndex = context.read<QuizCubit>().pageIndex;
            return context
                .read<QuizCubit>()
                .pages[pageIndex]; // Use pageIndex from the cubit.
          },
        ),
        bottomNavigationBar: BlocBuilder<QuizCubit, QuizState>(
          builder: (context, state) {
            return BottomNavigationBar(
              selectedItemColor: Colors.black,
              unselectedItemColor: const Color.fromARGB(105, 0, 0, 0),
              iconSize: 26,
              elevation: 42,
              currentIndex: context.read<QuizCubit>().pageIndex,
              backgroundColor: const Color(0xff86948F),
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.file_copy_outlined),
                  label: 'Quizzes',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.task),
                  label: 'Taked Quizzes',
                ),
              ],
              onTap: (index) {
                context.read<QuizCubit>().updatePageIndex(index);
              },
            );
          },
        ),
      ),
    );
  }
}
