import 'package:hive/hive.dart';
import 'package:sample_quiz_app_ui/models/models/answer_model/answer_model.dart';

part 'question_model.g.dart';

@HiveType(typeId: 1)
class QuestionModel extends HiveObject {
  @HiveField(0)
  String questionText;

  @HiveField(1)
  List<AnswerModel>? answers;

  QuestionModel({
    required this.questionText,
    this.answers,
  });
}
