import 'package:hive/hive.dart';

part 'answer_model.g.dart';

@HiveType(typeId: 0)
class AnswerModel extends HiveObject {
  @HiveField(0)
  int? id; // Make id nullable and not final

  @HiveField(1)
  String answerText;

  @HiveField(2)
  int? questionId;

  AnswerModel({
    this.id, // Remove id from the required parameters
    required this.answerText,
    this.questionId,
  });
}
