import 'package:hive/hive.dart';
import 'package:sample_quiz_app_ui/models/models/answer_model/answer_model.dart';

part 'question_model.g.dart';

@HiveType(typeId: 1)
class QuestionModel extends HiveObject {
  @HiveField(0)
  int? id; // Make id nullable and not final

  @HiveField(1)
  final String questionText;

  @HiveField(2)
  final List<AnswerModel>? answers;

  @HiveField(3)
  final int? quizId;

  QuestionModel({
    this.id, // Remove id from the required parameters
    required this.questionText,
    this.answers,
    this.quizId,
  });
}