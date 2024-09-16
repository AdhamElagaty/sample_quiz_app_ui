import 'package:flutter/material.dart';
import 'package:sample_quiz_app_ui/views/widgets/custom_app_bar_widget.dart';
import 'package:sample_quiz_app_ui/views/widgets/enter_quiz_name_view_body.dart';

class CreateQuizView extends StatelessWidget {
  const CreateQuizView({super.key});

  final String id = "CreateQuizView";

  @override
  Widget build(BuildContext context) {
    // Check if the keyboard is open
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      floatingActionButton: isKeyboardOpen
          ? null // Don't show the FAB when the keyboard is open
          : FloatingActionButton(
              backgroundColor: const Color.fromARGB(142, 184, 232, 147),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.exit_to_app,
                color: Colors.red[300],
                size: 32,
              ),
            ),
      appBar: const CustomAppBarWidget(),
      backgroundColor: const Color(0xff86948F),
      body: const SingleChildScrollView(
        child: EnterQuizNameViewBody(),
      ),
    );
  }
}
