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
      id: fields[0] as int?,
      personName: fields[1] as String,
      dateTime: fields[2] as String,
      quizId: fields[3] as int?,
      quiz: fields[4] as QuizModel,
    );
  }

  @override
  void write(BinaryWriter writer, TakedQuizModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.personName)
      ..writeByte(2)
      ..write(obj.dateTime)
      ..writeByte(3)
      ..write(obj.quizId)
      ..writeByte(4)
      ..write(obj.quiz);
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
