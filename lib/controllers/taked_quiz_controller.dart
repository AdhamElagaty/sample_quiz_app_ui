import 'package:sample_quiz_app_ui/models/models/taked_quiz_model/taked_quiz_model.dart';
import 'package:sample_quiz_app_ui/models/repositories/taked_quiz_repository/itaked_quiz_repository.dart';
import 'package:sample_quiz_app_ui/models/repositories/taked_quiz_repository/taked_quiz_repository.dart';

class TakedQuizController {
  late final ITakedQuizRepository _repository;

  TakedQuizController() {
    _repository = TakedQuizRepository();
  }

  Future<void> addTakedQuiz(TakedQuizModel takedQuiz) async {
    await _repository.addTakedQuiz(takedQuiz);
  }

  Future<void> updateTakedQuiz(TakedQuizModel takedQuiz) async {
    await _repository.updateTakedQuiz(takedQuiz);
  }

  Future<void> deleteTakedQuiz(int id) async {
    await _repository.deleteTakedQuiz(id);
  }

  Future<List<TakedQuizModel>> getAllTakedQuizzes() async {
    return await _repository.getAllTakedQuizzes();
  }

  Future<TakedQuizModel?> getTakedQuizById(int id) async {
    return await _repository.getTakedQuizById(id);
  }
}
