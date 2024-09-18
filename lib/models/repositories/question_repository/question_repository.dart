import 'package:hive_flutter/hive_flutter.dart';
import 'package:sample_quiz_app_ui/models/models/question_model/question_model.dart';
import 'package:sample_quiz_app_ui/models/repositories/question_repository/iquestion_repository.dart';
import 'package:sample_quiz_app_ui/utils/constants.dart';

class QuestionRepository implements IQuestionRepository {
  late final Box<QuestionModel> _questionBox;

  QuestionRepository() {
    _init();
  }

  Future<void> _init() async {
    _questionBox = Hive.box<QuestionModel>(kQuestionBox);
  }

  @override
  Future<void> addQuestion(QuestionModel question) async {
    await _questionBox.add(question);
  }

  @override
  Future<void> updateQuestion(QuestionModel question) async {
    await question.save();
  }

  @override
  Future<void> deleteQuestion(int id) async {
    await _questionBox.delete(id);
  }

  @override
  Future<List<QuestionModel>> getAllQuestions() async {
    return _questionBox.values.toList();
  }

  @override
  Future<QuestionModel?> getQuestionById(int id) async {
    return _questionBox.get(id);
  }
}
