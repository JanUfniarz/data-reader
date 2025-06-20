import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/dataset.dart';
import '../models/response.dart';

class DatasetRepository {
  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    var dbPath = await getDatabasesPath();
    // uncomment to rebuild
    //! await deleteDatabase(join(dbPath, 'data_reader.db'));

    return await openDatabase(
      join(dbPath, 'data_reader.db'),
      version: 1,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
      onCreate: (db, version) async {
        await db.execute(Dataset.structure);
        await db.execute(Response.structure);
      },
    );
  }
}