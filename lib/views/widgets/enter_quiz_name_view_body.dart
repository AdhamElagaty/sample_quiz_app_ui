import 'package:flutter/material.dart';
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
            child: CustomTextFormFieldWidget(
              hintText: "write quiz name here",
              labelText: "Quiz Name",
              controller: TextEditingController(),
            ),
          ),
          textButton: "Next",
          onPressed: () {},
        )),
      ],
    );
  }
}
