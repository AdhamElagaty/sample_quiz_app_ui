import 'package:flutter/material.dart';
import 'package:sample_quiz_app_ui/views/widgets/add_question_form_widget.dart';
import 'package:sample_quiz_app_ui/views/widgets/bottom_sheet_header_widget.dart';

class AddQuestionBottomSheetBodyWidget extends StatelessWidget {
  const AddQuestionBottomSheetBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: const SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BottomSheetHeaderWidget(
              title: "Add Question",
            ),
            AddQuestionFormWidget(),
          ],
        ),
      ),
    );
  }
}
