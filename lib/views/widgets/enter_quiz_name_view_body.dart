import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_quiz_app_ui/views/cubits/add_quiz_cubit/add_quiz_cubit.dart';
import 'package:sample_quiz_app_ui/views/cubits/add_quiz_cubit/add_quiz_state.dart';
import 'package:sample_quiz_app_ui/views/widgets/custom_dialog_box_widget.dart';
import 'package:sample_quiz_app_ui/views/widgets/custom_text_form_field_widget.dart';

class EnterQuizNameViewBody extends StatelessWidget {
  const EnterQuizNameViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        Image.asset(
          "assets/images/quiz_create_logo.png",
          width: 222,
        ),
        const SizedBox(
          height: 40,
        ),
        Center(
            child: CustomDialogBoxWidget(
          title: "Create Quiz",
          content: Padding(
            padding: const EdgeInsets.all(22.0),
            child: BlocBuilder<AddQuizCubit, AddQuizState>(
              builder: (context, state) {
                return Form(
                  key: BlocProvider.of<AddQuizCubit>(context).formKeyQuizName,
                  autovalidateMode: BlocProvider.of<AddQuizCubit>(context)
                      .autovalidateModeQuizName,
                  child: CustomTextFormFieldWidget(
                    hintText: "write quiz name here",
                    labelText: "Quiz Name",
                    controller: BlocProvider.of<AddQuizCubit>(context)
                        .quizNameController,
                    validator: BlocProvider.of<AddQuizCubit>(context)
                        .validateQuizNameText,
                  ),
                );
              },
            ),
          ),
          textButton: "Next",
          onPressed: BlocProvider.of<AddQuizCubit>(context).addQuizName,
        )),
      ],
    );
  }
}
