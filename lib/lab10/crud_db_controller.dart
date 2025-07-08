import 'package:get/get.dart';
import 'crud_db_model.dart';
import 'db_help.dart';

class StudentController extends GetxController {
  var students = <Student>[].obs;
  var nameController = ''.obs;
  RxInt? selectedId;

  final DBService dbService = DBService();

  var searchQuery = ''.obs;

  int limit = 10;
  int offset = 0;
  var isFetchingMore = false.obs;
  var hasMore = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchStudents();
    debounce(searchQuery, (_) => searchStudents(), time: Duration(milliseconds: 300));
  }

  void fetchStudents({bool reset = true}) async {
    if (reset) {
      students.clear();
      offset = 0;
      hasMore(true);
    }

    isFetchingMore(true);
    final newStudents = await dbService.getStudentsPaginated(offset, limit);
    students.addAll(newStudents);
    offset += newStudents.length;
    if (newStudents.length < limit) hasMore(false);
    isFetchingMore(false);
  }

  void searchStudents() async {
    if (searchQuery.value.trim().isEmpty) {
      fetchStudents();
      return;
    }

    final results = await dbService.searchStudents(searchQuery.value);
    students.assignAll(results);
    hasMore(false);
  }

  void saveStudent(String name) async {
    if (name.trim().isEmpty) return;

    if (selectedId == null) {
      await dbService.insertStudent(Student(name: name));
    } else {
      await dbService.updateStudent(Student(id: selectedId!.value, name: name));
      selectedId = null;
    }

    nameController.value = '';
    fetchStudents();
  }

  void deleteStudent(int id) async {
    await dbService.deleteStudent(id);
    fetchStudents();
    clearSelection();
  }

  void selectStudent(int id, String name) {
    selectedId = RxInt(id);
    nameController.value = name;
  }

  void clearSelection() {
    selectedId = null;
    nameController.value = '';
  }
}
