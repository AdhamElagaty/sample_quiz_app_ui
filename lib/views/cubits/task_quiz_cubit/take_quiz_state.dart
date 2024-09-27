sealed class TakeQuizState {}

final class TakeQuizInitial extends TakeQuizState {}

final class SolveQuestion extends TakeQuizState {}

final class ErrorInNameValidation extends TakeQuizState {}

final class CompleteQuiz extends TakeQuizState {}

final class ViewRightAnswersQuiz extends TakeQuizState {}

final class SelectAnswerChanged extends TakeQuizState {}

final class ChangeQuestion extends TakeQuizState {}

final class GetNextOrLastRightAnswer extends TakeQuizState {}

final class CloseQuiz extends TakeQuizState {}

final class ExpantionOfTakedQuizChanged extends TakeQuizState {}

final class GetQuizLoading extends TakeQuizState {}

final class GetQuizNotExist extends TakeQuizState {}

final class GetQuizFinish extends TakeQuizState {}
