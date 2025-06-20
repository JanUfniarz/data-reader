import 'dart:convert';

import 'package:data_reader_client/models/call_response.dart';
import 'package:data_reader_client/models/data_request.dart';

import "package:http/http.dart";

class Connector {
  final String path;

  Connector(this.path);

  void sendDataset(DataRequest request) => _apiCall('data', request.toJson());

  Future<CallResponse> analyze(String prompt, int sid) async => CallResponse
      .fromJson((jsonDecode((await _apiCall('analyze', {
        'prompt': prompt,
        'sid': sid
      })).body)));

  Future<Response> _apiCall(String endpoint, Map<String, dynamic> body) => post(
      Uri.parse('$path/$endpoint/'),
      body: jsonEncode(body),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
      }
  );
}