import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_quiz_app_ui/controllers/taked_quiz_controller.dart';
import 'package:sample_quiz_app_ui/models/models/answer_model/answer_model.dart';
import 'package:sample_quiz_app_ui/models/models/quiz_model/quiz_model.dart';
import 'package:sample_quiz_app_ui/models/models/taked_quiz_model/taked_quiz_model.dart';
import 'package:sample_quiz_app_ui/views/cubits/task_quiz_cubit/task_quiz_state.dart';

class TakeQuizCubit extends Cubit<TakeQuizState> {
  TakeQuizCubit({required this.quizModel}) : super(TakeQuizInitial());

  final GlobalKey<FormState> formKeyName = GlobalKey<FormState>();
  final nameController = TextEditingController();
  AutovalidateMode autovalidateModeName = AutovalidateMode.disabled;
  final QuizModel quizModel;
  TakedQuizModel takedQuizModel = TakedQuizModel();
  bool isOutQuiz = true;
  int currentQuestionIndex = 0;
  AnswerModel? selectedAnswer;

  void startQuiz() {
    if (formKeyName.currentState!.validate()) {
      takedQuizModel.personName = nameController.text;
      takedQuizModel.dateTime = DateTime.now().toString();
      takedQuizModel.score = 0;
      takedQuizModel.quizId = quizModel.key;
      takedQuizModel.quiz = quizModel;
      isOutQuiz = false;
      emit(SolveQuestion());
    } else {
      autovalidateModeName = AutovalidateMode.always;
      emit(TakeQuizInitial());
    }
  }

  void getNextQuestion() async {
    if (selectedAnswer!.isRightAnswer != null &&
        selectedAnswer!.isRightAnswer!) {
      takedQuizModel.score = (takedQuizModel.score ?? 0) + 1;
    }
    selectedAnswer = null;
    if (quizModel.questions!.length == currentQuestionIndex + 1) {
      isOutQuiz = true;
      await TakedQuizController().addTakedQuiz(takedQuizModel);
      emit(CompleteQuiz());
    } else {
      currentQuestionIndex++;
      emit(ChangeQuestion());
    }
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
    takedQuizModel.quiz!.questions![currentQuestionIndex].answers![index]
        .isSelected = null;
    takedQuizModel.quiz!.questions![currentQuestionIndex].answers![index]
        .isSelected = true;
    selectedAnswer =
        takedQuizModel.quiz!.questions![currentQuestionIndex].answers![index];
    emit(SelectAnswerChanged());
  }

  void goToAnswers() {
    currentQuestionIndex = 0;
    emit(ViewRightAnswersQuiz());
  }

  void getNextAnswer() async {
    if (quizModel.questions!.length == currentQuestionIndex + 1) {
      emit(CloseQuiz());
    } else {
      currentQuestionIndex++;
      emit(GetNextOrLastRightAnswer());
    }
  }

  void getLastAnswer() async {
    if (currentQuestionIndex != 0) {
      currentQuestionIndex--;
      emit(GetNextOrLastRightAnswer());
    }
  }
}
