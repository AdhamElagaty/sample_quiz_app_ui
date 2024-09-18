import 'package:sample_quiz_app_ui/models/models/question_model/question_model.dart';
import 'package:sample_quiz_app_ui/models/repositories/question_repository/iquestion_repository.dart';
import 'package:sample_quiz_app_ui/models/repositories/question_repository/question_repository.dart';

class QuestionController {
  late final IQuestionRepository _repository;

  QuestionController() {
    _repository = QuestionRepository();
  }

  Future<void> addQuestion(QuestionModel question) async {
    await _repository.addQuestion(question);
  }

  Future<void> updateQuestion(QuestionModel question) async {
    await _repository.updateQuestion(question);
  }

  Future<void> deleteQuestion(int id) async {
    await _repository.deleteQuestion(id);
  }

  Future<List<QuestionModel>> getAllQuestions() async {
    return await _repository.getAllQuestions();
  }

  Future<QuestionModel?> getQuestionById(int id) async {
    return await _repository.getQuestionById(id);
  }
}
