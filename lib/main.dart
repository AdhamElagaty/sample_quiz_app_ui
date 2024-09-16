import 'package:flutter/material.dart';
import 'package:sample_quiz_app_ui/views/create_quiz_view.dart';
import 'package:sample_quiz_app_ui/views/home_view.dart';

void main() {
  runApp(const SampleQuizApp());
}

class SampleQuizApp extends StatelessWidget {
  const SampleQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "QuizIe",
      routes: {
        const HomeView().id: (context) => const HomeView(),
        const CreateQuizView().id: (context) => const CreateQuizView(),
      },
      initialRoute: const HomeView().id,
    );
  }
}
