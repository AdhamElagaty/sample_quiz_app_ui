import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_quiz_app_ui/views/cubits/add_quiz_cubit/add_quiz_cubit.dart';
import 'package:sample_quiz_app_ui/views/cubits/add_quiz_cubit/add_quiz_state.dart';
import 'package:sample_quiz_app_ui/views/widgets/custom_app_bar_widget.dart';
import 'package:sample_quiz_app_ui/views/widgets/enter_quiz_name_view_body.dart';
import 'package:sample_quiz_app_ui/views/widgets/enter_quiz_question_view_body.dart';

class CreateQuizView extends StatelessWidget {
  const CreateQuizView({super.key});

  final String id = "CreateQuizView";

  @override
  Widget build(BuildContext context) {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      floatingActionButton: isKeyboardOpen
          ? null
          : FloatingActionButton(
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
      body: BlocProvider(
        create: (context) => AddQuizCubit(),
        child: SingleChildScrollView(
          child: BlocConsumer<AddQuizCubit, AddQuizState>(
            listener: (context, state) {
              if (state is AddQuizSuccess) {
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: state is AddQuizInitial || state is CreateQuizName
                    ? const EnterQuizNameViewBody()
                    : const EnterQuizQuestionViewBody(),
              );
            },
          ),
        ),
      ),
    );
  }
}
