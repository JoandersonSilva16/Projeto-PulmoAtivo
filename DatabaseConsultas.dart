import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseHelperConsultas {
  static final DatabaseHelperConsultas instance = DatabaseHelperConsultas._init();
  static Database? _database;
  DatabaseHelperConsultas._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'consultas.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );

    return _database!;
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE consultas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        data TEXT NOT NULL,
        nome TEXT NOT NULL,
        especialidade TEXT NOT NULL,
        hora TEXT NOT NULL
      )
    ''');
  }

  Future<List<Map<String, dynamic>>> getConsultas() async {
    final db = await database;
    return await db.query('consultas', orderBy: 'id DESC');
  }

  Future<int> addConsulta(Map<String, dynamic> consulta) async {
    final db = await database;
    return await db.insert('consultas', consulta);
  }

  Future<int> deleteConsulta(int id) async {
    final db = await database;
    return await db.delete('consultas', where: 'id = ?', whereArgs: [id]);
  }
}

