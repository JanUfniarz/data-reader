import 'package:data_reader_client/models/data_request.dart';
import 'package:data_reader_client/models/response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dataset.g.dart';

@JsonSerializable()
class Dataset {
  @JsonKey(
      includeFromJson: false,
      includeToJson: false
  )
  // language=SQLITE-SQL
  static const String structure = '''
          CREATE TABLE dataset (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              table_name TEXT NOT NULL,
              data TEXT NOT NULL
          );
        ''';

  int? id;

  @JsonKey(name: 'table_name')
  String name;

  String data;

  @JsonKey(
      includeFromJson: false,
      includeToJson: false
  )
  List<Response> responses = [];

  Dataset({required this.name, required this.data, this.id});

  factory Dataset.fromJson(Map<String, dynamic> json) => _$DatasetFromJson(json);
  Map<String, dynamic> toJson() => _$DatasetToJson(this);

  DataRequest toRequest() => DataRequest(
      name: name,
      dataset: data
  ) ;
}