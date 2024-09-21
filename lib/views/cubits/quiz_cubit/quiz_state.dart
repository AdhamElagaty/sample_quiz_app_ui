sealed class QuizState {}

final class QuizInitial extends QuizState {}

final class PageIndexChanged extends QuizState {}

final class GetQuizzesNotExist extends QuizState {}

final class GetQuizzesSuccess extends QuizState {}

final class GetQuizzesFailure extends QuizState {
  final String errorMessage;

  GetQuizzesFailure({required this.errorMessage});
}
