import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sample_quiz_app_ui/models/models/answer_model/answer_model.dart';
import 'package:sample_quiz_app_ui/models/models/question_model/question_model.dart';
import 'package:sample_quiz_app_ui/models/models/quiz_model/quiz_model.dart';
import 'package:sample_quiz_app_ui/models/models/taked_quiz_model/taked_quiz_model.dart';
import 'package:sample_quiz_app_ui/utils/constants.dart';
import 'package:sample_quiz_app_ui/views/create_quiz_view.dart';
import 'package:sample_quiz_app_ui/views/home_view.dart';

void main() async {
  Hive.registerAdapter(AnswerModelAdapter());
  Hive.registerAdapter(QuestionModelAdapter());
  Hive.registerAdapter(QuizModelAdapter());
  Hive.registerAdapter(TakedQuizModelAdapter());

  await Hive.openBox<AnswerModel>(kAnswerBox);
  await Hive.openBox<QuestionModel>(kQuestionBox);
  await Hive.openBox<QuizModel>(kQuizBox);
  await Hive.openBox<TakedQuizModel>(kTakedQuizBox);
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
