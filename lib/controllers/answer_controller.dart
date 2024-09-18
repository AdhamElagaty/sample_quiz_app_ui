import 'package:sample_quiz_app_ui/models/models/answer_model/answer_model.dart';
import 'package:sample_quiz_app_ui/models/repositories/answer_repository/answer_repository.dart';
import 'package:sample_quiz_app_ui/models/repositories/answer_repository/ianswer_repository.dart';

class AnswerController {
  late final IAnswerRepository _repository;

  AnswerController() {
    _repository = AnswerRepository();
  }

  Future<void> addAnswer(AnswerModel answer) async {
    await _repository.addAnswer(answer);
  }

  Future<void> updateAnswer(AnswerModel answer) async {
    await _repository.updateAnswer(answer);
  }

  Future<void> deleteAnswer(int id) async {
    await _repository.deleteAnswer(id);
  }

  Future<List<AnswerModel>> getAllAnswers() async {
    return await _repository.getAllAnswers();
  }

  Future<AnswerModel?> getAnswerById(int id) async {
    return await _repository.getAnswerById(id);
  }
}
