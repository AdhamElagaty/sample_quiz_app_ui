import 'package:hive_flutter/hive_flutter.dart';
import 'package:sample_quiz_app_ui/models/models/answer_model/answer_model.dart';
import 'package:sample_quiz_app_ui/models/repositories/answer_repository/ianswer_repository.dart';
import 'package:sample_quiz_app_ui/utils/constants.dart';

class AnswerRepository implements IAnswerRepository {
  late final Box<AnswerModel> _answerBox;

  AnswerRepository() {
    _init();
  }

  Future<void> _init() async {
    _answerBox = Hive.box<AnswerModel>(kAnswerBox);
  }

  @override
  Future<void> addAnswer(AnswerModel answer) async {
    await _answerBox.add(answer);
  }

  @override
  Future<void> updateAnswer(AnswerModel answer) async {
    await answer.save();
  }

  @override
  Future<void> deleteAnswer(int id) async {
    await _answerBox.delete(id);
  }

  @override
  Future<List<AnswerModel>> getAllAnswers() async {
    return _answerBox.values.toList();
  }

  @override
  Future<AnswerModel?> getAnswerById(int id) async {
    return _answerBox.get(id);
  }
}
