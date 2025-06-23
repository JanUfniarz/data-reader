import 'package:data_reader_client/database/dataset_dao.dart';
import 'package:data_reader_client/logic/connector.dart';
import 'package:data_reader_client/logic/get_session_id.dart';
import 'package:data_reader_client/main.dart';
import 'package:data_reader_client/models/dataset.dart';
import 'package:data_reader_client/models/response.dart';
import 'package:data_reader_client/widgets/dataset_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppController extends ChangeNotifier {
  final DatasetDao dao;
  final Connector connector;

  AppController({required this.dao, required this.connector}) {
    loadData();
  }

  factory AppController.of(BuildContext context, {bool listen = false}) => listen
      ? context.watch<AppController>()
      : context.read<AppController>();

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
    Response response = (await connector.analyze(prompt, getSID())).toResponse();
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