import 'package:hive/hive.dart';
import 'package:sample_quiz_app_ui/models/models/question_model/question_model.dart';

part 'quiz_model.g.dart';

@HiveType(typeId: 2)
class QuizModel extends HiveObject {
  @HiveField(0)
  int? id; // Make id nullable and not final

  @HiveField(1)
  final List<QuestionModel>? questions;

  QuizModel({
    this.id, // Remove id from the required parameters
    this.questions,
  });
}
