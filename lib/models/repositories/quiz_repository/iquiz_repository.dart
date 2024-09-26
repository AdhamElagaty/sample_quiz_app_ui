import 'package:sample_quiz_app_ui/models/models/quiz_model/quiz_model.dart';

abstract class IQuizRepository {
  Future<void> addQuiz(QuizModel quiz);
  Future<void> updateQuiz(QuizModel quiz);
  Future<void> deleteQuiz(int id);
  Future<List<QuizModel>> getAllQuizzes();
  Future<QuizModel?> getQuizById(int id);
  Future<QuizModel?> getLazyQuizById(int id);
}
