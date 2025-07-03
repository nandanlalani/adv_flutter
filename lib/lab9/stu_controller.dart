import 'package:get/get.dart';
import 'stu_model.dart';
import 'stu_db_helper.dart';

class StudentController extends GetxController {
  RxList<Student> studentList = <Student>[].obs;

  @override
  void onInit() {
    fetchStudents();
    super.onInit();
  }

  void fetchStudents() async {
    var students = await DBHelper.getStudents();
    studentList.assignAll(students);
  }

  Future<void> addStudent(Student student) async {
    await DBHelper.insertStudent(student);
    fetchStudents();
  }

  Future<void> updateStudent(Student student) async {
    await DBHelper.updateStudent(student);
    fetchStudents();
  }

  Future<void> deleteStudent(int id) async {
    await DBHelper.deleteStudent(id);
    fetchStudents();
  }

}
