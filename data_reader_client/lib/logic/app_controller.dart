import 'package:data_reader_client/database/dataset_dao.dart';
import 'package:data_reader_client/logic/connector.dart';
import 'package:data_reader_client/models/dataset.dart';
import 'package:data_reader_client/models/response.dart';
import 'package:data_reader_client/widgets/dataset_view.dart';
import 'package:flutter/material.dart';

class AppController extends ChangeNotifier {
  final DatasetDao dao;
  final Connector connector;

  AppController({required this.dao, required this.connector}) {
    loadData();
  }

  List<Dataset>? sets;
  Map<int, String>? names;

  void loadData() {
    dao.getNames().then((names) {
      this.names = names;
      notifyListeners();
    });
    dao.getAll().then((sets) {
      this.sets = sets;
      notifyListeners();
    });
  }

  void addDataset(String name, String data, BuildContext context) async {
    Dataset dataset = Dataset(
        name: name,
        data: data
    );
    dataset = await dao.insertDataset(dataset);
    sets!.add(dataset);
    notifyListeners();
    openDataset(dataset, context);
  }

  void openDataset(Dataset dataset, BuildContext context) {
    connector.sendDataset(dataset.toRequest());
    Navigator.push<void>(context, MaterialPageRoute(
        builder: (context) => const DatasetView()
    )).then((_) => notifyListeners());
  }

  void ask(String prompt, Dataset dataset) async {
    Response response = (await connector.analyze(prompt)).toResponse();
    dataset.responses.add(
        await dao.insertResponse(response, datasetId: dataset.id!)
    );
    notifyListeners();
  }

  void removeDataset(Dataset dataset) {
    dao.deleteDataset(dataset.id!);
    notifyListeners();
  }

  void removeResponse(Response response) {
    dao.deleteResponse(response.id!);
    notifyListeners();
  }
}