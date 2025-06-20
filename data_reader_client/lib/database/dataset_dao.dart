// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:data_reader_client/database/dataset_repository.dart';
import 'package:data_reader_client/models/dataset.dart';
import 'package:data_reader_client/models/response.dart';


class DatasetDao extends DatasetRepository {
  Future<Map<int, String>> getNames() async => Map
      .fromEntries((await (await database)
        .query('dataset', columns: ['id', 'table_name'])
      ).map((el) => MapEntry(
        el['id']! as int,
        el['table_name'] as String
      )));

  Future<List<Dataset>> getAll() async {
    var db = await database;

    var datasets = Map.fromEntries(
        (await db.query('dataset'))
            .map((raw) => MapEntry(raw['id'], Dataset.fromJson(raw)))
    );

    for (var raw in await db.query('response'))
      datasets[raw['dataset_id']]!.responses
          .add(Response.fromJson(raw));

    return datasets.values.toList();
  }

  Future<Dataset> insertDataset(Dataset dataset) async => dataset
    ..id = await (await database).insert('dataset', dataset.toJson());

  Future<Response> insertResponse(
      Response response, {required int datasetId}
  ) async => response..id = await (await database)
      .insert('response', response.toJson()..['dataset_id'] = datasetId);

  void deleteDataset(int id) async => (await database)
      .delete('dataset', where: 'id = ?', whereArgs: [id]);

  void deleteResponse(int id) async => (await database)
      .delete('response', where: 'id = ?', whereArgs: [id]);
}