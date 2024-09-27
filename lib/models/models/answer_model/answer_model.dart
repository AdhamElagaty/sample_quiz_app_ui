import 'package:hive/hive.dart';

part 'answer_model.g.dart';

@HiveType(typeId: 0)
class AnswerModel extends HiveObject {
  @HiveField(0)
  String answerText;

  @HiveField(1)
  bool? isRightAnswer;

  @HiveField(2)
  bool? isSelected;

  AnswerModel({
    required this.answerText,
    this.isSelected,
  });
}
