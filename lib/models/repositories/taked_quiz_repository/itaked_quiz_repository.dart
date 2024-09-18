import 'package:sample_quiz_app_ui/models/models/taked_quiz_model/taked_quiz_model.dart';

abstract class ITakedQuizRepository {
  Future<void> addTakedQuiz(TakedQuizModel takedQuiz);
  Future<void> updateTakedQuiz(TakedQuizModel takedQuiz);
  Future<void> deleteTakedQuiz(int id);
  Future<List<TakedQuizModel>> getAllTakedQuizzes();
  Future<TakedQuizModel?> getTakedQuizById(int id);
}
