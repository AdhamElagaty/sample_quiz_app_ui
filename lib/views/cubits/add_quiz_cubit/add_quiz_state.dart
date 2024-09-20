sealed class AddQuizState {}

final class AddQuizInitial extends AddQuizState {}

final class AddQuizSuccess extends AddQuizState {}

final class AddQuizFailure extends AddQuizState {
  final String errorMessage;

  AddQuizFailure({required this.errorMessage});
}

final class CreateQuiz extends AddQuizState {}

final class CreateQuizName extends AddQuizState {}

final class RightAnswerSelected extends AddQuizState {}

final class AnswerRemoved extends AddQuizState {}

final class AnswerAddedSuccess extends AddQuizState {}

final class AnswerAddedFailure extends AddQuizState {}

final class AddQuestionSuccess extends AddQuizState {}

final class AddQuestionFailure extends AddQuizState {
  final String errorMessage;

  AddQuestionFailure({required this.errorMessage});
}
