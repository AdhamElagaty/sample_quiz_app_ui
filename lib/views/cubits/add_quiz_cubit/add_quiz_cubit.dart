import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_quiz_app_ui/controllers/quiz_controller.dart';
import 'package:sample_quiz_app_ui/models/models/answer_model/answer_model.dart';
import 'package:sample_quiz_app_ui/models/models/question_model/question_model.dart';
import 'package:sample_quiz_app_ui/models/models/quiz_model/quiz_model.dart';
import 'package:sample_quiz_app_ui/views/cubits/add_quiz_cubit/add_quiz_state.dart';

class AddQuizCubit extends Cubit<AddQuizState> {
  AddQuizCubit() : super(AddQuizInitial());

  final GlobalKey<FormState> formKeyQuizName = GlobalKey<FormState>();
  final quizNameController = TextEditingController();
  AutovalidateMode autovalidateModeQuizName = AutovalidateMode.disabled;
  final GlobalKey<FormState> formKeyAnswer = GlobalKey<FormState>();
  final answerController = TextEditingController();
  AutovalidateMode autovalidateModeAnswer = AutovalidateMode.disabled;
  final GlobalKey<FormState> formKeyQuestion = GlobalKey<FormState>();
  final questionController = TextEditingController();
  AutovalidateMode autovalidateModeQuestion = AutovalidateMode.disabled;

  QuizModel quizModel = QuizModel(questions: []);
  QuestionModel addQuestionModel = QuestionModel(questionText: "", answers: []);

  int? rightAnswerSelectedIndex;

  void addQuizName() {
    if (formKeyQuizName.currentState!.validate()) {
      quizModel.name = quizNameController.text;
      emit(CreateQuiz());
    } else {
      autovalidateModeQuizName = AutovalidateMode.always;
      emit(CreateQuizName());
    }
  }

  String? validateQuizNameText(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a quiz name';
    } else if (value.length < 2) {
      return 'quiz name must be at least 2 characters long';
    } else if (value.length > 20) {
      return 'quiz name must not exceed 20 characters';
    }
    return null;
  }

  String? validateAnswerText(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a Answer';
    } else if (value.length > 100) {
      return 'Answer must not exceed 100 characters';
    }
    return null;
  }

  String? validateQuestionText(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a Question';
    } else if (value.length > 200) {
      return 'Question must not exceed 100 characters';
    }
    return null;
  }

  void selectRightAnswer(int index) {
    if (rightAnswerSelectedIndex == null) {
      rightAnswerSelectedIndex = index;
    } else {
      addQuestionModel.answers![rightAnswerSelectedIndex!].isRightAnswer = null;
      rightAnswerSelectedIndex = index;
    }
    addQuestionModel.answers![index].isRightAnswer = true;
    emit(RightAnswerSelected());
  }

  void removeAnswer(int indexOfAnswer) {
    if (addQuestionModel.answers![indexOfAnswer].isRightAnswer == true) {
      addQuestionModel.answers![indexOfAnswer].isRightAnswer = false;
      rightAnswerSelectedIndex = null;
    } else if (rightAnswerSelectedIndex != null &&
        rightAnswerSelectedIndex! > indexOfAnswer) {
      rightAnswerSelectedIndex = rightAnswerSelectedIndex! - 1;
    }
    addQuestionModel.answers!.removeAt(indexOfAnswer);
    emit(AnswerRemoved());
  }

  void addAnswer() {
    if (formKeyAnswer.currentState!.validate()) {
      addQuestionModel.answers!.add(AnswerModel(
        answerText: answerController.text,
        isSelected: false,
      ));
      answerController.clear();
      autovalidateModeAnswer = AutovalidateMode.disabled;
      emit(AnswerAddedSuccess());
    } else {
      autovalidateModeAnswer = AutovalidateMode.always;
      emit(AnswerAddedFailure());
    }
  }

  void restAddQuestionBottomSheet() {
    questionController.clear();
    answerController.clear();
    rightAnswerSelectedIndex = null;
    autovalidateModeQuestion = AutovalidateMode.disabled;
    autovalidateModeAnswer = AutovalidateMode.disabled;
    addQuestionModel = QuestionModel(questionText: "", answers: []);
  }

  void addQuestion() {
    if (formKeyQuestion.currentState!.validate() &&
        addQuestionModel.answers!.length >= 2) {
      if (rightAnswerSelectedIndex != null) {
        addQuestionModel.questionText = questionController.text;
        quizModel.questions!.add(addQuestionModel);
        emit(AddQuestionSuccess());
      } else {
        emit(AddQuestionFailure(
            errorMessage: "Error! Please choose right answer"));
      }
    } else {
      autovalidateModeQuestion = AutovalidateMode.always;
      if (addQuestionModel.answers!.length < 2) {
        autovalidateModeAnswer = AutovalidateMode.always;
      }
      emit(AddQuestionFailure(errorMessage: "Error! Enter All Data Fields"));
    }
  }

  Future<void> createQuiz() async {
    try {
      await QuizController().addQuiz(quizModel);
      emit(AddQuizSuccess());
    } catch (e) {
      emit(AddQuizFailure(errorMessage: "Error! on Create new Quiz"));
    }
  }
}
