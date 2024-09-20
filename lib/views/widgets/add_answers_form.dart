import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_quiz_app_ui/utils/app_style.dart';
import 'package:sample_quiz_app_ui/views/cubits/add_quiz_cubit/add_quiz_cubit.dart';
import 'package:sample_quiz_app_ui/views/cubits/add_quiz_cubit/add_quiz_state.dart';
import 'package:sample_quiz_app_ui/views/widgets/custom_text_form_field_widget.dart';
import 'package:sample_quiz_app_ui/views/widgets/generate_add_answer_list.dart';

class AddAnswersForm extends StatelessWidget {
  const AddAnswersForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border:
              Border.all(color: const Color.fromARGB(75, 0, 0, 0), width: 4)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Answers",
            style: AppStyle.styleBold22,
          ),
          const SizedBox(
            height: 12,
          ),
          BlocBuilder<AddQuizCubit, AddQuizState>(
            builder: (context, state) {
              return Form(
                key: BlocProvider.of<AddQuizCubit>(context).formKeyAnswer,
                autovalidateMode: BlocProvider.of<AddQuizCubit>(context)
                    .autovalidateModeAnswer,
                child: Column(
                  children: [
                    CustomTextFormFieldWidget(
                      hintText: "New Answer",
                      labelText: "Add Answer",
                      controller: BlocProvider.of<AddQuizCubit>(context)
                          .answerController,
                      validator: (value) =>
                          BlocProvider.of<AddQuizCubit>(context)
                              .validateAnswerText(value),
                    ),
                    const SizedBox(height: 12),
                    IconButton(
                      style: IconButton.styleFrom(
                        fixedSize: const Size(68, 40),
                        backgroundColor:
                            const Color.fromARGB(255, 213, 213, 213),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed:
                          BlocProvider.of<AddQuizCubit>(context).addAnswer,
                      icon: const Icon(Icons.add),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffABBFB8),
                        border: Border.all(
                            width: 4, color: const Color.fromARGB(75, 0, 0, 0)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      height: 260,
                      child: (BlocProvider.of<AddQuizCubit>(context)
                                      .addQuestionModel
                                      .answers ==
                                  null ||
                              BlocProvider.of<AddQuizCubit>(context)
                                  .addQuestionModel
                                  .answers!
                                  .isEmpty)
                          ? Center(
                              child: Text(
                                "No Answers To View",
                                style: AppStyle.styleBold22.copyWith(
                                    color: const Color(0xff000000)
                                        .withOpacity(0.5)),
                              ),
                            )
                          : const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: GenerateAddAnswerList(),
                            ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
