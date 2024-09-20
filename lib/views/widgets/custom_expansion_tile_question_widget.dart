import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_quiz_app_ui/utils/app_style.dart';
import 'package:sample_quiz_app_ui/views/cubits/add_quiz_cubit/add_quiz_cubit.dart';
import 'package:sample_quiz_app_ui/views/widgets/sub_answer_question_widget.dart';

class CustomExpansionTileTaskWidget extends StatelessWidget {
  const CustomExpansionTileTaskWidget({
    super.key,
    required this.title,
    required this.indexQustion,
  });

  final String title;
  final int indexQustion;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onLongPress: () {},
        child: ExpansionTile(
          backgroundColor: const Color(0xffABBFB8),
          collapsedBackgroundColor: const Color(0xffABBFB8),
          shape: const ContinuousRectangleBorder(
              side: BorderSide(
                color: Color.fromARGB(121, 0, 0, 0),
                width: 8,
              ),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          collapsedShape: const ContinuousRectangleBorder(
              side: BorderSide(
                color: Color.fromARGB(121, 0, 0, 0),
                width: 6,
              ),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          expandedAlignment: Alignment.centerLeft,
          showTrailingIcon: true,
          title: Text(
            title,
            style: AppStyle.styleBold22.copyWith(fontSize: 24),
          ),
          children: generateSubTaskWidgets(context),
        ),
      ),
    );
  }

  List<Widget> generateSubTaskWidgets(BuildContext context) {
    return List.generate(
        BlocProvider.of<AddQuizCubit>(context)
            .quizModel
            .questions![indexQustion]
            .answers!
            .length, (index) {
      return SubAnswerQuestionWidget(indexQuestion: indexQustion, index: index);
    });
  }
}
