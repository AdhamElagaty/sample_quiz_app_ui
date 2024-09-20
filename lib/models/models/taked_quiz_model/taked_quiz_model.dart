import 'package:hive/hive.dart';
import 'package:sample_quiz_app_ui/models/models/quiz_model/quiz_model.dart';

part 'taked_quiz_model.g.dart';

@HiveType(typeId: 3)
class TakedQuizModel extends HiveObject {
  @HiveField(0)
  int? id; // Make id nullable and not final

  @HiveField(1)
  String personName;

  @HiveField(2)
  String dateTime;

  @HiveField(3)
  int? quizId;

  @HiveField(4)
  QuizModel quiz;

  TakedQuizModel({
    this.id, // Remove id from the required parameters
    required this.personName,
    required this.dateTime,
    this.quizId,
    required this.quiz,
  });
}
