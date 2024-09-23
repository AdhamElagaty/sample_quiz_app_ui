import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_quiz_app_ui/utils/app_style.dart';
import 'package:sample_quiz_app_ui/views/cubits/task_quiz_cubit/task_quiz_cubit.dart';
import 'package:sample_quiz_app_ui/views/widgets/custom_dialog_box_widget.dart';
import 'package:sample_quiz_app_ui/views/widgets/custom_text_form_field_widget.dart';

class WelcomeTakeAQuizViewBody extends StatelessWidget {
  const WelcomeTakeAQuizViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 82,
          width: double.infinity,
        ),
        const Text(
          "Quiz",
          style: AppStyle.styleBold56,
        ),
        Hero(
          tag: BlocProvider.of<TakeQuizCubit>(context).quizModel.key,
          child: Image.asset(
            "assets/images/quiz_logo.png",
            width: 160,
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        CustomDialogBoxWidget(
          content: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Form(
              key: BlocProvider.of<TakeQuizCubit>(context).formKeyName,
              autovalidateMode:
                  BlocProvider.of<TakeQuizCubit>(context).autovalidateModeName,
              child: CustomTextFormFieldWidget(
                hintText: "write your name",
                labelText: "Name",
                controller:
                    BlocProvider.of<TakeQuizCubit>(context).nameController,
                validator:
                    BlocProvider.of<TakeQuizCubit>(context).validateNameText,
              ),
            ),
          ),
          title: "welcome",
          textButton: "START",
          onPressed: () {
            BlocProvider.of<TakeQuizCubit>(context).startQuiz();
          },
        ),
        const SizedBox(
          height: 82,
        ),
      ],
    );
  }
}
