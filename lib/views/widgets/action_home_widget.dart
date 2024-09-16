import 'package:flutter/material.dart';
import 'package:sample_quiz_app_ui/views/widgets/custom_elevated_button_widget.dart';

class ActionHomeWidget extends StatelessWidget {
  const ActionHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomElevatedButtonWidget(textName: "Create Quiz", onPressed: () {}),
        const SizedBox(
          height: 12,
        ),
        CustomElevatedButtonWidget(textName: "Take Quiz", onPressed: () {})
      ],
    );
  }
}
