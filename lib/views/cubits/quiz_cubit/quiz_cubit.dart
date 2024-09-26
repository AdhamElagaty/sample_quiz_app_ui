import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_quiz_app_ui/controllers/quiz_controller.dart';
import 'package:sample_quiz_app_ui/controllers/taked_quiz_controller.dart';
import 'package:sample_quiz_app_ui/models/models/quiz_model/quiz_model.dart';
import 'package:sample_quiz_app_ui/models/models/taked_quiz_model/taked_quiz_model.dart';
import 'package:sample_quiz_app_ui/views/cubits/quiz_cubit/quiz_state.dart';
import 'package:sample_quiz_app_ui/views/widgets/quizzes_view_body_widget.dart';
import 'package:sample_quiz_app_ui/views/widgets/taked_quizzes_view_body_widget.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit() : super(QuizInitial());

  final List<Widget> pages = [
    const QuizzesViewBodyWidget(),
    const TakedQuizzesViewBodyWidget(),
  ];
  int pageIndex = 0;
  List<QuizModel>? quizzesModel;
  List<TakedQuizModel>? takedQuizzesModel;

  void updatePageIndex(int index) {
    if (pageIndex != index) {
      pageIndex = index;
      emit(PageIndexChanged());
    }
  }

  Future<void> getAllQuizzes() async {
    await _fetchData(
      fetchFunction: QuizController().getAllQuizzes,
      onSuccess: (data) {
        quizzesModel = data;
        for (var qu in quizzesModel!) {
          for (var item1 in qu.questions!) {
            for (var item2 in item1.answers!) {
              log(item2.isSelected.toString());
            }
          }
        }
        quizzesModel!.isEmpty
            ? emit(GetQuizzesNotExist())
            : emit(GetQuizzesSuccess());
      },
      onFailure: (errorMessage) =>
          emit(GetQuizzesFailure(errorMessage: errorMessage)),
    );
  }

  Future<void> getAllTakedQuizzes() async {
    await _fetchData(
      fetchFunction: TakedQuizController().getAllTakedQuizzes,
      onSuccess: (data) {
        takedQuizzesModel = data;
        takedQuizzesModel!.isEmpty
            ? emit(GetTakedQuizzesNotExist())
            : emit(GetTakedQuizzesSuccess());
      },
      onFailure: (errorMessage) =>
          emit(GetTakedQuizzesFailure(errorMessage: errorMessage)),
    );
  }

  Future<void> deleteQuiz(int index) async {
    await quizzesModel![index].delete();
    quizzesModel!.removeAt(index);
    getAllQuizzes();
  }

  Future<void> deleteTakedQuiz(int index) async {
    await takedQuizzesModel![index].delete();
    takedQuizzesModel!.removeAt(index);
    getAllTakedQuizzes();
  }

  Future<void> _fetchData<T>({
    required Future<List<T>> Function() fetchFunction,
    required void Function(List<T>) onSuccess,
    required void Function(String) onFailure,
  }) async {
    try {
      final data = await fetchFunction();
      onSuccess(data);
    } catch (e) {
      onFailure("Error! on Quizzes Loading");
    }
  }
}
