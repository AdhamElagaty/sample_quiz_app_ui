sealed class QuizState {}

final class QuizInitial extends QuizState {}

final class PageIndexChanged extends QuizState {}

final class GetQuizzesNotExist extends QuizState {}

final class GetQuizzesSuccess extends QuizState {}

final class GetQuizzesFailure extends QuizState {
  final String errorMessage;

  GetQuizzesFailure({required this.errorMessage});
}

final class GetTakedQuizzesNotExist extends QuizState {}

final class GetTakedQuizzesLoading extends QuizState {}

final class GetTakedQuizzesSuccess extends QuizState {}

final class GetTakedQuizzesFailure extends QuizState {
  final String errorMessage;

  GetTakedQuizzesFailure({required this.errorMessage});
}
