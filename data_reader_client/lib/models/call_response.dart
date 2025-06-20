
import 'package:data_reader_client/models/response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'call_response.g.dart';

@JsonSerializable()
class CallResponse {
  final String message;
  final String description;
  final String result;
  final String summarization;

  CallResponse({
    required this.message,
    required this.description,
    required this.result,
    required this.summarization
  });

  factory CallResponse.fromJson(Map<String, dynamic> json) => _$CallResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CallResponseToJson(this);

  Response toResponse() => Response(
      description: description,
      data: result,
      summarization: summarization
  );
}