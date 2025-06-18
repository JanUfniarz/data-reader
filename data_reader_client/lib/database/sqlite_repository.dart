import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// language=SQLITE-SQL
class SQLiteRepository {
  final String _datasetStructure = '''
          CREATE TABLE dataset (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              table_name TEXT NOT NULL,
              data TEXT NOT NULL
          );
        ''';

  final String _responseStructure = '''
          CREATE TABLE response (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              description TEXT NOT NULL,
              data TEXT NOT NULL,
              dataset_id INTEGER NOT NULL,
              FOREIGN KEY (dataset_id) REFERENCES dataset (id) ON DELETE CASCADE
          );
        ''';

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
        await db.execute(_datasetStructure);
        await db.execute(_responseStructure);
      },
    );
  }
}