// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Response _$ResponseFromJson(Map<String, dynamic> json) => Response(
      description: json['description'] as String,
      data: json['data'] as String,
      summarization: json['summarization'] as String,
      id: (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ResponseToJson(Response instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'data': instance.data,
      'summarization': instance.summarization,
    };
