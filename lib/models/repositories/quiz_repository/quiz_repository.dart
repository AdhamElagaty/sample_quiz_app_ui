import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:sample_quiz_app_ui/models/models/quiz_model/quiz_model.dart';
import 'package:sample_quiz_app_ui/models/repositories/quiz_repository/iquiz_repository.dart';
import 'package:sample_quiz_app_ui/utils/constants.dart';

class QuizRepository implements IQuizRepository {
  Box<QuizModel>? _quizBox;
  LazyBox<QuizModel>? _lazyQuizBox;

  QuizRepository();

  Future<void> _openBox({required bool lazy}) async {
    if (lazy) {
      await _closeBoxe();
      if (_lazyQuizBox == null || !_lazyQuizBox!.isOpen) {
        _lazyQuizBox = await Hive.openLazyBox<QuizModel>(kQuizBox);
      }
    } else {
      await _closeLazyBoxe();
      if (_quizBox == null || !_quizBox!.isOpen) {
        _quizBox = await Hive.openBox<QuizModel>(kQuizBox);
      }
    }
  }

  Future<void> _closeBoxe() async {
    try {
      _quizBox = Hive.box(kQuizBox);
      if (_quizBox!.isOpen) {
        await _quizBox!.close();
        _quizBox = null;
      }
    } catch (e) {
      log('Error closing boxes: $e');
    }
  }

  Future<void> _closeLazyBoxe() async {
    try {
      _lazyQuizBox = Hive.lazyBox(kQuizBox);
      if (_lazyQuizBox!.isOpen) {
        await _lazyQuizBox!.close();
        _lazyQuizBox = null;
      }
    } catch (e) {
      log('Error closing lazy boxes: $e');
    }
  }

  @override
  Future<void> addQuiz(QuizModel quiz) async {
    await _openBox(lazy: false);
    await _quizBox!.add(quiz);
  }

  @override
  Future<void> updateQuiz(QuizModel quiz) async {
    await _openBox(lazy: false);
    await quiz.save();
  }

  @override
  Future<void> deleteQuiz(int id) async {
    await _openBox(lazy: false);
    await _quizBox!.delete(id);
  }

  @override
  Future<List<QuizModel>> getAllQuizzes() async {
    await _openBox(lazy: false);
    return _quizBox!.values.toList();
  }

  @override
  Future<QuizModel?> getQuizById(int id) async {
    await _openBox(lazy: false);
    return _quizBox!.get(id);
  }

  @override
  Future<QuizModel?> getLazyQuizById(int id) async {
    await _openBox(lazy: true);
    return await _lazyQuizBox!.get(id);
  }
}
