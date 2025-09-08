import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'medicamentos.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );

    return _database!;
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE medicamentos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL
      )
    ''');
  }

  Future<List<Map<String, dynamic>>> getMedicamentos() async {
    final db = await database;
    return await db.query('medicamentos');
  }

  Future<int> addMedicamento(String nome) async {
    final db = await database;
    return await db.insert('medicamentos', {'nome': nome});
  }

  Future<int> deleteMedicamento(int id) async {
    final db = await database;
    return await db.delete('medicamentos', where: 'id = ?', whereArgs: [id]);
  }
}
