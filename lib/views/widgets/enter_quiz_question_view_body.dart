import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_quiz_app_ui/utils/app_style.dart';
import 'package:sample_quiz_app_ui/utils/view_bottom_sheet.dart';
import 'package:sample_quiz_app_ui/views/cubits/add_quiz_cubit/add_quiz_cubit.dart';
import 'package:sample_quiz_app_ui/views/cubits/add_quiz_cubit/add_quiz_state.dart';
import 'package:sample_quiz_app_ui/views/widgets/add_question_bottom_sheet_body_widget.dart';
import 'package:sample_quiz_app_ui/views/widgets/custom_elevated_button_widget.dart';
import 'package:sample_quiz_app_ui/views/widgets/custom_expansion_tile_question_widget.dart';

class EnterQuizQuestionViewBody extends StatelessWidget {
  const EnterQuizQuestionViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Image.asset(
                "assets/images/quiz_create_logo.png",
                width: 68,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  "${BlocProvider.of<AddQuizCubit>(context).quizModel.name!} Quiz",
                  style:
                      AppStyle.styleMedium18.copyWith(height: 0, fontSize: 24),
                  maxLines: 2,
                ),
              ),
              CustomElevatedButtonWidget(
                textName: "Add",
                textStyle: AppStyle.styleMedium18,
                width: 82,
                height: 25,
                onPressed: () async {
                  await viewBottomSheet(
                    context,
                    BlocProvider.value(
                      value: BlocProvider.of<AddQuizCubit>(context),
                      child: const AddQuestionBottomSheetBodyWidget(),
                    ),
                  );
                  BlocProvider.of<AddQuizCubit>(context)
                      .restAddQuestionBottomSheet();
                },
              ),
            ],
          ),
        ),
        // Using a SizedBox to constrain the height  of the Container
        BlocBuilder<AddQuizCubit, AddQuizState>(
          builder: (context, state) {
            return Container(
              child:
                  (BlocProvider.of<AddQuizCubit>(context).quizModel.questions ==
                              null ||
                          BlocProvider.of<AddQuizCubit>(context)
                              .quizModel
                              .questions!
                              .isEmpty)
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height - 250,
                          child: const Center(
                            child: Text("No Questions to view"),
                          ),
                        )
                      : Column(
                          children: generateSubTaskWidgets(context),
                        ),
            );
          },
        ),
      ],
    );
  }

  List<Widget> generateSubTaskWidgets(BuildContext context) {
    // Generate the list of task widgets
    List<Widget> taskWidgets = List.generate(
      BlocProvider.of<AddQuizCubit>(context).quizModel.questions!.length,
      (index) {
        return CustomExpansionTileTaskWidget(
          title:
              "Q${index + 1}) ${BlocProvider.of<AddQuizCubit>(context).quizModel.questions![index].questionText}",
          indexQustion: index,
        );
      },
    );

    // Add a button at the end of the list
    taskWidgets.add(CustomElevatedButtonWidget(
      textName: "Create Quiz",
      onPressed: () {},
      width: MediaQuery.of(context).size.width - 22,
    ));

    return taskWidgets;
  }
}
