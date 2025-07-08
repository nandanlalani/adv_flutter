import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'crud_db_model.dart';

class DBService {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  Future<Database> initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'Student.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE students (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertStudent(Student student) async {
    final dbClient = await db;
    return await dbClient.insert('students', student.toMap());
  }

  Future<List<Student>> getStudents() async {
    final dbClient = await db;
    final res = await dbClient.query('students');
    return res.map((e) => Student.fromMap(e)).toList();
  }

  Future<int> updateStudent(Student student) async {
    final dbClient = await db;
    return await dbClient.update(
      'students',
      student.toMap(),
      where: 'id = ?',
      whereArgs: [student.id],
    );
  }

  Future<int> deleteStudent(int id) async {
    final dbClient = await db;
    return await dbClient.delete(
      'students',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Student>> searchStudents(String query) async {
    final dbClient = await db;
    final res = await dbClient.query(
      'students',
      where: 'name LIKE ?',
      whereArgs: ['%$query%'],
    );
    return res.map((e) => Student.fromMap(e)).toList();
  }

  Future<List<Student>> getStudentsPaginated(int offset, int limit) async {
    final dbClient = await db;
    final res = await dbClient.query(
      'students',
      offset: offset,
      limit: limit,
      orderBy: 'id DESC',
    );
    return res.map((e) => Student.fromMap(e)).toList();
  }
}
