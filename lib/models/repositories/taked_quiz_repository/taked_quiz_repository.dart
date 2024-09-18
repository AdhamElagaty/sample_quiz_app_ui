import 'package:hive_flutter/hive_flutter.dart';
import 'package:sample_quiz_app_ui/models/models/taked_quiz_model/taked_quiz_model.dart';
import 'package:sample_quiz_app_ui/models/repositories/taked_quiz_repository/itaked_quiz_repository.dart';
import 'package:sample_quiz_app_ui/utils/constants.dart';

class TakedQuizRepository implements ITakedQuizRepository {
  late final Box<TakedQuizModel> _takedQuizBox;

  TakedQuizRepository() {
    _init();
  }

  Future<void> _init() async {
    _takedQuizBox = Hive.box<TakedQuizModel>(kTakedQuizBox);
  }

  @override
  Future<void> addTakedQuiz(TakedQuizModel takedQuiz) async {
    await _takedQuizBox.add(takedQuiz);
  }

  @override
  Future<void> updateTakedQuiz(TakedQuizModel takedQuiz) async {
    await takedQuiz.save();
  }

  @override
  Future<void> deleteTakedQuiz(int id) async {
    await _takedQuizBox.delete(id);
  }

  @override
  Future<List<TakedQuizModel>> getAllTakedQuizzes() async {
    return _takedQuizBox.values.toList();
  }

  @override
  Future<TakedQuizModel?> getTakedQuizById(int id) async {
    return _takedQuizBox.get(id);
  }
}
