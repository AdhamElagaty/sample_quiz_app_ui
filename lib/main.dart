import 'package:flutter/material.dart';
import 'package:sample_quiz_app_ui/views/home_view.dart';

void main() {
  runApp(const SampleQuizApp());
}

class SampleQuizApp extends StatelessWidget {
  const SampleQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "QuizIe",
      home: HomeView(),
    );
  }
}
