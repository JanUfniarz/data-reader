// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CallResponse _$CallResponseFromJson(Map<String, dynamic> json) => CallResponse(
      message: json['message'] as String,
      description: json['description'] as String,
      result: json['result'] as String,
      summarization: json['summarization'] as String,
    );

Map<String, dynamic> _$CallResponseToJson(CallResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'description': instance.description,
      'result': instance.result,
      'summarization': instance.summarization,
    };
