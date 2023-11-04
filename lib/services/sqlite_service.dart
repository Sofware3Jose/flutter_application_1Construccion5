import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/mercancia_model.dart'; 


class SQLiteService {
  static Database? _database;

  // Singleton: Única instancia de la clase
  static final SQLiteService db = SQLiteService._();

  SQLiteService._();

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDB();

    return _database;
  }

  Future<Database> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'claseSQLite.db');
    print('Ruta base de datos');
    print(path);

    return await openDatabase(
      path,
      version: 6,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE mercancias ( 
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            precio DECIMAL(10,2)
          )
        ''');
      },
    );
  }

  // Insertar registros
  Future<int> insertMercancia(MercanciaModel mercancia) async {
    final db = await database;

    final res = await db!.insert('mercancias', mercancia.toJson());

    return res;
  }

  // Actualizar registros
  Future<int> updateMercancia(MercanciaModel mercancia) async {
    final db = await database;

    final res = await db!.update(
      'mercancias',
      mercancia.toJson(),
      where: 'id = ?',
      whereArgs: [mercancia.id],
    );

    return res;
  }

  // Borrar un registro
  Future<int> deleteMercancia(int id) async {
    final db = await database;

    final res = await db!.delete(
      'mercancias',
      where: 'id = ?',
      whereArgs: [id],
    );

    return res;
  }

  // Consultar todos los registros
  Future<List<MercanciaModel>> getAllMercancias() async {
    final db = await database;

    final res = await db!.query('mercancias');

    List<MercanciaModel> list =
        res.isNotEmpty ? res.map((e) => MercanciaModel.fromJson(e)).toList() : [];

    return list;
  }

  // Consultar un registro
  Future<MercanciaModel?> getMercanciaById(int id) async {
    final db = await database;

    final res = await db!.query(
      'mercancias',
      where: 'id = ?',
      whereArgs: [id],
    );

    return res.isNotEmpty ? MercanciaModel.fromJson(res.first) : null;
  }
}
