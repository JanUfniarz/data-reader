import 'package:json_annotation/json_annotation.dart';

import '../logic/get_session_id.dart';

part 'data_request.g.dart';

@JsonSerializable()
class DataRequest {

  @JsonKey(name: 'table_name')
  final String name;
  final String dataset;
  final String sid = getSID();

  DataRequest({required this.name, required this.dataset});

  factory DataRequest.fromJson(Map<String, dynamic> json) => _$DataRequestFromJson(json);
  Map<String, dynamic> toJson() => _$DataRequestToJson(this);
}