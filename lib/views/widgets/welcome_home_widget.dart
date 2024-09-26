import 'package:flutter/material.dart';
import 'package:sample_quiz_app_ui/utils/app_style.dart';

class WelcomeHomeWidget extends StatelessWidget {
  const WelcomeHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "welcome",
          style: AppStyle.styleBold56,
        ),
        Hero(
          tag: "app_logo",
          child: Image.asset(
            "assets/images/app_logo_name.png",
            width: 322,
          ),
        ),
      ],
    );
  }
}
