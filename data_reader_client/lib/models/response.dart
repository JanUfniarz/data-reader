import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

@JsonSerializable()
class Response {
  @JsonKey(
    includeToJson: false,
    includeFromJson: false
  )
  // language=SQLITE-SQL
  static const String structure = '''
          CREATE TABLE response (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              description TEXT NOT NULL,
              data TEXT NOT NULL,
              dataset_id INTEGER NOT NULL,
              FOREIGN KEY (dataset_id) REFERENCES dataset (id) ON DELETE CASCADE
          );
        ''';

  int? id;

  String description;

  String data;

  String summarization;

  Response({
    required this.description,
    required this.data,
    required this.summarization,
    this.id
  });

  factory Response.fromJson(Map<String, dynamic> json) => _$ResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseToJson(this);
}