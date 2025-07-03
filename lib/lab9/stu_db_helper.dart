import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'stu_model.dart';

class DBHelper {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  static Future<Database> initDb() async {
    String path = join(await getDatabasesPath(), 'Student.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE TBL_Student (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        lastName TEXT,
        enrollmentNo TEXT,
        email TEXT,
        phoneNumber TEXT,
        branch TEXT,
        cgpa REAL,
        priorEducationCgpa REAL,
        isD2D INTEGER
      )
    ''');
  }

  static Future<int> insertStudent(Student student) async {
    final db = await database;
    return await db.insert('TBL_Student', student.toMap());
  }

  static Future<List<Student>> getStudents() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('TBL_Student');
    return List.generate(maps.length, (i) => Student.fromMap(maps[i]));
  }

  static Future<int> updateStudent(Student student) async {
    final db = await database;
    return await db.update(
      'TBL_Student',
      student.toMap(),
      where: 'id = ?',
      whereArgs: [student.id],
    );
  }

  static Future<int> deleteStudent(int id) async {
    final db = await database;
    return await db.delete(
      'TBL_Student',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}
