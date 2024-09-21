import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_quiz_app_ui/controllers/quiz_controller.dart';
import 'package:sample_quiz_app_ui/models/models/quiz_model/quiz_model.dart';
import 'package:sample_quiz_app_ui/views/cubits/quiz_cubit/quiz_state.dart';
import 'package:sample_quiz_app_ui/views/widgets/quizzes_view_body_widget.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit() : super(QuizInitial());

  final List<Widget> pages = [const QuizzesViewBodyWidget(), Container()];
  int pageIndex = 0;
  List<QuizModel>? quizzesModel;

  void updatePageIndex(int index) {
    if (pageIndex != index) {
      pageIndex = index;
      emit(PageIndexChanged());
    }
  }

  Future<void> getAllQuizzes() async {
    try {
      quizzesModel = await QuizController().getAllQuizzes();
      if (quizzesModel!.isEmpty) {
        emit(GetQuizzesNotExist());
      } else {
        emit(GetQuizzesSuccess());
      }
    } catch (e) {
      emit(GetQuizzesFailure(errorMessage: "Error! on Quizzes Loading"));
    }
  }
}
