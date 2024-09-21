import 'package:flutter/material.dart';
import 'package:sample_quiz_app_ui/views/create_quiz_view.dart';
import 'package:sample_quiz_app_ui/views/take_quiz_view.dart';
import 'package:sample_quiz_app_ui/views/widgets/custom_elevated_button_widget.dart';

class ActionHomeWidget extends StatelessWidget {
  const ActionHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomElevatedButtonWidget(
            textName: "Create Quiz",
            onPressed: () {
              Navigator.pushNamed(context, const CreateQuizView().id);
            }),
        const SizedBox(
          height: 12,
        ),
        CustomElevatedButtonWidget(
          textName: "Take Quiz",
          onPressed: () {
            Navigator.pushNamed(context, const TakeQuizView().id);
          },
        )
      ],
    );
  }
}
