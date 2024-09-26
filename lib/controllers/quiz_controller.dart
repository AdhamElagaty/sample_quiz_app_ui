import 'package:sample_quiz_app_ui/models/models/quiz_model/quiz_model.dart';
import 'package:sample_quiz_app_ui/models/repositories/quiz_repository/iquiz_repository.dart';
import 'package:sample_quiz_app_ui/models/repositories/quiz_repository/quiz_repository.dart';

class QuizController {
  late final IQuizRepository _repository;

  QuizController() {
    _repository = QuizRepository();
  }

  Future<void> addQuiz(QuizModel quiz) async {
    await _repository.addQuiz(quiz);
  }

  Future<void> updateQuiz(QuizModel quiz) async {
    await _repository.updateQuiz(quiz);
  }

  Future<void> deleteQuiz(int id) async {
    await _repository.deleteQuiz(id);
  }

  Future<List<QuizModel>> getAllQuizzes() async {
    return await _repository.getAllQuizzes();
  }

  Future<QuizModel?> getQuizById(int id) async {
    return await _repository.getQuizById(id);
  }

  Future<QuizModel?> getLazyQuizById(int id) async {
    return await _repository.getLazyQuizById(id);
  }
}
