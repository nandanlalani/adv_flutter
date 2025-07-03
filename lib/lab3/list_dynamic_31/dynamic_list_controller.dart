import 'package:adv_flutt/lab3/list_dynamic_31/dynamic_list_model.dart';

class DynamicListController {
  List<Students> students = [];

  void addStudent(dynamic data) {
    students.add(Students(name: data));
    print("data added $data");
  }

  void updateStudent(int index, dynamic data) {
    students[index] = Students(name: data);
    print("data Updated $data");
  }

  void deleteStudent(int index) {
    students.removeAt(index);
    print("Data deleted at $index");
  }

  List<dynamic> getAll() {
    return students;
  }
}
