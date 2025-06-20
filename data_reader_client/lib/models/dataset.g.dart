// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dataset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dataset _$DatasetFromJson(Map<String, dynamic> json) => Dataset(
      name: json['table_name'] as String,
      data: json['data'] as String,
      id: (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DatasetToJson(Dataset instance) => <String, dynamic>{
      'id': instance.id,
      'table_name': instance.name,
      'data': instance.data,
    };
