// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Anuncio.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnuncioAdapter extends TypeAdapter<Anuncio> {
  @override
  final int typeId = 1;

  @override
  Anuncio read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Anuncio(
      imagenUrl: fields[0] as String,
      titulo: fields[1] as String,
      fecha: fields[2] as DateTime,
      descripcion: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Anuncio obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.imagenUrl)
      ..writeByte(1)
      ..write(obj.titulo)
      ..writeByte(2)
      ..write(obj.fecha)
      ..writeByte(3)
      ..write(obj.descripcion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnuncioAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
