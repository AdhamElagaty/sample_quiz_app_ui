import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_quiz_app_ui/controllers/quiz_controller.dart';
import 'package:sample_quiz_app_ui/controllers/taked_quiz_controller.dart';
import 'package:sample_quiz_app_ui/models/models/answer_model/answer_model.dart';
import 'package:sample_quiz_app_ui/models/models/quiz_model/quiz_model.dart';
import 'package:sample_quiz_app_ui/models/models/taked_quiz_model/taked_quiz_model.dart';
import 'package:sample_quiz_app_ui/views/cubits/task_quiz_cubit/take_quiz_state.dart';

class TakeQuizCubit extends Cubit<TakeQuizState> {
  TakeQuizCubit() : super(TakeQuizInitial());

  final GlobalKey<FormState> formKeyName = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  AutovalidateMode autovalidateModeName = AutovalidateMode.disabled;
  QuizModel? quizModel;
  TakedQuizModel takedQuizModel = TakedQuizModel();
  bool isOutQuiz = true;
  int currentQuestionIndex = 0;
  AnswerModel? selectedAnswer;
  int? currentAnswerSelected;
  bool isExpanded = false;

  void toggleExpansion() {
    isExpanded = !isExpanded;
    emit(ExpantionOfTakedQuizChanged());
  }

  Future<void> fetchQuiz() async {
    emit(GetQuizLoading());
    final QuizModel? quiz =
        await QuizController().getQuizById(takedQuizModel.quizId!);
    if (quiz == null) {
      emit(GetQuizNotExist());
    } else {
      quizModel = quiz;
      takedQuizModel = TakedQuizModel();
      emit(TakeQuizInitial());
    }
  }

  Future<void> fetchQuizLazy(int id) async {
    emit(GetQuizLoading());
    final QuizModel? quiz = await QuizController().getLazyQuizById(id);
    if (quiz != null) {
      quizModel = quiz;
      takedQuizModel = TakedQuizModel();
    } else {
      emit(TakeQuizInitial());
    }
  }

  void startQuiz() {
    if (formKeyName.currentState!.validate()) {
      _initializeTakedQuiz();
      emit(SolveQuestion());
    } else {
      autovalidateModeName = AutovalidateMode.always;
      emit(ErrorInNameValidation());
    }
  }

  void _initializeTakedQuiz() async {
    takedQuizModel
      ..personName = nameController.text
      ..dateTime = DateTime.now().toString()
      ..score = 0
      ..quizId = quizModel!.key
      ..quiz = quizModel;
    isOutQuiz = false;
    currentQuestionIndex = 0;
    currentAnswerSelected = null;
  }

  void nextQuestion() async {
    _updateScoreIfCorrect();
    _resetAnswerSelection();

    if (currentQuestionIndex + 1 == quizModel!.questions!.length) {
      await _completeQuiz();
    } else {
      currentQuestionIndex++;
      emit(ChangeQuestion());
    }
  }

  void _updateScoreIfCorrect() {
    if (selectedAnswer?.isRightAnswer == true) {
      takedQuizModel.score = (takedQuizModel.score ?? 0) + 1;
    }
  }

  void _resetAnswerSelection() {
    selectedAnswer = null;
    currentAnswerSelected = null;
  }

  Future<void> _completeQuiz() async {
    isOutQuiz = true;
    quizModel = await QuizController().getQuizById(quizModel!.key);
    await TakedQuizController().addTakedQuiz(takedQuizModel);
    emit(CompleteQuiz());
  }

  String? validateNameText(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter Your Name';
    } else if (value.length > 50) {
      return 'Name must not exceed 50 characters';
    }
    return null;
  }

  void selectAnswer(AnswerModel? answerModel, int index) {
    if (currentAnswerSelected != null) {
      _resetPreviousSelection();
    }
    _setSelectedAnswer(answerModel, index);
    emit(SelectAnswerChanged());
  }

  void _resetPreviousSelection() {
    takedQuizModel.quiz!.questions![currentQuestionIndex]
        .answers![currentAnswerSelected!].isSelected = null;
  }

  void _setSelectedAnswer(AnswerModel? answerModel, int index) {
    currentAnswerSelected = index;
    selectedAnswer = answerModel;
    takedQuizModel.quiz!.questions![currentQuestionIndex].answers![index]
        .isSelected = true;
  }

  void viewAnswers() {
    currentQuestionIndex = 0;
    emit(ViewRightAnswersQuiz());
  }

  void nextAnswer() {
    if (currentQuestionIndex + 1 == takedQuizModel.quiz!.questions!.length) {
      currentQuestionIndex = 0;
      emit(CloseQuiz());
    } else {
      currentQuestionIndex++;
      emit(GetNextOrLastRightAnswer());
    }
  }

  void previousAnswer() {
    if (currentQuestionIndex > 0) {
      currentQuestionIndex--;
      emit(GetNextOrLastRightAnswer());
    }
  }
}
