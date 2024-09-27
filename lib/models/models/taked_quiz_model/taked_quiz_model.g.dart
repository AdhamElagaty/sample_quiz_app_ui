// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taked_quiz_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TakedQuizModelAdapter extends TypeAdapter<TakedQuizModel> {
  @override
  final int typeId = 3;

  @override
  TakedQuizModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TakedQuizModel(
      personName: fields[0] as String?,
      dateTime: fields[1] as String?,
      quizId: fields[2] as int?,
      quiz: fields[3] as QuizModel?,
      score: fields[4] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, TakedQuizModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.personName)
      ..writeByte(1)
      ..write(obj.dateTime)
      ..writeByte(2)
      ..write(obj.quizId)
      ..writeByte(3)
      ..write(obj.quiz)
      ..writeByte(4)
      ..write(obj.score);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TakedQuizModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
