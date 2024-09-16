import 'package:flutter/material.dart';
import 'package:sample_quiz_app_ui/views/widgets/action_home_widget.dart';
import 'package:sample_quiz_app_ui/views/widgets/welcome_home_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xff86948F),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.maxFinite,
              height: 96,
            ),
            WelcomeHomeWidget(),
            SizedBox(
              height: 142,
            ),
            ActionHomeWidget(),
          ],
        ),
      ),
    );
  }
}
