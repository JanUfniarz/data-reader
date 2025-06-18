// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataRequest _$DataRequestFromJson(Map<String, dynamic> json) => DataRequest(
      name: json['table_name'] as String,
      dataset: json['dataset'] as String,
    );

Map<String, dynamic> _$DataRequestToJson(DataRequest instance) =>
    <String, dynamic>{
      'table_name': instance.name,
      'dataset': instance.dataset,
    };
