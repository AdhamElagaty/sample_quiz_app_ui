import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_quiz_app_ui/controllers/quiz_controller.dart';
import 'package:sample_quiz_app_ui/models/models/quiz_model/quiz_model.dart';
import 'package:sample_quiz_app_ui/models/models/taked_quiz_model/taked_quiz_model.dart';
import 'package:sample_quiz_app_ui/views/cubits/taked_quize_cubit/taked_quize_state.dart';

class TakedQuizCubit extends Cubit<TakedQuizState> {
  TakedQuizCubit() : super(TakedQuizInitial());

  TakedQuizModel? takedQuizModel;
  QuizModel? quizModel;
  bool isExpanded = false;

  void changeExpantion() {
    isExpanded = !isExpanded;
    emit(ExpantionChanged());
  }

  Future<QuizModel?> getQuiz(int quizId) async {
    emit(QuizLoading());
    quizModel = await QuizController().getQuizById(quizId);
    if (quizModel != null) {
      return quizModel;
    } else {
      emit(QuizLoading());
      return null;
    }
  }
}
