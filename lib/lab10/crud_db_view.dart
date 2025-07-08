import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'crud_db_controller.dart';

class StudentView extends StatelessWidget {
  final StudentController controller = Get.put(StudentController());
  final TextEditingController inputController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  StudentView({super.key});

  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 50 &&
          controller.hasMore.value &&
          !controller.isFetchingMore.value &&
          controller.searchQuery.value.isEmpty) {
        controller.fetchStudents(reset: false);
      }
    });

    return Scaffold(
      appBar: AppBar(title: Text('Student Manager')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          inputController.text = controller.nameController.value;
          inputController.selection = TextSelection.fromPosition(
            TextPosition(offset: inputController.text.length),
          );

          return Column(
            children: [
              TextField(
                onChanged: controller.searchQuery,
                decoration: InputDecoration(
                  hintText: 'Search students...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: inputController,
                      decoration: InputDecoration(
                        labelText: 'Enter name',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (val) => controller.nameController.value = val,
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      controller.saveStudent(inputController.text);
                      inputController.clear();
                    },
                    child: Text(controller.selectedId == null ? 'Add' : 'Update'),
                  )
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: controller.students.length + 1,
                  itemBuilder: (_, index) {
                    if (index < controller.students.length) {
                      final student = controller.students[index];
                      return ListTile(
                        title: Text(student.name),
                        onTap: () {
                          controller.selectStudent(student.id!, student.name);
                        },
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            controller.deleteStudent(student.id!);
                          },
                        ),
                      );
                    } else {
                      return controller.hasMore.value
                          ? Center(child: Padding(
                        padding: EdgeInsets.all(12),
                        child: CircularProgressIndicator(),
                      ))
                          : SizedBox();
                    }
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
