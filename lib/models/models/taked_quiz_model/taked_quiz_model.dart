import 'package:hive/hive.dart';
import 'package:sample_quiz_app_ui/models/models/quiz_model/quiz_model.dart';

part 'taked_quiz_model.g.dart';

@HiveType(typeId: 3)
class TakedQuizModel extends HiveObject {
  @HiveField(0)
  String? personName;

  @HiveField(1)
  String? dateTime;

  @HiveField(2)
  int? quizId;

  @HiveField(3)
  QuizModel? quiz;

  @HiveField(4)
  int? score;

  TakedQuizModel({
    this.personName,
    this.dateTime,
    this.quizId,
    this.quiz,
    this.score,
  });
}
