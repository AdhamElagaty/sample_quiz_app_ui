import 'package:hive_flutter/hive_flutter.dart';
import 'package:sample_quiz_app_ui/models/models/quiz_model/quiz_model.dart';
import 'package:sample_quiz_app_ui/models/repositories/quiz_repository/iquiz_repository.dart';
import 'package:sample_quiz_app_ui/utils/constants.dart';

class QuizRepository implements IQuizRepository {
  late final Box<QuizModel> _quizBox;

  QuizRepository() {
    _init();
  }

  Future<void> _init() async {
    _quizBox = Hive.box<QuizModel>(kQuizBox);
  }

  @override
  Future<void> addQuiz(QuizModel quiz) async {
    await _quizBox.add(quiz);
  }

  @override
  Future<void> updateQuiz(QuizModel quiz) async {
    await quiz.save();
  }

  @override
  Future<void> deleteQuiz(int id) async {
    await _quizBox.delete(id);
  }

  @override
  Future<List<QuizModel>> getAllQuizzes() async {
    return _quizBox.values.toList();
  }

  @override
  Future<QuizModel?> getQuizById(int id) async {
    return _quizBox.get(id);
  }
}
