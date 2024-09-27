import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_quiz_app_ui/views/cubits/add_quiz_cubit/add_quiz_cubit.dart';
import 'package:sample_quiz_app_ui/views/cubits/add_quiz_cubit/add_quiz_state.dart';
import 'package:sample_quiz_app_ui/views/widgets/add_answers_form.dart';
import 'package:sample_quiz_app_ui/views/widgets/custom_elevated_button_widget.dart';
import 'package:sample_quiz_app_ui/views/widgets/custom_text_form_field_widget.dart';

class AddQuestionFormWidget extends StatelessWidget {
  const AddQuestionFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddQuizCubit, AddQuizState>(
      listener: (context, state) {
        if (state is AddQuestionSuccess) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Form(
            key: BlocProvider.of<AddQuizCubit>(context).formKeyQuestion,
            autovalidateMode:
                BlocProvider.of<AddQuizCubit>(context).autovalidateModeQuestion,
            child: Column(
              children: [
                CustomTextFormFieldWidget(
                  hintText: "New Question",
                  labelText: "Add Question",
                  controller:
                      BlocProvider.of<AddQuizCubit>(context).questionController,
                  validator: BlocProvider.of<AddQuizCubit>(context)
                      .validateQuestionText,
                ),
                const SizedBox(height: 12),
                const AddAnswersForm(),
                const SizedBox(height: 12),
                state is AddQuestionFailure
                    ? Center(
                        child: Text(
                          state.errorMessage,
                          style: TextStyle(
                            color: Colors.red[700],
                          ),
                        ),
                      )
                    : const SizedBox(),
                CustomElevatedButtonWidget(
                    textName: "Add Question",
                    onPressed: () {
                      BlocProvider.of<AddQuizCubit>(context).addQuestion();
                    }),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }
}
