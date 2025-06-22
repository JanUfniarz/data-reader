import 'package:data_reader_client/database/dataset_dao.dart';
import 'package:data_reader_client/logic/app_controller.dart';
import 'package:data_reader_client/logic/connector.dart';
import 'package:data_reader_client/style/default_theme.dart';
import 'package:data_reader_client/widgets/reader_client.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

main() => runApp(ChangeNotifierProvider<AppController>(
  create: (_) => AppController(
      dao: DatasetDao(), 
      connector: Connector("path")
  ),
  child: MaterialApp(
    theme: defaultTheme,
    home: const ReaderClient(),
  ),
));