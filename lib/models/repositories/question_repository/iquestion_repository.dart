import 'package:sample_quiz_app_ui/models/models/question_model/question_model.dart';

abstract class IQuestionRepository {
  Future<void> addQuestion(QuestionModel question);
  Future<void> updateQuestion(QuestionModel question);
  Future<void> deleteQuestion(int id);
  Future<List<QuestionModel>> getAllQuestions();
  Future<QuestionModel?> getQuestionById(int id);
}
