import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'data_model.dart';

class MyDatabase {
  Future<Database> initDatabase() async {
    Directory directory = await getApplicationCacheDirectory();
    String path = join(directory.path, 'cureOption.db');
    var db = await openDatabase(path, onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE TBL_USER(
            uid INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
          )
        ''');
    }, onUpgrade: (db, oldVersion, newVersion) {}, version: 1);
    return db;
  }

  Future<int> insertUser(UserModel user) async {
    final db = await initDatabase();
    return await db.insert('TBL_USER', user.toMap());
  }

  Future<List<UserModel>> getUsers() async {
    final db = await initDatabase();
    final List<Map<String, dynamic>> maps = await db.query('TBL_USER');
    return maps.map((e) => UserModel.fromMap(e)).toList();
  }

  Future<int> updateUser(UserModel user) async {
    final db = await initDatabase();
    return await db.update('TBL_USER', user.toMap(), where: 'uid = ?', whereArgs: [user.uid]);
  }

  Future<int> deleteUser(int uid) async {
    final db = await initDatabase();
    return await db.delete('TBL_USER', where: 'uid = ?', whereArgs: [uid]);
  }
}