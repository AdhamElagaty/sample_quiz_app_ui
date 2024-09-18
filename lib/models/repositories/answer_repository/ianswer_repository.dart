import 'package:sample_quiz_app_ui/models/models/answer_model/answer_model.dart';

abstract class IAnswerRepository {
  Future<void> addAnswer(AnswerModel answer);
  Future<void> updateAnswer(AnswerModel answer);
  Future<void> deleteAnswer(int id);
  Future<List<AnswerModel>> getAllAnswers();
  Future<AnswerModel?> getAnswerById(int id);
}
